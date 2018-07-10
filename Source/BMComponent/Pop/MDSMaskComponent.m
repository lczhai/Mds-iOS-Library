//
//  MDSMaskComponent.m
//  Pods
//
//  Created by jony on 2018/4/27.
//
//

#import "MDSMaskComponent.h"
#import "MDSPopupComponent.h"
#import "Masonry.h"

/**
 动画类型

 - MDSPopAnimationTypeTranslation: 位移
 - MDSPopAnimationTypeScale: 缩放
 */
typedef NS_ENUM(NSUInteger,MDSPopAnimationType) {
    MDSPopAnimationTypeNone = 0,
    MDSPopAnimationTypeTransition,
    MDSPopAnimationTypeScale
};


/**
 动画位置

 - MDSPopAnimationPositionTop: 上部
 - MDSPopAnimationPositionCenter: 中间
 - MDSPopAnimationPositionBottom: 下部
 */
typedef NS_ENUM(NSUInteger,MDSPopAnimationPosition) {
    MDSPopAnimationPositionTop = 0,
    MDSPopAnimationPositionCenter,
    MDSPopAnimationPositionBottom
};

@interface MDSMaskComponent ()

/** 是否已经显示 */
@property (nonatomic) BOOL isShow;
/** 动画时间 */
@property (nonatomic) CGFloat duration;
/** 动画类型 */
@property (nonatomic) MDSPopAnimationType animationType;
/** 动画位置 */
@property (nonatomic) MDSPopAnimationPosition animationPosition;

/** show事件 */
@property (nonatomic) BOOL showEvent;
/** hide事件 */
@property (nonatomic) BOOL hideEvent;
/** 禁止遮罩层点击 */
@property (nonatomic) BOOL disableMaskEvent;

@property (nonatomic) CGRect fromPopViewRect;
@property (nonatomic) CGRect toPopViewRect;

@end

@implementation MDSMaskComponent

WX_EXPORT_METHOD(@selector(show));
WX_EXPORT_METHOD(@selector(hide));

- (instancetype)initWithRef:(NSString *)ref type:(NSString *)type styles:(NSDictionary *)styles attributes:(NSDictionary *)attributes events:(NSArray *)events weexInstance:(WXSDKInstance *)weexInstance
{
    
    NSMutableDictionary *newStyles = [NSMutableDictionary dictionaryWithDictionary:styles];
    [newStyles setValue:@"hidden" forKey:@"visibility"];
    
    if (self = [super initWithRef:ref type:type styles:newStyles attributes:attributes events:events weexInstance:weexInstance]) {
        
        _isShow = NO;
        _showEvent = NO;
        _hideEvent = NO;
        
        /* 解析动画时间 */
        if (attributes[@"duration"]) {
            _duration = [WXConvert CGFloat:attributes[@"duration"]] / 1000.0f;
        } else {
            _duration = 0.3f;
        }
        
        /** 背景遮罩是否可以点击 */
        if (attributes[@"disableMaskEvent"]) {
            _disableMaskEvent = [WXConvert BOOL:attributes[@"disableMaskEvent"]];
        }
        
        /** 解析位置 */
        if (attributes[@"position"] && [attributes[@"position" ] isEqualToString:@"top"]) {
            self.animationPosition = MDSPopAnimationPositionTop;
        }
        else if (attributes[@"position"] && [attributes[@"position" ] isEqualToString:@"center"])
        {
            self.animationPosition = MDSPopAnimationPositionCenter;
        }
        else
        {
            /** 缺省为 bottom */
            self.animationPosition = MDSPopAnimationPositionBottom;
        }
        
        /** 解析动画类型 */
        // 兼容之前版本 动画类型为 center、bottom 现在版本将 位置、动画类型分开了
        if (attributes[@"animation"] && [attributes[@"animation"] isEqualToString:@"center"]) {
            self.animationType = MDSPopAnimationTypeScale;
            self.animationPosition = MDSPopAnimationPositionCenter;
        }
        else if (attributes[@"animation"] && [attributes[@"animation"] isEqualToString:@"transition"])
        {
            self.animationType = MDSPopAnimationTypeTransition;
        }
        else if (attributes[@"animation"] && [attributes[@"animation"] isEqualToString:@"scale"])
        {
            self.animationType = MDSPopAnimationTypeScale;
        }
        // 缺省为 bottom
        else {
            self.animationPosition = MDSPopAnimationPositionBottom;
            self.animationType = MDSPopAnimationTypeTransition;
        }
        
        /** 为了兼容之前的如果设置了位置，没有设置动画类型的话讲动画类型设置为none */
        if (attributes[@"position"] && !attributes[@"animation"]) {
            self.animationType = MDSPopAnimationTypeNone;
        }
        
    }
    return self;
}

- (UIView *)loadView
{
    UIView *view = [[UIView alloc] init];
    view.alpha = 0;
    view.hidden = YES;
    return view;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // 添加点击手势
    if (!_disableMaskEvent) {
        UIButton *btn = [[UIButton alloc] init];
        [btn addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        
        @weakify(self);
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self);
            make.center.mas_equalTo(self.view);
            make.edges.mas_offset(UIEdgeInsetsZero);
        }];
    }
}

- (void)insertSubview:(WXComponent *)subcomponent atIndex:(NSInteger)index
{
    if ([subcomponent isKindOfClass:[MDSPopupComponent class]]) {
        UIView *subView = subcomponent.view;
        
        [self.view addSubview:subView];
    }
}

- (void)layoutDidFinish
{
    [super layoutDidFinish];
}

#pragma mark - Add Event
- (void)addEvent:(NSString *)eventName
{
    if ([eventName isEqualToString:@"show"]) {
        _showEvent = YES;
        return;
    }
    if ([eventName isEqualToString:@"hide"]) {
        _hideEvent = YES;
        return;
    }
}

#pragma mark - Remove Event
- (void)removeEvent:(NSString *)eventName
{
    if ([eventName isEqualToString:@"show"]) {
        _showEvent = NO;
    }
    if ([eventName isEqualToString:@"hide"]) {
        _hideEvent = NO;
    }
}

- (void)getPopViewRectNeedUpdateFrame:(BOOL)update
{
    MDSPopupComponent *popView = self.subcomponents[0];
    UIView *subView = popView.view;
    
    if (self.animationPosition == MDSPopAnimationPositionCenter) {
        subView.center = self.view.center;
        self.fromPopViewRect = subView.frame;
        self.toPopViewRect = subView.frame;
    }
    else if (self.animationPosition == MDSPopAnimationPositionTop && self.animationType == MDSPopAnimationTypeTransition) {
        CGRect rect4SubView = subView.frame;
        rect4SubView.origin.y = -subView.height;
        self.fromPopViewRect = rect4SubView;
        
        rect4SubView.origin.y = 0;
        self.toPopViewRect = rect4SubView;
    }
    else if (self.animationPosition == MDSPopAnimationPositionTop && (self.animationType == MDSPopAnimationTypeScale || self.animationType == MDSPopAnimationTypeNone)) {
        CGRect rect4SubView = subView.frame;
        rect4SubView.origin.y = 0;
        self.fromPopViewRect = rect4SubView;
        self.toPopViewRect = rect4SubView;
    }
    else if (self.animationPosition == MDSPopAnimationPositionBottom && self.animationType == MDSPopAnimationTypeTransition) {
        CGRect rect4SubView = subView.frame;
        rect4SubView.origin.y = self.view.height;
        self.fromPopViewRect = rect4SubView;
        
        rect4SubView.origin.y = self.view.height - subView.height;
        self.toPopViewRect = rect4SubView;
    }
    else if (self.animationPosition == MDSPopAnimationPositionBottom && (self.animationType == MDSPopAnimationTypeScale || self.animationType == MDSPopAnimationTypeNone)) {
        CGRect rect4SubView = subView.frame;
        
        rect4SubView.origin.y = self.view.height - subView.height;
        self.fromPopViewRect = rect4SubView;
        self.toPopViewRect = rect4SubView;
    }
    
    if (update) {
        subView.frame = self.fromPopViewRect;
    }
}

#pragma mark - EXPORT_METHOD
- (void)show
{
    if (_isShow) {
        [self hide];
        return;
    }
    
    [self getPopViewRectNeedUpdateFrame:YES];
    
    self.view.hidden = NO;
    
    MDSPopupComponent *popView = self.subcomponents[0];
    
    if (self.animationType == MDSPopAnimationTypeScale) {
        popView.view.transform = CGAffineTransformMakeScale(0.5, 0.5);
    }
    
    [UIView animateWithDuration:_duration animations:^{
        self.view.alpha = 1;
        
        if (self.animationType == MDSPopAnimationTypeScale) {
            popView.view.transform = CGAffineTransformMakeScale(1, 1);
        }
        
        if (self.animationType == MDSPopAnimationTypeTransition) {
            popView.view.frame = self.toPopViewRect;
        }
    }];
    
    if (_showEvent) {
        [self fireEvent:@"show" params:nil];
    }
    
    _isShow = YES;
}

- (void)hide
{
    if (!_isShow) return;
    
    [self getPopViewRectNeedUpdateFrame:NO];
    
    MDSPopupComponent *popView = self.subcomponents[0];
    
    [UIView animateWithDuration:_duration animations:^{
        
        if (self.animationType == MDSPopAnimationTypeScale) {
            popView.view.transform = CGAffineTransformMakeScale(0.5, 0.5);
        }
        
        if (self.animationType == MDSPopAnimationTypeTransition) {
            popView.view.frame = self.fromPopViewRect;
        }
        
        self.view.alpha = 0;
        
    } completion:^(BOOL finished) {
        self.view.hidden = YES;
        if (self.animationType == MDSPopAnimationTypeScale) {
            popView.view.transform = CGAffineTransformMakeScale(1, 1);
        }
        
        if (_hideEvent) {
            [self fireEvent:@"hide" params:nil];
        }
        
    }];
    
    _isShow = NO;
}

@end

//
//  MDSPopupComponent.m
//  Pods
//
//  Created by jony on 2018/4/26.
//
//

#import "MDSPopupComponent.h"
#import "MDSMaskComponent.h"
#import "Masonry.h"

@interface MDSPopupComponent ()

@property (nonatomic) CGFloat rowHeight;
@property (nonatomic) BOOL needUpdateFrame; /**< 兼容一些弹窗问题 */

@end

@implementation MDSPopupComponent

- (instancetype)initWithRef:(NSString *)ref type:(NSString *)type styles:(NSDictionary *)styles attributes:(NSDictionary *)attributes events:(NSArray *)events weexInstance:(WXSDKInstance *)weexInstance
{
    
    if (self = [super initWithRef:ref type:type styles:styles attributes:attributes events:events weexInstance:weexInstance]) {
        if (attributes[@"updatePosition"]) {
            _needUpdateFrame = [WXConvert BOOL:attributes[@"updatePosition"]];
        }
    }
    return self;
}

- (UIView *)loadView
{
    return [[UIView alloc] init];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)layoutDidFinish
{
    [super layoutDidFinish];
    
    if (_needUpdateFrame && [self.supercomponent isKindOfClass:[MDSMaskComponent class]]) {
        [(MDSMaskComponent *)self.supercomponent getPopViewRectNeedUpdateFrame:YES];
    }
    
}


@end

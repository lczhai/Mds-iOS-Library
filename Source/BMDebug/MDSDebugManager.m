//
//  MDSDebugWindow.m
//  MDS-Chia
//
//  Created by 窦静轩 on 2017/3/10.
//  Copyright © 2017年 XHY. All rights reserved.
//

#ifdef DEBUG
#import "MDSDebugManager.h"
#import "MDSDragButton+Debug.h"
#import "UIWindow+Util.h"
#import "MDSHotRefreshWebScoket.h"
#import "MDSResourceManager.h"
#import "MDSBaseViewController.h"
#import "SVProgressHUD.h"

@interface MDSDebugManager ()
{
    MDSDragButton * _debugButton;
}

@property (nonatomic, strong) MDSHotRefreshWebScoket *hotRefreshWS; /**< 热刷新WS */

@end


@implementation MDSDebugManager


+ (instancetype)shareInstance
{
    static MDSDebugManager *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[MDSDebugManager alloc] init];
        [_instance checkHotRefreshStatus];
    });
    return _instance;
}

- (void)hotRefreshWebSocketConnect
{
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:MDS_HotRefreshKey];
    if (TK_PlatformInfo().url.socketServer) {
        [self.hotRefreshWS connect];
    }
}

- (void)hotRefreshWebSocketClose
{
    if (_hotRefreshWS) {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:MDS_HotRefreshKey];
        [_hotRefreshWS close];
        _hotRefreshWS = nil;
        [SVProgressHUD showImage:nil status:@"hot refresh disconnected."];
    }
}


- (MDSHotRefreshWebScoket *)hotRefreshWS
{
    if (!_hotRefreshWS) {
        _hotRefreshWS = [[MDSHotRefreshWebScoket alloc] init];
    }
    return _hotRefreshWS;
}

- (void)checkHotRefreshStatus
{
    if ([[NSUserDefaults standardUserDefaults] boolForKey:MDS_HotRefreshKey]) {
        [self hotRefreshWebSocketConnect];
    }
}

// 显示
- (void)show
{
    UIWindow *window = [UIWindow findVisibleWindow];
    if (nil == _debugButton) {
        _debugButton = [MDSDragButton debugButton];
    }
    
    NSArray * views = [window subviews];
    if (NO == [views containsObject:_debugButton]) {
        [window addSubview:_debugButton];
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [window bringSubviewToFront:_debugButton];
    });
    
}
// 消失
- (void)dismiss
{
    [_debugButton removeFromSuperview];
}

- (void)refreshWeex
{
    //刷新widgetJs
    [MDSResourceManager sharedInstance].mdsWidgetJs = nil;
    
    //检查js中介者是否加载成功
    [[MDSMediatorManager shareInstance] loadJSMediator:NO];
    
    UIViewController* controller =  [[MDSMediatorManager shareInstance] currentViewController];
    if ([controller isKindOfClass:[MDSBaseViewController class]]) {
        [(MDSBaseViewController*)controller refreshWeex];
    }
}

@end
#endif

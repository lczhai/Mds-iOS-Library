//
//  MDSBaseViewController+Order.m
//  Pods
//
//  Created by jony on 2018/5/22.
//
//

#import "MDSBaseViewController+Order.h"
#import "MDSConfigManager.h"

@implementation MDSBaseViewController (Order)

- (BOOL)currentVcIs:(NSString *)url
{
    return [self.url.absoluteString rangeOfString:url].location != NSNotFound;
}

/* 判断是否隐藏导航栏 */
- (BOOL)isHideNavbar
{
    if (!self.routerModel.navShow ||
        [self currentVcIs:[MDSConfigManager shareInstance].platform.page.homePage]) {
        
        return YES;
    }
    
    return NO;
}

/* 设置状态栏样式 */
- (void)mdsSetStatusBarStyle
{
    
    if (!self.routerModel.statusBarStyle) return;
    
    /* 设置状态栏 字体颜色 */
    if ([self.routerModel.statusBarStyle isEqualToString:@"Default"]) {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
        
    } else {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    }
}

- (CGFloat)weexViewHeight
{
    /* 设置weex页面高度 */
    CGFloat height = self.view.height;
    if (self.routerModel.isTabBarItem) {
        height -= K_TABBAR_HEIGHT;
    }
    
    return height;
}

@end

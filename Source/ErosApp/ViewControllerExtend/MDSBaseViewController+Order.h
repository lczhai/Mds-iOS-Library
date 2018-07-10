//
//  MDSBaseViewController+Order.h
//  Pods
//
//  Created by jony on 2018/5/22.
//
//

#import <MDSBaseViewController.h>

@interface MDSBaseViewController (Order)

/** 判断当前页面路径 */
- (BOOL)currentVcIs:(NSString *)url;

/** 判断是否隐藏导航栏 */
- (BOOL)isHideNavbar;

/** 设置状态栏样式 */
- (void)mdsSetStatusBarStyle;

/** 获取weex页面可用高度 */
- (CGFloat)weexViewHeight;

@end

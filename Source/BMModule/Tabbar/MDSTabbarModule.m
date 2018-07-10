//
//  MDSTabbarModule.m
//  MDSBaseLibrary
//
//  Created by XHY on 2018/6/21.
//

#import "MDSTabbarModule.h"
#import <WeexPluginLoader/WeexPluginLoader.h>
#import "UITabBar+Badge.h"
#import "MDSMediatorManager.h"

WX_PlUGIN_EXPORT_MODULE(bmTabbar, MDSTabbarModule)

@implementation MDSTabbarModule

@synthesize weexInstance;

WX_EXPORT_METHOD(@selector(showBadge:))
WX_EXPORT_METHOD(@selector(hideBadge:))
WX_EXPORT_METHOD(@selector(openPage:))

- (void)showBadge:(NSDictionary *)info
{
    int index = info[@"index"] ? [info[@"index"] intValue] : 0;
    NSString *value = info[@"value"];
    UIColor *textColor = info[@"textColor"] ? [UIColor colorWithHexString:info[@"textColor"]] : [UIColor whiteColor];
    UIColor *backgroundColor = info[@"bgColor"] ? [UIColor colorWithHexString:info[@"bgColor"]] : [UIColor redColor];
    
    [[MDSMediatorManager shareInstance].baseTabBarController.tabBar showBadgeOnItenIndex:index
                                                                                  value:value
                                                                        backgroundColor:backgroundColor
                                                                              textColor:textColor];
}
- (void)hideBadge:(NSDictionary *)info
{
    int index = info[@"index"] ? [info[@"index"] intValue] : 0;
    
    [[MDSMediatorManager shareInstance].baseTabBarController.tabBar hideBadgeOnItenIndex:index];
}

- (void)openPage:(NSDictionary *)info
{
    NSInteger index = info[@"index"] ? [info[@"index"] integerValue] : 0;
    [[MDSMediatorManager shareInstance] backToHomeIndex:index];
}

@end

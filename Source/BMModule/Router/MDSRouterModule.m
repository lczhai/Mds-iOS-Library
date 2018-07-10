//
//  MDSRouterModule.m
//  WeexDemo
//
//  Created by jony on 2018/1/11.
//  Copyright © 2017年 taobao. All rights reserved.
//

#import "MDSRouterModule.h"
#import "MDSRouterModel.h"

#import "HYAlertView.h"

#import "MDSMediatorManager.h"
#import "MDSBaseViewController.h"

#import "MDSUserInfoModel.h"
#import "MDSDB.h"
#import "YYModel.h"

#import "MDSWebViewRouterModel.h"

@implementation MDSRouterModule

@synthesize weexInstance;

WX_EXPORT_METHOD(@selector(open:callback:))
WX_EXPORT_METHOD(@selector(getParams:))
WX_EXPORT_METHOD(@selector(back:callback:))
WX_EXPORT_METHOD(@selector(refreshWeex))
WX_EXPORT_METHOD(@selector(toWebView:))
WX_EXPORT_METHOD(@selector(callPhone:))
WX_EXPORT_METHOD(@selector(openBrowser:))
WX_EXPORT_METHOD(@selector(setHomePage:))

- (void)open:(NSDictionary *)info callback:(WXModuleCallback)callback
{
    /* 解析info */
    MDSRouterModel *routerModel = [MDSRouterModel yy_modelWithJSON:info];
    
    if (callback)  routerModel.backCallback = callback;
    
    /* 通过中介者跳转页面 */
    [[MDSMediatorManager shareInstance] openViewControllerWithRouterModel:routerModel weexInstance:weexInstance];
    
}

- (void)getParams:(WXModuleCallback)callback
{
    if (callback) {
        MDSBaseViewController *currentVc = (MDSBaseViewController *)weexInstance.viewController;
        id params = currentVc.routerModel.params ?: @"";
        callback(params);
    }
}

- (void)back:(NSDictionary *)info callback:(WXModuleCallback)callback
{
    /* 解析info */
    MDSRouterModel *routerModel = [MDSRouterModel yy_modelWithJSON:info];
    [[MDSMediatorManager shareInstance] backVcWithRouterModel:routerModel weexInstance:weexInstance];
}

/** 刷新当前weexInstance */
- (void)refreshWeex
{
    if ([weexInstance.viewController respondsToSelector:@selector(refreshWeex)]) {
        [(MDSBaseViewController *)weexInstance.viewController refreshWeex];
    }
}

/** 打开app内置webview */
- (void)toWebView:(NSDictionary *)info
{
    MDSWebViewRouterModel *model = [MDSWebViewRouterModel yy_modelWithJSON:info];
    [[MDSMediatorManager shareInstance] toWebViewWithRouterInfo:model];
}

/** 使用iOS系统自带浏览器打开 url */
- (void)openBrowser:(NSString *)url
{
    NSURL *openUrl = [NSURL URLWithString:url];
    [[UIApplication sharedApplication] openURL:openUrl];
}

/** 拨打电话 */
- (void)callPhone:(NSDictionary *)info
{
    if (!info[@"phone"]) {
        WXLogError(@"电话号码错误");
        return;
    }
    
    /* ios10 以后会弹系统弹窗 */
    if (K_SYSTEM_VERSION > 10.2) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",info[@"phone"]]]];
    } else {
        HYAlertView *alert = [HYAlertView configWithTitle:nil message:info[@"phone"] cancelButtonTitle:@"取消" otherButtonTitle:@"呼叫" clickedButtonAtIndexBlock:^(NSInteger index) {
            if (index == 1) [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",info[@"phone"]]]];
        }];
        [alert show];
    }
}

/** 刷新app */
- (void)setHomePage:(NSString *)path
{
    if (![path isKindOfClass:[NSString class]]) {
        WXLogError(@"setHomePage Error: %@",path);
        return;
    }
    MDS_SetUserDefaultData(K_HomePagePath, path);
    [[NSNotificationCenter defaultCenter] postNotificationName:K_MDSAppReStartNotification object:nil];
}

@end

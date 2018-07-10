//
//  MDSConfigManager.m
//  WeexDemo
//
//  Created by jony on 2018/1/10.
//  Copyright © 2017年 taobao. All rights reserved.
//

#import "MDSConfigManager.h"
#import "YTKNetwork.h"
#import "MDSDefine.h"
#import <SVProgressHUD.h>
#import <SDWebImage/SDImageCache.h>
#import <SDWebImage/SDWebImageDownloader.h>
#import <CryptLib.h>

#import "MDSUserInfoModel.h"
#import "MDSDB.h"
#import "MDSMediatorManager.h"
#import "MDSDB.h"

#import "WXImgLoaderDefaultImpl.h"
#import "MDSMonitorHandler.h"
#import "MDSConfigCenterHandler.h"

#import <MDSMaskComponent.h>
#import "MDSTextComponent.h"
#import <MDSPopupComponent.h>
#import "MDSCalendarComponent.h"
#import "MDSSpanComponent.h"
#import "MDSChartComponent.h"

#import "MDSRouterModule.h"
#import "MDSAxiosNetworkModule.h"
#import "MDSGeolocationModule.h"
#import "MDSModalModule.h"
#import "MDSCameraModule.h"
#import "MDSStorageModule.h"
#import "MDSAppConfigModule.h"
#import "MDSToolsModule.h"
#import "MDSNavigatorModule.h"
#import "MDSAuthorLoginModule.h"
#import "MDSCommunicationModule.h"
#import "MDSImageModule.h"
#import "MDSWebSocketModule.h"

#import <WeexSDK/WeexSDK.h>
#import "WXUtility.h"

#import "WXBMNetworkDefaultlpml.h"
#import "MDSResourceManager.h"
#import "MDSEventsModule.h"
#import "MDSBrowserImgModule.h"
#import "MDSRichTextComponent.h"

#import <AFNetworking/AFNetworkReachabilityManager.h>


#ifdef DEBUG
#import "MDSDebugManager.h"
#endif

@implementation MDSConfigManager

- (instancetype)init
{
    if (self = [super init]) {
        
        NSString *jStr = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"eros.native" ofType:@"json"] encoding:NSUTF8StringEncoding error:nil];
        NSString *decryptStr = [[[CryptLib alloc] init] decryptCipherTextWith:jStr key:AES_KEY iv:AES_IV];
        NSData *jData = [decryptStr dataUsingEncoding:NSUTF8StringEncoding];
        
//        NSData *jData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"eros.native" ofType:@"json"]];
        NSDictionary *jDic = [NSJSONSerialization JSONObjectWithData:jData options:NSJSONReadingAllowFragments error:nil];
        _platform = [MDSPlatformModel yy_modelWithJSON:jDic];
    }
    return self;
}

- (NSDictionary *)envInfo
{
    if (!_envInfo) {
        _envInfo = [WXUtility getEnvironment];
    }
    return _envInfo;
}

#pragma mark - Public Func

+ (instancetype)shareInstance
{
    static MDSConfigManager *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[MDSConfigManager alloc] init];
    });
    return _instance;
}
+ (void)configDefaultData
{
    /* 启动网络变化监控 */
    AFNetworkReachabilityManager *reachability = [AFNetworkReachabilityManager sharedManager];
    [reachability startMonitoring];
    
    /** 初始化Weex */
    [MDSConfigManager initWeexSDK];
    
    MDSPlatformModel *platformInfo = TK_PlatformInfo();
    
    /** 设置sdimage减小内存占用 */
    [[SDWebImageDownloader sharedDownloader] setShouldDecompressImages:NO];
  
    
    /** 设置统一请求url */
    [[YTKNetworkConfig sharedConfig] setBaseUrl:platformInfo.url.request];
    [[YTKNetworkConfig sharedConfig] setCdnUrl:platformInfo.url.image];
    
    /** 应用最新js资源文件 */
    [[MDSResourceManager sharedInstance] compareVersion];
    
    /** 初始化数据库 */
    [[MDSDB DB] configDB];
    
    /** 设置 HUD */
    [MDSConfigManager configProgressHUD];

    /* 监听截屏事件 */
//    [[MDSScreenshotEventManager shareInstance] monitorScreenshotEvent];
    
}

+ (void)configProgressHUD
{
    [SVProgressHUD setBackgroundColor:[K_BLACK_COLOR colorWithAlphaComponent:0.70f]];
    [SVProgressHUD setForegroundColor:K_WHITE_COLOR];
    [SVProgressHUD setCornerRadius:4.0];
    [SVProgressHUD setMinimumDismissTimeInterval:1.5];
}

+ (void)registerMdsHandlers
{
    [WXSDKEngine registerHandler:[WXImgLoaderDefaultImpl new] withProtocol:@protocol(WXImgLoaderProtocol)];
    [WXSDKEngine registerHandler:[WXBMNetworkDefaultlpml new] withProtocol:@protocol(WXResourceRequestHandler)];
    [WXSDKEngine registerHandler:[MDSMonitorHandler new] withProtocol:@protocol(WXAppMonitorProtocol)];
    [WXSDKEngine registerHandler:[MDSConfigCenterHandler new] withProtocol:@protocol(WXConfigCenterProtocol)];
}

+ (void)registerMdsComponents
{
    
    NSDictionary *components = @{
                                @"bmmask":          NSStringFromClass([MDSMaskComponent class]),
                                @"bmpop":           NSStringFromClass([MDSPopupComponent class]),
                                @"bmtext":          NSStringFromClass([MDSTextComponent class]),
                                @"bmrichtext":      NSStringFromClass([MDSRichTextComponent class]),
                                @"bmcalendar":      NSStringFromClass([MDSCalendarComponent class]),
                                @"bmspan":          NSStringFromClass([MDSSpanComponent class]),
                                @"bmchart":         NSStringFromClass([MDSChartComponent class])
                                };
    for (NSString *componentName in components) {
        [WXSDKEngine registerComponent:componentName withClass:NSClassFromString([components valueForKey:componentName])];
    }
}

+ (void)registerMdsModules
{
    NSDictionary *modules = @{
                              @"bmRouter" :         NSStringFromClass([MDSRouterModule class]),
                              @"bmAxios":           NSStringFromClass([MDSAxiosNetworkModule class]),
                              @"bmGeolocation":     NSStringFromClass([MDSGeolocationModule class]),
                              @"bmModal":           NSStringFromClass([MDSModalModule class]),
                              @"bmCamera":          NSStringFromClass([MDSCameraModule class]),
                              @"bmStorage":         NSStringFromClass([MDSStorageModule class]),
                              @"bmFont":            NSStringFromClass([MDSAppConfigModule class]),
                              @"bmEvents":          NSStringFromClass([MDSEventsModule class]),
                              @"bmBrowserImg":      NSStringFromClass([MDSBrowserImgModule class]),
                              @"bmTool":            NSStringFromClass([MDSToolsModule class]),
                              @"bmAuth":            NSStringFromClass([MDSAuthorLoginModule class]),
                              @"bmNavigator":       NSStringFromClass([MDSNavigatorModule class]),
                              @"bmCommunication":   NSStringFromClass([MDSCommunicationModule class]),
                              @"bmImage":           NSStringFromClass([MDSImageModule class]),
                              @"bmWebSocket":       NSStringFromClass([MDSWebSocketModule class])
                              };
    
    for (NSString *moduleName in modules.allKeys) {
        [WXSDKEngine registerModule:moduleName withClass:NSClassFromString([modules valueForKey:moduleName])];
    }
}

+ (void)initWeexSDK
{
    [WXSDKEngine initSDKEnvironment];
    
    [MDSConfigManager registerMdsHandlers];
    [MDSConfigManager registerMdsComponents];
    [MDSConfigManager registerMdsModules];
    
#ifdef DEBUG
    [WXDebugTool setDebug:YES];
    [WXLog setLogLevel:WeexLogLevelLog];
    [[MDSDebugManager shareInstance] show];
//    [[ATManager shareInstance] show];
    
#else
    [WXDebugTool setDebug:NO];
    [WXLog setLogLevel:WeexLogLevelError];
#endif
}

- (BOOL)applicationOpenURL:(NSURL *)url
{
    return YES;
}

@end

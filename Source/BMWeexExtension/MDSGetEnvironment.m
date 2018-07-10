//
//  MDSGetEnvironment.m
//  MDS-Chia
//
//  Created by 窦静轩 on 2017/3/23.
//  Copyright © 2017年 XHY. All rights reserved.
//

#import "MDSGetEnvironment.h"
#import <WeexSDK/WXUtility.h>
#import <WeexSDK/WXAppConfiguration.h>
#import <WeexSDK/WXSDKEngine.h>
#import <sys/utsname.h>

#import "MDSDeviceManager.h"
#import "MDSConfigManager.h"
#import "MDSResourceManager.h"

#define MDS_FONT_SIZE @"mdsFontSize"
#define MDS_REQUEST_URL @"request"
#define MDS_JS_SERVER @"jsServer"
#define MDS_FONT_SCALE @"mdsFontSize"
#define MDSStatusBarHeight @"statusBarHeight"
#define MDSNavBarHeight @"navBarHeight"
#define MDSTouchBarHeight @"touchBarHeight"
#define MDSJsVersion @"jsVersion"


@implementation MDSGetEnvironment

+ (NSDictionary *)mds_getEnvironment
{
    static NSDictionary *environment = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *platform = @"iOS";
        NSString *sysVersion = [[UIDevice currentDevice] systemVersion] ?: @"";
        NSString *weexVersion = WX_SDK_VERSION;
        
        
        struct utsname systemInfo;
        uname(&systemInfo);
        NSString *machineValue = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
        
        
        NSString *machine = machineValue ? : @"";
        NSString *appVersion = [WXAppConfiguration appVersion] ? : @"";
        NSString *appName = [WXAppConfiguration appName] ? : @"";
        
        CGFloat deviceWidth = [WXUtility portraitScreenSize].width;
        CGFloat deviceHeight = [WXUtility portraitScreenSize].height;
        CGFloat scale = [[UIScreen mainScreen] scale];
        
        NSMutableDictionary *data = [NSMutableDictionary dictionaryWithDictionary:@{
                                                                                    @"platform":platform,
                                                                                    @"osVersion":sysVersion,
                                                                                    @"weexVersion":weexVersion,
                                                                                    @"deviceModel":machine,
                                                                                    @"appName":appName,
                                                                                    @"appVersion":appVersion,
                                                                                    @"deviceWidth":@(deviceWidth * scale),
                                                                                    @"deviceHeight":@(deviceHeight * scale),
                                                                                    @"scale":@(scale),
                                                                                    @"logLevel":[WXLog logLevelString] ?: @"error"
                                                                                    }];
        
        
        if ([WXSDKEngine customEnvironment]) {
            [data addEntriesFromDictionary:[WXSDKEngine customEnvironment]];
        }
        
        
        //添加前端所需要字段 目前是 fontSize 还有 请求的URL
        NSMutableDictionary * mdsData = [NSMutableDictionary dictionaryWithDictionary:data];
        
        //添加fontSize
        
        NSString *currentFontSize = [[NSUserDefaults standardUserDefaults] valueForKey:K_FONT_SIZE_KEY] ? [[NSUserDefaults standardUserDefaults] valueForKey:K_FONT_SIZE_KEY]:K_FONT_SIZE_NORM;
        
        if(currentFontSize){
            [mdsData setObject:currentFontSize forKey:MDS_FONT_SIZE];
            
            CGFloat mdsFontSize;
            
            if ([currentFontSize isEqualToString:K_FONT_SIZE_NORM]) {
                mdsFontSize = 1.0;
            }
            else if ([currentFontSize isEqualToString:K_FONT_SIZE_BIG]){
                mdsFontSize = K_FontSizeBig_Scale;
            }
            else if ([currentFontSize isEqualToString:k_FONT_SIZE_EXTRALARGE]){
                mdsFontSize = K_FontSizeExtralarge_Scale;
            }
            else{
                mdsFontSize = 1.0;
            }
            [mdsData setObject:[NSNumber numberWithFloat:mdsFontSize] forKey:MDS_FONT_SCALE];
        }
        
        //添加当前更新接口URL
        if ([MDSConfigManager shareInstance].platform.url.request.length) {
            
            [mdsData setObject:[MDSConfigManager shareInstance].platform.url.request forKey:MDS_REQUEST_URL];
        }
        
        //添加当前入口
        if([MDSConfigManager shareInstance].platform.url.jsServer.length){
            [mdsData setObject:[MDSConfigManager shareInstance].platform.url.jsServer forKey:MDS_JS_SERVER];
        }
        
        // 添加 deviceId
        NSString *deviceId = [MDSDeviceManager deviceID];
        if (deviceId) {
            [mdsData setObject:deviceId forKey:@"deviceId"];
        }
        
        //状态栏高度
        [mdsData setValue:[NSNumber numberWithFloat:K_STATUSBAR_HEIGHT / [WXUtility defaultPixelScaleFactor]] forKey:MDSStatusBarHeight];
        //导航栏高度
        [mdsData setValue:[NSNumber numberWithFloat:K_NAVBAR_HEIGHT / [WXUtility defaultPixelScaleFactor]] forKey:MDSNavBarHeight];
        //touchBar高度
        [mdsData setValue:[NSNumber numberWithFloat:K_TOUCHBAR_HEIGHT / [WXUtility defaultPixelScaleFactor]] forKey:MDSTouchBarHeight];
        //JSVersion
        NSDictionary * userInfo = [[MDSResourceManager sharedInstance] loadConfigData:K_JS_VERSION_PATH];
        NSString *jsVersion = @"jsVersion 取不到";
        if ([userInfo isKindOfClass:[NSDictionary class]] && userInfo[@"jsVersion"]) {
            jsVersion = userInfo[@"jsVersion"];
        }
        [mdsData setValue:jsVersion forKey:MDSJsVersion];
        
        environment = [[NSDictionary alloc] initWithDictionary:mdsData];
    });
    
    
    
    return environment;
}

@end

//
//  MDSDeviceManager.m
//  WeexDemo
//
//  Created by jony on 2018/1/13.
//  Copyright © 2017年 taobao. All rights reserved.
//

#import "MDSDeviceManager.h"
#import "SFHFKeychainUtils.h"
#import "NSString+Util.h"

NSString const * kDeviceModelServiceName = @"bitautoDevice";
NSString const * kDeviceIdKey = @"deviceId";

@implementation MDSDeviceManager

+ (NSString*)deviceID{
    
    // 从keychain中读取id
    NSString *deviceIdStr = [SFHFKeychainUtils getPasswordForUsername:(NSString*)kDeviceIdKey
                                                       andServiceName:(NSString*)kDeviceModelServiceName
                                                                error:nil];
    if (!deviceIdStr.length) {
        
        if ( [UIDevice currentDevice].systemVersion.floatValue < 7.0) {
            //            deviceIdStr = [[self macaddress] md5_origin];
            deviceIdStr = @"";
        }else{
            deviceIdStr = [[[[UIDevice currentDevice] identifierForVendor] UUIDString] md5];
        }
        
        // 将id保存到keychain中
        [SFHFKeychainUtils storeUsername:(NSString*)kDeviceIdKey
                             andPassword:deviceIdStr
                          forServiceName:(NSString*)kDeviceModelServiceName
                          updateExisting:YES
                                   error:nil];
    }
    
    
    return deviceIdStr;
}

@end

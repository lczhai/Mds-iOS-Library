//
//  MDSGeolocationModule.m
//  WeexDemo
//
//  Created by jony on 2018/1/19.
//  Copyright © 2017年 taobao. All rights reserved.
//

#import "MDSGeolocationModule.h"
#import "JYTLocationManager.h"
#import "NSDictionary+Util.h"

@implementation MDSGeolocationModule

@synthesize weexInstance;

WX_EXPORT_METHOD(@selector(getGeolocation:))

- (void)getGeolocation:(WXModuleCallback)callback
{
    
    [[JYTLocationManager shareInstance] getCurrentLocation:^(NSString *lon, NSString *lat) {
        if (callback) {
            
            NSInteger resCode = MDSResCodeError;
            NSDictionary *data = nil;
            if (lon && lat) {
                resCode = MDSResCodeSuccess;
                data = @{@"locationLat": lat,@"locationLng": lon};
            }
            
            /* 构建callback数据 */
            NSDictionary *resultData = [NSDictionary configCallbackDataWithResCode:resCode msg:nil data:data];
            
            callback(resultData);
            
        }
    }];
}

@end

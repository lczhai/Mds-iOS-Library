//
//  MDSCheckJsVersionRequest.m
//  WeexDemo
//
//  Created by jony on 2018/1/10.
//  Copyright © 2017年 taobao. All rights reserved.
//

#import "MDSCheckJsVersionRequest.h"
#import "MDSConfigManager.h"

@interface MDSCheckJsVersionRequest()

@property (nonatomic,readwrite)NSString * appName;

@property (nonatomic,readwrite)NSString * appVersion;

@property (nonatomic,readwrite)NSString * jsVersion;

@property (nonatomic,readwrite)BOOL isDiff;
@end



@implementation MDSCheckJsVersionRequest

- (instancetype)initWithAppName:(NSString *)appName appVersion:(NSString *)appVersion jsVersion:(NSString *)jsVersion isDiff:(BOOL)isDiff
{
    if (self = [super init]) {
        _appName = appName;
        _appVersion = appVersion;
        _jsVersion = jsVersion;
        _isDiff= isDiff;
    }
    return self;
}

- (NSString *)requestURLPath
{
    return [self requestUrl];
}

- (NSString *)requestUrl
{
    return [MDSConfigManager shareInstance].platform.url.bundleUpdate;
}

- (id)requestArgument
{
    return @{
             @"appName": _appName,
             @"iOS": _appVersion,
             @"jsVersion": _jsVersion,
             @"isDiff": [NSNumber numberWithBool:_isDiff]
             };
}

@end

//
//  MDSCheckJsVersionRequest.h
//  WeexDemo
//
//  Created by jony on 2018/1/10.
//  Copyright © 2017年 taobao. All rights reserved.
//

#import "MDSBaseRequest.h"

@interface MDSCheckJsVersionRequest : MDSBaseRequest

- (instancetype)initWithAppName:(NSString *)appName appVersion:(NSString *)appVersion jsVersion:(NSString *)jsVersion isDiff:(BOOL)isDiff;

@property (nonatomic,readonly)NSString * appName;

@property (nonatomic,readonly)NSString * appVersion;

@property (nonatomic,readonly)NSString * jsVersion;

@property (nonatomic,readonly)BOOL isDiff;

@end

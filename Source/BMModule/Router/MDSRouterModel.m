//
//  MDSRouterModel.m
//  WeexDemo
//
//  Created by jony on 2018/1/16.
//  Copyright © 2017年 taobao. All rights reserved.
//

#import "MDSRouterModel.h"

@implementation MDSRouterModel

- (instancetype)init
{
    if (self = [super init]) {
        _canBack = YES;
        _navShow = YES;
        _gesBack = YES;
    }
    return self;
}

+ (NSDictionary *)modelCustomPropertyMapper
{
    return @{@"vLength" : @"length"};
}



@end

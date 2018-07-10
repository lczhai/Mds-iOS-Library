//
//  WXBridgeManager+BMExtend.m
//  MDS-Chia
//
//  Created by jony on 2018/3/30.
//  Copyright © 2017年 XHY. All rights reserved.
//

#import "WXBridgeManager+BMExtend.h"
#import <WeexSDK/WXCallJSMethod.h>

@implementation WXBridgeManager (BMExtend)

- (void)mds_fireEvent:(NSString *)instanceId ref:(NSString *)ref type:(NSString *)type params:(NSDictionary *)params domChanges:(NSDictionary *)domChanges
{
    WXSDKInstance *instance = [WXSDKManager instanceForID:instanceId];
    if (!instance) return;
    
    [self mds_fireEvent:instanceId ref:ref type:type params:params domChanges:domChanges];
}



@end

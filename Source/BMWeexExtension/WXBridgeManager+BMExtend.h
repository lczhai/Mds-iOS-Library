//
//  WXBridgeManager+BMExtend.h
//  MDS-Chia
//
//  Created by jony on 2018/3/30.
//  Copyright © 2017年 XHY. All rights reserved.
//

#import <WeexSDK/WeexSDK.h>

@interface WXBridgeManager (BMExtend)

- (void)mds_fireEvent:(NSString *)instanceId ref:(NSString *)ref type:(NSString *)type params:(NSDictionary *)params domChanges:(NSDictionary *)domChanges;

@end

//
//  WXTextComponent+BMExtend.h
//  MDS-Chia
//
//  Created by jony on 2018/3/20.
//  Copyright © 2017年 XHY. All rights reserved.
//

#import <WeexSDK/WeexSDK.h>
#import <WeexSDK/WXTextComponent.h>

@interface WXTextComponent (BMExtend)

- (instancetype)mdsText_initWithRef:(NSString *)ref type:(NSString *)type styles:(NSDictionary *)styles attributes:(NSDictionary *)attributes events:(NSArray *)events weexInstance:(WXSDKInstance *)weexInstance;

@end

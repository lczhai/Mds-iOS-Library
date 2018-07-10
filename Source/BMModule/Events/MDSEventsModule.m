//
//  MDSEvents.m
//  MDS-Chia
//
//  Created by 窦静轩 on 2017/3/28.
//  Copyright © 2017年 XHY. All rights reserved.
//

#import "MDSEventsModule.h"
#import "MDSNotifactionCenter.h"


const static NSString * eventParamsKey = @"eventParams";

@implementation MDSEventsModule

@synthesize weexInstance;

WX_EXPORT_METHOD(@selector(on:callback:))
WX_EXPORT_METHOD(@selector(once:callback:))
WX_EXPORT_METHOD(@selector(off:callback:))
WX_EXPORT_METHOD(@selector(emit:info:))
WX_EXPORT_METHOD(@selector(offall))

-(void)on:(NSString*)event callback:(WXModuleKeepAliveCallback)callback
{
    [[MDSNotifactionCenter defaultCenter] on:event callback:callback instance:weexInstance];
}

-(void)once:(NSString*)event callback:(WXModuleKeepAliveCallback)callback
{
    [[MDSNotifactionCenter defaultCenter] once:event callback:callback instance:weexInstance];
}


-(void)off:(NSString*)event callback:(WXModuleCallback)callback
{
    [[MDSNotifactionCenter defaultCenter] off:event callback:nil];
}

-(void)offall
{
    [[MDSNotifactionCenter defaultCenter] offAll];
}

-(void)emit:(NSString*)event info:(id)info
{
    [[MDSNotifactionCenter defaultCenter] emit:event info:info];
}
@end

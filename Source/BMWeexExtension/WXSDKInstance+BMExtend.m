//
//  WXSDKInstance+BMExtend.m
//  MDS-Chia
//
//  Created by jony on 2018/3/29.
//  Copyright © 2017年 XHY. All rights reserved.
//

#import "WXSDKInstance+BMExtend.h"
#import <objc/runtime.h>
#import "MDSNotifactionCenter.h"
#import "MDSResourceManager.h"

@implementation WXSDKInstance(BMExtend)


- (void)mds_destroyInstance
{
    //通知消息中心 移除对应实例
    [[MDSNotifactionCenter defaultCenter] destroyObserver:self.instanceId];
    
    [self mds_destroyInstance];
    
}


- (void)mds__renderWithMainBundleString:(NSString *)mainBundleString
{
    /** 注入本地的base js */
    NSString *baseScript = [MDSResourceManager sharedInstance].mdsWidgetJs;
    
    if (baseScript.length) {
        mainBundleString = [baseScript stringByAppendingString:mainBundleString];
    }
    
    [self mds__renderWithMainBundleString:mainBundleString];
}

@end

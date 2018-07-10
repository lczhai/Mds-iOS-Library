//
//  MDSAppResource.m
//  MDS-Chia
//
//  Created by jony on 2018/3/1.
//  Copyright © 2017年 XHY. All rights reserved.
//

#import "MDSAppResource.h"
#import "MDSConfigManager.h"

#define K_LOAD_JS_KEY @"load_js_resource"

@implementation MDSAppResource

+ (NSURL *)configJSFullURLWithPath:(NSString *)path
{
    /* 拼接完整的路径 */
    NSString *urlPath = [NSString stringWithFormat:@"%@%@",[[MDSConfigManager shareInstance].platform.url.jsServer stringByAppendingString:K_JS_ADD_PATH],path];
    return [NSURL URLWithString:urlPath];
}

@end

//
//  NSDictionary+Util.h
//  MDS-Chia
//
//  Created by jony on 2018/2/21.
//  Copyright © 2017年 XHY. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_OPTIONS(NSInteger, MDSResCode) {
    MDSResCodeSuccess = 0,
    MDSResCodeError = 9,
    MDSResCodeOther = 3
};

@interface NSDictionary (Util)

/* 统一构建js callback 回调数据方法 */
+ (NSDictionary *)configCallbackDataWithResCode:(NSInteger)resCode msg:(NSString *)msg data:(id)data;

@end

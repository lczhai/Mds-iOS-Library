//
//  MDSStorageModule.m
//  WeexDemo
//
//  Created by jony on 2018/2/8.
//  Copyright © 2017年 taobao. All rights reserved.
//

#import "MDSStorageModule.h"
#import "MDSDB.h"
#import "NSDictionary+Util.h"
#import "MDSUserInfoModel.h"
#import "YYModel.h"
#import "MDSMediatorManager.h"

@implementation MDSStorageModule

@synthesize weexInstance;

WX_EXPORT_METHOD(@selector(setData:data:callback:))
WX_EXPORT_METHOD(@selector(getData:callback:))
WX_EXPORT_METHOD(@selector(deleteData:callback:))
WX_EXPORT_METHOD(@selector(removeData:))

WX_EXPORT_METHOD_SYNC(@selector(setDataSync:data:))
WX_EXPORT_METHOD_SYNC(@selector(getDataSync:))
WX_EXPORT_METHOD_SYNC(@selector(deleteDataSync:))
WX_EXPORT_METHOD_SYNC(@selector(removeDataSync))

- (void)setData:(NSString *)key data:(id)data callback:(WXModuleCallback)callback
{
    if (![data isKindOfClass:[NSString class]]) {
        data = [data yy_modelToJSONString];
    }
    
    if (!data || !key) {
        
        if (callback) {
            NSDictionary *resData = [NSDictionary configCallbackDataWithResCode:MDSResCodeError msg:@"key or data error" data:nil];
            callback(resData);
        }
        
        return;
    }
    
    [[MDSDB DB] addOrUpdateData:data primatyKey:key success:^(BOOL success) {
        if (callback) {
            NSInteger status = success ? MDSResCodeSuccess : MDSResCodeError;
            NSDictionary *resData = [NSDictionary configCallbackDataWithResCode:status msg:nil data:nil];
            callback(resData);
        }
    }];
}

/** 存储数据 同步方法 */
- (NSDictionary *)setDataSync:(NSString *)key data:(id)data
{
    if (![data isKindOfClass:[NSString class]]) {
        data = [data yy_modelToJSONString];
    }
    
    if (!data || !key) return [NSDictionary configCallbackDataWithResCode:MDSResCodeError msg:@"key or data error" data:nil];
    
    BOOL success = [[MDSDB DB] addOrUpdateData:data primatyKey:key];
    NSInteger status = success ? MDSResCodeSuccess : MDSResCodeError;
    NSDictionary *resData = [NSDictionary configCallbackDataWithResCode:status msg:nil data:nil];
    return resData;
}

- (void)getData:(NSString *)key callback:(WXModuleCallback)callback
{
    if (!key) {
        if (callback) {
            NSDictionary *resData = [NSDictionary configCallbackDataWithResCode:MDSResCodeError msg:@"key error" data:nil];
            callback(resData);
        }
        return;
    }

    id data = [[MDSDB DB] queryWithPrimatyKey:key];
    if (callback) {
        NSInteger status = data ? MDSResCodeSuccess : MDSResCodeError;
        NSDictionary *resData = [NSDictionary configCallbackDataWithResCode:status msg:nil data:data];
        callback(resData);
    }
}

/** 获取数据 同步方法 */
- (id)getDataSync:(NSString *)key
{
    id data = [[MDSDB DB] queryWithPrimatyKey:key];
    NSInteger status = data ? MDSResCodeSuccess : MDSResCodeError;
    return [NSDictionary configCallbackDataWithResCode:status msg:nil data:data];
}

- (void)deleteData:(NSString *)key callback:(WXModuleCallback)callback
{
    if (!key) {
        if (callback) {
            NSDictionary *resData = [NSDictionary configCallbackDataWithResCode:MDSResCodeError msg:@"key error" data:nil];
            callback(resData);
        }
        return;
    }
    
    [[MDSDB DB] deleteWithPrimatyKey:key success:^(BOOL success) {
        if (callback) {
            NSInteger status = success ? MDSResCodeSuccess : MDSResCodeError;
            NSDictionary *resData = [NSDictionary configCallbackDataWithResCode:status msg:nil data:nil];
            callback(resData);
        }
    }];
}

/** 删除一条数据 同步方法 */
- (NSDictionary *)deleteDataSync:(NSString *)key
{
    if (!key) return nil;
    
    BOOL success = [[MDSDB DB] deleteWithPrimatyKey:key];
    NSInteger status = success ? MDSResCodeSuccess : MDSResCodeError;
    NSDictionary *resData = [NSDictionary configCallbackDataWithResCode:status msg:nil data:nil];
    return resData;
}

- (void)removeData:(WXModuleCallback)callback
{
    [[MDSDB DB] deleteAllSuccess:^(BOOL success) {
        if (callback) {
            NSInteger status = success ? MDSResCodeSuccess : MDSResCodeError;
            NSDictionary *resData = [NSDictionary configCallbackDataWithResCode:status msg:nil data:nil];
            callback(resData);
        }
    }];
}

/** 删除所有数据 同步方法 */
- (NSDictionary *)removeDataSync
{
    BOOL success = [[MDSDB DB] deleteAll];
    NSInteger status = success ? MDSResCodeSuccess : MDSResCodeError;
    NSDictionary *resData = [NSDictionary configCallbackDataWithResCode:status msg:nil data:nil];
    return resData;
}
@end

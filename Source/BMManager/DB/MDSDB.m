//
//  MDSDB.m
//  RealmDome
//
//  Created by jony on 2018/3/31.
//  Copyright © 2017年 本木医疗. All rights reserved.
//

#import "MDSDB.h"
#import <Realm/Realm.h>
#import "MDSDBBaseModel.h"
#import "MDSMediatorManager.h"
#import "MDSUserInfoModel.h"

#define K_LIBRARY_PATH [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0]
#define K_DB_PATH [K_LIBRARY_PATH stringByAppendingPathComponent:@"MDSDB"]
// 数据库新增字段等需要数据迁移的操作时 版本号 需要 +1
#define K_DB_VERSION 0

@implementation MDSDB
{
//    dispatch_queue_t _dbQueue;
}

#pragma mark - Private Method

- (instancetype)init
{
    if (self = [super init]) {
//        _dbQueue = dispatch_queue_create("com.benmu.dbqueue", DISPATCH_QUEUE_SERIAL);
    }
    return self;
}

#pragma mark 添加不同步iCould属性
- (BOOL)addSkipBackupAttributeToItemAtPath:(NSString *)filePathString
{
    NSURL* URL= [NSURL fileURLWithPath: filePathString];
    //    assert([[NSFileManager defaultManager] fileExistsAtPath: [URL path]]);
    
    NSError *error = nil;
    BOOL success = [URL setResourceValue: [NSNumber numberWithBool: YES]
                                  forKey: NSURLIsExcludedFromBackupKey error: &error];
    if(!success){
        WXLogError(@"【MDSDB ERROR】excluding %@ from backup %@", [URL lastPathComponent], error);
    }
    return success;
}

- (NSURL *)dbFileURL
{
    NSFileManager *fm = [NSFileManager defaultManager];
    
    BOOL isDir = false;
    BOOL isDirExist = [fm fileExistsAtPath:K_DB_PATH isDirectory:&isDir];
    
    if (!(isDir && isDirExist)) {
        [fm removeItemAtPath:K_DB_PATH error:nil];
        [fm createDirectoryAtPath:K_DB_PATH withIntermediateDirectories:YES attributes:nil error:nil];
        
        BOOL skipSuccess = [self addSkipBackupAttributeToItemAtPath:K_DB_PATH];
        if (skipSuccess) {
            WXLogInfo(@"【MDSDB Info】add skip attribute for directory success");
        }
    }
    
    NSString *dbFilePath = [[K_DB_PATH stringByAppendingPathComponent:@"mds"]
                            stringByAppendingPathExtension:@"realm"];
    return [NSURL fileURLWithPath:dbFilePath];
}

- (void)configDB
{
    
    RLMRealmConfiguration *config = [RLMRealmConfiguration defaultConfiguration];
    config.schemaVersion = K_DB_VERSION;
    config.fileURL = [self dbFileURL];
    [RLMRealmConfiguration setDefaultConfiguration:config];

    [self dbMigration];
}

/* 数据迁移 */
- (void)dbMigration
{
    RLMRealmConfiguration *config = [RLMRealmConfiguration defaultConfiguration];
    WXLogInfo(@"【MDSDB Info】%@",config.fileURL);
    
    config.migrationBlock = ^(RLMMigration *migration, uint64_t oldSchemaversion) {
    
        [migration enumerateObjects:[MDSDBBaseModel className] block:^(RLMObject * _Nullable oldObject, RLMObject * _Nullable newObject) {
            /* 判断数据库版本 给 MDSDBBaseModel 做数据迁移工作 */
        }];
        
        // ...
    };
    
}


#pragma mark - Public Method

+ (instancetype)DB
{
    static MDSDB *_instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[MDSDB alloc] init];
    });
    
    return _instance;
}

- (void)addOrUpdateData:(NSString *)data primatyKey:(NSString *)key success:(MDSDBHandleBlock)result
{
//    dispatch_async(_dbQueue, ^{
    
        NSError *error = nil;
        RLMRealm *realm = [RLMRealm defaultRealm];
        
        /* 根据主键查询数据 */
        MDSDBBaseModel *model = [MDSDBBaseModel objectForPrimaryKey:key];
        
        /* 数据不存在将 newModel 保存到数据库中 */
        if (!model) {
            model = [[MDSDBBaseModel alloc] init];
            model.key = key;
            model.data = data;
            [realm transactionWithBlock:^{
                [realm addOrUpdateObject:model];
            } error:&error];
        }
        /* 更新数据 */
        else
        {
            [realm transactionWithBlock:^{
                model.data = data;
            } error:&error];
        }
        
        if (error) {
            WXLogError(@"【MDSDB ERROR】:%@",error);
            if (result) result(NO);
        } else {
            if (result) result(YES);
        }
//    });
}

- (BOOL)addOrUpdateData:(NSString *)data primatyKey:(NSString *)key
{
    NSError *error = nil;
    RLMRealm *realm = [RLMRealm defaultRealm];
    
    /* 根据主键查询数据 */
    MDSDBBaseModel *model = [MDSDBBaseModel objectForPrimaryKey:key];
    
    /* 数据不存在将 newModel 保存到数据库中 */
    if (!model) {
        model = [[MDSDBBaseModel alloc] init];
        model.key = key;
        model.data = data;
        [realm transactionWithBlock:^{
            [realm addOrUpdateObject:model];
        } error:&error];
    }
    /* 更新数据 */
    else
    {
        [realm transactionWithBlock:^{
            model.data = data;
        } error:&error];
    }
    
    if (error) {
        WXLogError(@"【MDSDB ERROR】:%@",error);
        return NO;
    }
    return YES;
}

- (NSString *)queryWithPrimatyKey:(NSString *)key
{
    MDSDBBaseModel *dataModel = [MDSDBBaseModel objectForPrimaryKey:key];
    if (dataModel) {
        return dataModel.data;
    }
    return nil;
}

- (void)deleteWithPrimatyKey:(NSString *)key success:(MDSDBHandleBlock)result
{
//    dispatch_async(_dbQueue, ^{
    
        MDSDBBaseModel *model = [MDSDBBaseModel objectForPrimaryKey:key];
        
        if (!model) {
//            WXLogInfo(@"【MDSDB ERROR】: 主键为 %@ 的数据不存在",key);
            if (result) result(NO);
            
            return;
        }
        
        NSError *error = nil;
        RLMRealm *realm = [RLMRealm defaultRealm];
        
        [realm transactionWithBlock:^{
            [realm deleteObject:model];
        } error:&error];
        
        if (error) {
            WXLogError(@"【MDSDB ERROR】:%@",error);
            if (result) result(NO);
        } else {
            if (result) result(YES);
        }
        
//    });
}

- (BOOL)deleteWithPrimatyKey:(NSString *)key
{
    MDSDBBaseModel *model = [MDSDBBaseModel objectForPrimaryKey:key];
    if (!model) {
//      WXLogInfo(@"【MDSDB ERROR】: 主键为 %@ 的数据不存在",key);
        return NO;
    }
    
    NSError *error = nil;
    RLMRealm *realm = [RLMRealm defaultRealm];
    
    [realm transactionWithBlock:^{
        [realm deleteObject:model];
    } error:&error];
    
    if (error) {
        WXLogError(@"【MDSDB ERROR】:%@",error);
        return NO;
    }
    return YES;
}

- (void)deleteAllSuccess:(MDSDBHandleBlock)result
{
//    dispatch_async(_dbQueue, ^{
    
        NSError *error = nil;
        RLMRealm *realm = [RLMRealm defaultRealm];
        
        [realm transactionWithBlock:^{
            [realm deleteAllObjects];
        } error:&error];
        
        if (error) {
            WXLogError(@"【MDSDB ERROR】:%@",error);
            if (result) result(NO);
        } else {
            if (result) result(YES);
        }
        
//    });
}

- (BOOL)deleteAll
{
    NSError *error = nil;
    RLMRealm *realm = [RLMRealm defaultRealm];
    
    [realm transactionWithBlock:^{
        [realm deleteAllObjects];
    } error:&error];
    
    if (error) {
        WXLogError(@"【MDSDB ERROR】:%@",error);
        return NO;
    }
    return YES;
}

@end

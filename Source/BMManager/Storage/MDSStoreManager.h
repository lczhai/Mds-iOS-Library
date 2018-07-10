//
//  MDSStoreManager.h
//  WeexDemo
//
//  Created by jony on 2018/2/7.
//  Copyright © 2017年 taobao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MDSDefine.h"

#define K_STORAGE_PATH [K_DOCUMENT_PATH stringByAppendingPathComponent:@"storage"]

@interface MDSStoreManager : NSObject

/**
 获取存储目录

 @param key key
 @return 存储目录
 */
+ (NSString *)getDataPathWithKey:(NSString *)key;

/**
 *  将对象归档
 *
 *  @param obj      对象 注：必须是可归档对象
 *  @param filePath 路径
 *
 *  @return 是否成功
 */
+ (BOOL)archiveObject:(id)obj toFilePath:(NSString *)filePath;

/**
 *  解档
 *
 *  @param filePath 路径
 *
 *  @return 解档对象
 */
+ (id)unarchiveObjectWithFilePath:(NSString *)filePath;

/**
 *  判断文件是否存在
 *
 *  @param filePath 路径
 *
 *  @return bool
 */
+ (BOOL)fileExistsAtPath:(NSString *)filePath;

/**
 *  删除目录下的文件
 *
 *  @param filePath 路径
 *
 *  @return 是否删除成功
 */
+ (BOOL)deleteFileAtPath:(NSString *)filePath;

@end

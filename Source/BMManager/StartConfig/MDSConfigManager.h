//
//  MDSConfigManager.h
//  WeexDemo
//
//  Created by jony on 2018/1/10.
//  Copyright © 2017年 taobao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MDSPlatformModel.h"

@interface MDSConfigManager : NSObject

@property (nonatomic, readonly) MDSPlatformModel *platform;

@property (nonatomic,strong) NSDictionary *envInfo; /**< 环境信息 */

+ (instancetype)shareInstance;

/** app启动时候配置一些参数 */
+ (void)configDefaultData;

/** 其他app掉起app回调方法 */
- (BOOL)applicationOpenURL:(NSURL *)url;

@end

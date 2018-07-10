//
//  MDSResourceManager.h
//  MDS-Chia
//
//  Created by 窦静轩 on 2017/3/10.
//  Copyright © 2017年 XHY. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MDSJSVersionModel;
//@interface MDSJSVersionModel : NSObject
//
//@property (nonatomic, copy) NSString *jsPath;           // js资源包下载地址
//@property (nonatomic, copy) NSString *jsVersion;        // js版本号
//
//@end
//
//@implementation MDSJSVersionModel
//
//@end



@interface MDSResourceManager : NSObject

+ (instancetype)sharedInstance;

@property (nonatomic,strong)MDSJSVersionModel * model;
@property (nonatomic,copy) NSString *mdsWidgetJs; /**< 前端封装的widgets需要native端拼接到每个js文件之前 */

-(void)checkNewVersion:(BOOL)isDiff;

-(NSDictionary*)loadConfigData:(NSString*)configPath;

/** 比较工程中、cache、当前加载的js版本，应用最新的资源文件 */
-(void)compareVersion;

@end

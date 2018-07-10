//
//  MDSImageManager.h
//  WeexDemo
//
//  Created by jony on 2018/2/10.
//  Copyright © 2017年 taobao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WeexSDK/WeexSDK.h>
#import "MDSUploadImageModel.h"

@interface MDSImageManager : NSObject

+ (void)camera:(MDSUploadImageModel *)model weexInstance:(WXSDKInstance *)weexInstance callback:(WXModuleCallback)callback;

+ (void)pick:(MDSUploadImageModel *)model weexInstance:(WXSDKInstance *)weexInstance callback:(WXModuleCallback)callback;

+ (void)uploadImageWithInfo:(MDSUploadImageModel *)model weexInstance:(WXSDKInstance *)weexInstance callback:(WXModuleCallback)callback;

+ (void)uploadImage:(NSArray *)images uploadImageModel:(MDSUploadImageModel *)model callback:(WXModuleCallback)callback;

@end

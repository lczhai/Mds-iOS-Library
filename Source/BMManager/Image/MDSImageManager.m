//
//  MDSImageManager.m
//  WeexDemo
//
//  Created by jony on 2018/2/10.
//  Copyright © 2017年 taobao. All rights reserved.
//

#import "MDSImageManager.h"
#import "MDSUploadImageUtils.h"

@interface MDSImageManager ()

@property (nonatomic, strong) MDSUploadImageUtils *uploadImageUtils;

@end

@implementation MDSImageManager

#pragma mark - Setter / Getter

- (MDSUploadImageUtils *)uploadImageUtils
{
    if (!_uploadImageUtils) {
        _uploadImageUtils = [[MDSUploadImageUtils alloc] init];
    }
    return _uploadImageUtils;
}

#pragma mark - Private Method

+ (instancetype)shareInstance
{
    static MDSImageManager *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[MDSImageManager alloc] init];
    });
    return _instance;
}

#pragma mark - Public Method

+ (void)camera:(MDSUploadImageModel *)model weexInstance:(WXSDKInstance *)weexInstance callback:(WXModuleCallback)callback
{
    [[MDSImageManager shareInstance].uploadImageUtils camera:model weexInstance:weexInstance callback:callback];
}

+ (void)pick:(MDSUploadImageModel *)model weexInstance:(WXSDKInstance *)weexInstance callback:(WXModuleCallback)callback
{
    [[MDSImageManager shareInstance].uploadImageUtils pick:model weexInstance:weexInstance callback:callback];
}

+ (void)uploadImageWithInfo:(MDSUploadImageModel *)model weexInstance:(WXSDKInstance *)weexInstance callback:(WXModuleCallback)callback
{
    [[MDSImageManager shareInstance].uploadImageUtils uploadImageWithInfo:model weexInstance:weexInstance callback:callback];
}

+ (void)uploadImage:(NSArray *)images uploadImageModel:(MDSUploadImageModel *)model callback:(WXModuleCallback)callback
{
    [[MDSImageManager shareInstance].uploadImageUtils uploadImage:images uploadImageModel:model callback:callback];
}

@end

//
//  MDSCameraModule.m
//  WeexDemo
//
//  Created by jony on 2018/2/4.
//  Copyright © 2017年 taobao. All rights reserved.
//

#import "MDSCameraModule.h"

#import "MDSScanQRViewController.h"

#import "MDSImageManager.h"
#import <MDSScreenshotEventManager.h>

#import "MDSUploadImageModel.h"
#import <YYModel/YYModel.h>

#import <TZImagePickerController/TZImagePickerController.h>


@implementation MDSCameraModule

@synthesize weexInstance;

WX_EXPORT_METHOD(@selector(scan:))
WX_EXPORT_METHOD(@selector(uploadImage:callback:))
WX_EXPORT_METHOD(@selector(uploadScreenshot:))


- (void)scan:(WXModuleCallback)callback
{
    MDSScanQRViewController *scanQrVc = [[MDSScanQRViewController alloc] init];
    scanQrVc.hidesBottomBarWhenPushed = YES;
    scanQrVc.callback = callback;
    [weexInstance.viewController.navigationController pushViewController:scanQrVc animated:YES];
}

- (void)uploadImage:(NSDictionary *)info callback:(WXModuleCallback)callback
{
    MDSUploadImageModel *model = [MDSUploadImageModel yy_modelWithJSON:info];
    [MDSImageManager uploadImageWithInfo:model weexInstance:weexInstance callback:callback];
}

- (void)uploadScreenshot:(WXModuleCallback)callback
{
    if (![[MDSScreenshotEventManager shareInstance] snapshotImage]) {
        NSDictionary *resDic = [NSDictionary configCallbackDataWithResCode:MDSResCodeError msg:@"截屏图片不存在" data:nil];
        if (callback) {
            callback(resDic);
        }
        return;
    }
    NSArray *images = @[[[MDSScreenshotEventManager shareInstance] snapshotImage]];
    [MDSImageManager uploadImage:images uploadImageModel:nil callback:callback];
}

@end

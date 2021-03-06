//
//  MDSAxiosNetworkModule.m
//  WeexDemo
//
//  Created by jony on 2018/1/13.
//  Copyright © 2017年 taobao. All rights reserved.
//

#import "MDSAxiosNetworkModule.h"
#import "MDSAxiosRequestModel.h"
#import "MDSCommonRequest.h"
#import "MDSBaseViewController.h"
#import "MDSUserInfoModel.h"
#import "MDSImageManager.h"

@implementation MDSAxiosNetworkModule

@synthesize weexInstance;

WX_EXPORT_METHOD(@selector(fetch:callback:))
WX_EXPORT_METHOD(@selector(uploadImage::))


- (void)fetch:(NSDictionary *)info callback:(WXModuleCallback)callback
{
    /* 添加判断 */
    if (![info isKindOfClass:[NSDictionary class]]) {
        WXLogError(@"js request info Error");
        return;
    }
    
    WXLogInfo(@"js request info: %@",info);
    
    MDSAxiosRequestModel *requestModel = [MDSAxiosRequestModel yy_modelWithJSON:info];
    
    MDSCommonRequest *api = [[MDSCommonRequest alloc] initWithRequestModel:requestModel];
    
    [((MDSBaseViewController *)weexInstance.viewController) addRequest:api];
    
    [api startRequestResult:^(id data) {
       
        WXLogInfo(@"request data: %@",data);
        
        if (callback) {
            callback(data);
        }
        
    }];
    
    WXLogInfo(@"%@",api.originalRequest);
}

- (void)uploadImage:(NSDictionary *)info :(WXModuleCallback)callback
{
    MDSUploadImageModel *model = [MDSUploadImageModel yy_modelWithJSON:info];
    NSArray *images = info[@"images"];
    if (!images || !images.count) {
        if (callback) {
            NSDictionary *resData = [NSDictionary configCallbackDataWithResCode:MDSResCodeError msg:@"上传图片参数错误" data:nil];
            callback(resData);
        }
        return;
    }
    [MDSImageManager uploadImage:images uploadImageModel:model callback:callback];
}

@end

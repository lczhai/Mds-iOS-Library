//
//  MDSUpdateBundlejsRequest.h
//  WeexDemo
//
//  Created by jony on 2018/1/10.
//  Copyright © 2017年 taobao. All rights reserved.
//

#import "MDSBaseRequest.h"

@interface MDSUpdateBundlejsRequest : MDSBaseRequest

- (instancetype)initWithDownloadJSUrl:(NSString *)downloadUrl;


/**
 将当前下载的临时文件信息保存到指定目录 以便下次继续断点续传
 */
- (void)saveIncompleteDownloadTempData;

@end

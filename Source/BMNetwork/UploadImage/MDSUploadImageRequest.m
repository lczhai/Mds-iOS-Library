//
//  MDSUploadImageRequest.m
//  WeexDemo
//
//  Created by jony on 2018/2/10.
//  Copyright © 2017年 taobao. All rights reserved.
//

#import "MDSUploadImageRequest.h"
#import "AFURLRequestSerialization.h"

@interface MDSUploadImageRequest ()

@property (nonatomic, strong) MDSUploadImageModel *imageModel;

@end

@implementation MDSUploadImageRequest

- (instancetype)initWithImage:(UIImage *)image uploadImageModel:(MDSUploadImageModel *)imageModel
{
    if (self = [super init]) {
        _image = image;
        _imageModel = imageModel;
    }
    return self;
}

- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodPOST;
}

- (NSString *)baseUrl
{
    return nil;
}

/** 添加自定义 Headers */
- (NSDictionary *)requestHeaderFieldValueDictionary
{
    if (self.imageModel.header) {
        return self.imageModel.header;
    }
    return nil;
}

- (NSString *)requestUrl
{
    return self.imageModel.url ?: TK_PlatformInfo().url.image;
}

- (AFConstructingBlock)constructingBodyBlock {
    return ^(id<AFMultipartFormData> formData) {
        NSData *data = UIImageJPEGRepresentation(_image, 0.8);
        NSString *name = @"picture.jpg";
        NSString *formKey = @"file";
        NSString *type = @"image/jpeg";
        [formData appendPartWithFileData:data name:formKey fileName:name mimeType:type];
    };
}

- (id)requestArgument
{
    return self.imageModel.params;
}

@end

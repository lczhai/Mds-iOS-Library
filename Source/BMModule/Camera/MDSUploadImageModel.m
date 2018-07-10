//
//  MDSUploadImageModel.m
//  MDS-Chia
//
//  Created by jony on 2018/3/8.
//  Copyright © 2017年 XHY. All rights reserved.
//

#import "MDSUploadImageModel.h"

@implementation MDSUploadImageModel

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    
    if (!_imageWidth) {
        _imageWidth = 800;
    }
    
    if ([_url isEqualToString:@""]) {
        _url = nil;
    }
    
    return YES;
}

@end

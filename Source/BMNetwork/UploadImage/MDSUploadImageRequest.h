//
//  MDSUploadImageRequest.h
//  WeexDemo
//
//  Created by jony on 2018/2/10.
//  Copyright © 2017年 taobao. All rights reserved.
//

#import "MDSBaseRequest.h"
#import <UIKit/UIKit.h>
#import "MDSUploadImageModel.h"

@interface MDSUploadImageRequest : MDSBaseRequest

- (instancetype)initWithImage:(UIImage *)image uploadImageModel:(MDSUploadImageModel *)imageModel;

@property (nonatomic,strong)UIImage * image;

@end

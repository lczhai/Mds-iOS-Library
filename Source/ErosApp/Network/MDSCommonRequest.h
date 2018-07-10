//
//  MDSCommonRequest.h
//  WeexDemo
//
//  Created by jony on 2018/1/13.
//  Copyright © 2017年 taobao. All rights reserved.
//

#import "MDSBaseRequest.h"
@class MDSAxiosRequestModel;

@interface MDSCommonRequest : MDSBaseRequest

- (instancetype)initWithRequestModel:(MDSAxiosRequestModel *)model;

@end

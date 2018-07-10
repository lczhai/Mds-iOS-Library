//
//  MDSCommonRequest.m
//  WeexDemo
//
//  Created by jony on 2018/1/13.
//  Copyright © 2017年 taobao. All rights reserved.
//

#import "MDSCommonRequest.h"
#import "MDSAxiosRequestModel.h"
#import "MDSUserInfoModel.h"

@implementation MDSCommonRequest
{
    MDSAxiosRequestModel *_model;
}

- (YTKRequestMethod)requestMethod
{
    if (!_model.method || [_model.method isEqualToString:@"GET"]) {
        return YTKRequestMethodGET;
    }
    
    if ([_model.method isEqualToString:@"HEAD"]) {
        return YTKRequestMethodHEAD;
    }
    
    if ([_model.method isEqualToString:@"PUT"]) {
        return YTKRequestMethodPUT;
    }
    
    if ([_model.method isEqualToString:@"DELETE"]) {
        return YTKRequestMethodDELETE;
    }
    
    if ([_model.method isEqualToString:@"PATCH"]) {
        return YTKRequestMethodPATCH;
    }
    
    return YTKRequestMethodPOST;
}

- (NSString *)requestURLPath
{
    return [NSURL URLWithString:_model.url].path;
}

- (NSString *)baseUrl
{
    return @"";
}

/** 添加自定义 Headers */
- (NSDictionary *)requestHeaderFieldValueDictionary
{
    /** headers */
    NSMutableDictionary *headers = [NSMutableDictionary dictionary];
    if (_model.header) {
        [headers setValuesForKeysWithDictionary:_model.header];
    }
    
    return headers;
}

- (YTKRequestSerializerType)requestSerializerType
{
    if ([_model.header[@"Content-Type"] isEqualToString:@"application/x-www-form-urlencoded"]) {
        return YTKRequestSerializerTypeHTTP;
    }
    return YTKRequestSerializerTypeJSON;
}

- (NSString *)requestUrl
{
    return _model.url ?: @"";
}

- (instancetype)initWithRequestModel:(MDSAxiosRequestModel *)model
{
    if (self = [super init]) {
        _model = model;
    }
    return self;
}

- (id)requestArgument
{
    return _model.data;
}

- (CGFloat)requestTimeoutInterval
{
    return _model.timeout > 0 ? _model.timeout / 1000.0 : 30;
}

@end

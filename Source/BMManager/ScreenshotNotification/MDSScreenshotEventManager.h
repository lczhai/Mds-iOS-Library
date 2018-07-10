//
//  MDSScreenshotEventManager.h
//  Pods
//
//  Created by jony on 2018/5/12.
//
//

#import <Foundation/Foundation.h>

@interface MDSScreenshotEventManager : NSObject

+ (instancetype)shareInstance;

/* 获取截屏的图片 */
- (UIImage *)snapshotImage;

/**
 开启监听截屏事件
 */
- (void)monitorScreenshotEvent;

@end

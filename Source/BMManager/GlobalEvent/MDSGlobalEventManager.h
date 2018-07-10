//
//  MDSGlobalEventManager.h
//  MDS-Chia
//
//  Created by jony on 2018/3/3.
//  Copyright © 2017年 XHY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WeexSDK/WeexSDK.h>

/**
 通知js当前页面的状态
 
 - MDSControllerStateOpen: 首次打开
 - MDSControllerStateBack: 从其他页面返回
 - MDSControllerStateRefresh: 页面重新加载（refreshWeex）
 */
typedef NS_OPTIONS(NSUInteger, MDSControllerState) {
    MDSControllerStateOpen = 0,
    MDSControllerStateBack,
    MDSControllerStateRefresh
};

/* 页面生命周期相关事件 */
#define MDSControllerStateArray  @[@"open",@"back",@"refresh"]
static NSString * const MDSViewWillAppear = @"viewWillAppear";
static NSString * const MDSViewDidAppear = @"viewDidAppear";
static NSString * const MDSViewWillDisappear = @"viewWillDisappear";
static NSString * const MDSViewDidDisappear = @"viewDidDisappear";

/* 截屏意见反馈事件 */
static NSString * const MDSScreenshotFeedbackEvent = @"screenshotFeedback";

/** weex 首屏渲染完毕通知 */
static NSString * const MDSFirstScreenDidFinish = @"MDSFirstScreenDidFinish";

@interface MDSGlobalEventManager : NSObject


/**
 发送全局时间

 @param event 时间名称
 @param params 参数
 */
+ (void)sendGlobalEvent:(NSString *)event params:(NSDictionary *)params;

/**
 发送页面生命周期事件

 @param instance WXSDKInstance实例
 @param event 事件名称（对应js方法名）
 @param state 页面状态
 */
+ (void)sendViewLifeCycleEventWithInstance:(WXSDKInstance *)instance event:(NSString *)event controllerState:(MDSControllerState)state;

/* 收到推送通知后发送事件给js */
+ (void)pushMessage:(NSDictionary *)info appLaunchedByNotification:(BOOL)isLaunchedByNotification;

@end

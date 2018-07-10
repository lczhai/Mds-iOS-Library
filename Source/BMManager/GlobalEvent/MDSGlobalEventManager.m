//
//  MDSGlobalEventManager.m
//  MDS-Chia
//
//  Created by jony on 2018/3/3.
//  Copyright © 2017年 XHY. All rights reserved.
//

#import "MDSGlobalEventManager.h"
#import "MDSMediatorManager.h"

@implementation MDSGlobalEventManager

#pragma mark - Setter / Getter

#pragma mark - Private Method

+ (instancetype)shaerInstance
{
    static MDSGlobalEventManager *_instanc = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instanc = [[MDSGlobalEventManager alloc] init];
        [_instanc addObserver];
    });
    return _instanc;
}

- (void)_sendGlobalEvent:(NSString *)event params:(NSDictionary *)params
{
    [[MDSMediatorManager shareInstance].currentWXInstance fireGlobalEvent:event params:params];
}

- (void)addObserver
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillResignActive:) name:UIApplicationWillResignActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidBecomeActive:) name:UIApplicationDidBecomeActiveNotification object:nil];
}

- (void)applicationWillResignActive:(NSNotification *)notification
{
    [self _sendGlobalEvent:@"appDeactive" params:nil];
}

- (void)applicationDidBecomeActive:(NSNotification *)notification
{
    [self _sendGlobalEvent:@"appActive" params:nil];
}

- (void)sendGlobalEventwithInstance:(WXSDKInstance *)instance event:(NSString *)event params:(NSDictionary *)params
{
    /** 首屏渲染成功发送一次通知 */
    if ([event isEqualToString:MDSViewDidAppear]) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:MDSFirstScreenDidFinish object:nil];
        });
    }
    
    [instance fireGlobalEvent:event params:params];
}

#pragma mark - Api Request

#pragma mark - Custom Delegate & DataSource

#pragma mark - System Delegate & DataSource

#pragma mark - Public Method

+ (void)sendViewLifeCycleEventWithInstance:(WXSDKInstance *)instance event:(NSString *)event controllerState:(MDSControllerState)state
{
    NSDictionary *params = @{@"type": MDSControllerStateArray[state]};
    [[MDSGlobalEventManager shaerInstance] sendGlobalEventwithInstance:instance event:event params:params];
}

+ (void)pushMessage:(NSDictionary *)info appLaunchedByNotification:(BOOL)isLaunchedByNotification
{
    NSMutableDictionary *date = [NSMutableDictionary dictionaryWithDictionary:info];
    [date setValue:[NSNumber numberWithBool:isLaunchedByNotification] forKey:@"trigger"];
    [[MDSGlobalEventManager shaerInstance] _sendGlobalEvent:@"pushMessage" params:date];
}

+ (void)sendGlobalEvent:(NSString *)event params:(NSDictionary *)params
{
    [[MDSGlobalEventManager shaerInstance] _sendGlobalEvent:event params:params];
}

@end

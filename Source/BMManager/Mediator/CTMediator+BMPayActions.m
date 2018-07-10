//
//  CTMediator+BMPayActions.m
//  MDSBaseLibrary
//
//  Created by XHY on 2018/4/25.
//

#import "CTMediator+BMPayActions.h"

NSString *const kCTMediatorWXPayTarget = @"MDSWXPay";
NSString *const kCTMediatorActionPayHandleOpenURL = @"PayHandleOpenURL";

@implementation CTMediator (BMPayActions)

- (BOOL)CTMediator_PayHandleOpenURL:(NSDictionary *)info
{
    id result = [self performTarget:kCTMediatorWXPayTarget
                             action:kCTMediatorActionPayHandleOpenURL
                             params:info
                  shouldCacheTarget:NO];
    return [result boolValue];
}

@end

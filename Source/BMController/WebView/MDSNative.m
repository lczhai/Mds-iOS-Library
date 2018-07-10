//
//  MDSNative.m
//  MDSBaseLibrary
//
//  Created by XHY on 2018/7/2.
//

#import "MDSNative.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "MDSMediatorManager.h"
#import "MDSNotifactionCenter.h"

@protocol MDSJSExport <JSExport>

- (void)closePage;
- (void)fireEvent:(NSString *)event :(id)info;

@end

@interface MDSNative () <MDSJSExport>

@end

@implementation MDSNative

- (void)dealloc
{
    WXLogInfo(@"MDSNative dealloc");
}

- (void)closePage {
    dispatch_async(dispatch_get_main_queue(), ^{
        [[MDSMediatorManager shareInstance].currentViewController.navigationController popViewControllerAnimated:YES];
        [[MDSMediatorManager shareInstance].currentViewController dismissViewControllerAnimated:YES completion:nil];
    });
}

- (void)fireEvent:(NSString *)event :(id)info {
    [[MDSNotifactionCenter defaultCenter] emit:event info:info];
}

@end

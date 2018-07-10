//
//  WXScrollerComponent+BMExtend.h
//  MDS-Chia
//
//  Created by jony on 2018/3/20.
//  Copyright © 2017年 XHY. All rights reserved.
//

#import <WeexSDK/WeexSDK.h>
#import <WeexSDK/WXScrollerComponent.h>

@interface WXScrollerComponent (BMExtend)

- (instancetype)mdsScroller_initWithRef:(NSString *)ref type:(NSString *)type styles:(NSDictionary *)styles attributes:(NSDictionary *)attributes events:(NSArray *)events weexInstance:(WXSDKInstance *)weexInstance;

- (void)mdsScroller_scrollViewDidScroll:(UIScrollView *)scrollView;

- (UIView *)mdsScroller_loadView;

- (UIView *)mdsList_loadView;

- (void)mdsScroller_viewDidLoad;

@end

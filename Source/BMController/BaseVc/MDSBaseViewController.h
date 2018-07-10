//
//  MDSBaseViewController.h
//  WeexDemo
//
//  Created by jony on 2018/1/12.
//  Copyright © 2017年 taobao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDSRouterModel.h"
#import "MDSCommonRequest.h"

@interface MDSBaseViewController : UIViewController

@property (nonatomic, strong) WXSDKInstance *instance;      /**< instance */
@property (nonatomic, strong) NSURL *url;
@property (nonatomic, strong) MDSRouterModel *routerModel;   /**< 页面导航信息 */

/* 刷新weex页面 */
- (void)refreshWeex;

/* 属于此页面的请求 请调用此方法来将请求的引用添加给此页面，在页面执行viewDidAppear方法时会cancel掉请求 */
- (void)addRequest:(MDSCommonRequest *)request;

@end

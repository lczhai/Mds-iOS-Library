//
//  MDSWebViewController.h
//  MDS-Chia
//
//  Created by jony on 2018/2/28.
//  Copyright © 2017年 XHY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDSWebViewRouterModel.h"

@interface MDSWebViewController : UIViewController

@property (nonatomic, strong) MDSWebViewRouterModel *routerInfo;

- (instancetype)initWithRouterModel:(MDSWebViewRouterModel *)model;

@end

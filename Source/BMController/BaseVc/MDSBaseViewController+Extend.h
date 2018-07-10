//
//  MDSBaseViewController+Extend.h
//  MDS-Chia
//
//  Created by jony on 2018/3/16.
//  Copyright © 2017年 XHY. All rights reserved.
//

#import "MDSBaseViewController.h"

@interface MDSBaseViewController(Extend) <UIViewControllerTransitioningDelegate>


/* 添加返回按钮 */
- (void)addBackBarbuttonItem;

/* dismiss 页面 */
- (void)dismissViewController;

@end

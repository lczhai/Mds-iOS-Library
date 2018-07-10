//
//  MDSBaseViewController+Extend.m
//  MDS-Chia
//
//  Created by jony on 2018/3/16.
//  Copyright © 2017年 XHY. All rights reserved.
//

#import "MDSBaseViewController+Extend.h"
#import "MDSMediatorManager.h"
#import <MDSPresentLikeQQTransition.h>
#import <MDSInteractiveTransition.h>
#import <MDSPresentTranslationTransition.h>

@implementation MDSBaseViewController (Extend)

- (BOOL)currentVcIs:(NSString *)url
{
    return [self.url.absoluteString rangeOfString:url].location != NSNotFound;
}

- (void)addBackBarbuttonItem
{
    if (!self.routerModel.navShow ) {
        return;
    }
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"NavBar_BackItemIcon"] style:UIBarButtonItemStylePlain target:self action:@selector(dismissVC)];
    self.navigationItem.leftBarButtonItem = item;
}

- (void)dismissVC
{
    /* 如果存在 backCallback 则回调 callback方法*/
    if (self.routerModel.isRunBackCallback && self.routerModel.backCallback) {
        self.routerModel.backCallback(nil);
        return;
    }
    
    if ([self.routerModel.type isEqualToString:K_ANIMATE_PRESENT] ||
        [self.routerModel.type isEqualToString:K_ANIMATE_TRANSLATION]) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - UIViewControllerTransitioningDelegate
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    if ([self.routerModel.type isEqualToString:K_ANIMATE_TRANSLATION]) {
        return [MDSPresentTranslationTransition transitionWithTransitionType:MDSPresentTranslationTransitionTypePresent];
//        return [MDSPresentLikeQQTransition transitionWithTransitionType:MDSPresentLikeQQTransitionTypePresent];
    }
    return nil;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    if ([self.routerModel.type isEqualToString:K_ANIMATE_TRANSLATION]) {
        return [MDSPresentTranslationTransition transitionWithTransitionType:MDSPresentTranslationTransitionTypeDismiss];
//        return [MDSPresentLikeQQTransition transitionWithTransitionType:MDSPresentLikeQQTransitionTypeDismiss];
    }
    return nil;
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator
{
    /** 手势控制动画 */
//    if ([self.routerModel.animateType isEqualToString:K_ANIMATE_TRANSLATION]) {
//        MDSInteractiveTransition *interactiveDismiss = objc_getAssociatedObject(self, "mdsInteractive");
//        if (interactiveDismiss && interactiveDismiss.interation) {
//            return interactiveDismiss;
//        }
//    }
    return nil;
}

@end

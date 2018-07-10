//
//  MDSPresentLikeQQTransition.h
//  Pods
//
//  Created by jony on 2018/5/16.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger,MDSPresentLikeQQTransitionType) {
    MDSPresentLikeQQTransitionTypePresent = 0,   /* present方式 */
    MDSPresentLikeQQTransitionTypeDismiss        /* dismiss方式 */
};

@interface MDSPresentLikeQQTransition : NSObject <UIViewControllerAnimatedTransitioning>

+ (instancetype)transitionWithTransitionType:(MDSPresentLikeQQTransitionType)type;
- (instancetype)initWithTransitionType:(MDSPresentLikeQQTransitionType)type;

@end

//
//  MDSInteractiveTransition.h
//  Pods
//
//  Created by jony on 2018/5/23.
//
//

#import <UIKit/UIKit.h>

typedef void(^MDSGestureConfig)();

/* 手势方向 */
typedef NS_ENUM(NSUInteger, MDSInteractiveTransitionGestureDirection) {
    MDSInteractiveTransitionGestureDirectionLeft = 0,
    MDSInteractiveTransitionGestureDirectionRight,
    MDSInteractiveTransitionGestureDirectionUp,
    MDSInteractiveTransitionGestureDirectionDown
};

/* 手势控制哪种转场 */
typedef NS_ENUM(NSUInteger, MDSInteractiveTransitionType) {
    MDSInteractiveTransitionTypePresent = 0,
    MDSInteractiveTransitionTypeDismiss,
    MDSInteractiveTransitionTypePush,
    MDSInteractiveTransitionTypePop,
};

@interface MDSInteractiveTransition : UIPercentDrivenInteractiveTransition

@property (nonatomic, assign) BOOL interation;
@property (nonatomic, copy) MDSGestureConfig presentConfig;
@property (nonatomic, copy) MDSGestureConfig pushConfig;

/** 初始化方法 */
+ (instancetype)interactiveTransitionWithTransitionType:(MDSInteractiveTransitionType)type GestureDirection:(MDSInteractiveTransitionGestureDirection)direction;
- (instancetype)initWithTransitionType:(MDSInteractiveTransitionType)type GestureDirection:(MDSInteractiveTransitionGestureDirection)direction;

/** 给传入的控制器添加手势 */
- (void)addPanGestureForViewController:(UIViewController *)viewController;

- (void)addPanGestureForView:(UIView *)view handleViewController:(UIViewController *)viewController;

- (void)startInteractiveTransition:(nonnull id<UIViewControllerContextTransitioning>)transitionContext;

@end

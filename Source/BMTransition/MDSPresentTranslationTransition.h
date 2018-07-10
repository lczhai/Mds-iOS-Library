//
//  MDSPresentTranslationTransition.h
//  Pods
//
//  Created by jony on 2018/5/24.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger,MDSPresentTranslationTransitionType) {
    MDSPresentTranslationTransitionTypePresent = 0,   /* present方式 */
    MDSPresentTranslationTransitionTypeDismiss        /* dismiss方式 */
};

@interface MDSPresentTranslationTransition : NSObject <UIViewControllerAnimatedTransitioning>

+ (instancetype)transitionWithTransitionType:(MDSPresentTranslationTransitionType)type;
- (instancetype)initWithTransitionType:(MDSPresentTranslationTransitionType)type;

@end

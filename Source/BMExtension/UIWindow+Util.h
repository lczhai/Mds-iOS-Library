//
//  UIWindow+Util.h
//  Pods
//
//  Created by jony on 2018/7/12.
//
//

#import <UIKit/UIKit.h>

@interface UIWindow (Util)

/** 查询当前栈顶 window */
+ (UIWindow *)findVisibleWindow;

@end

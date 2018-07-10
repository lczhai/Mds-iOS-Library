//
//  WatermarkView.h
//  Pods
//
//  Created by jony on 2018/8/9.
//
//

#import <UIKit/UIKit.h>

@interface WatermarkView : UIView

/** 添加文字水印的view到 Window上 */
+ (void)addWatermarkWithText:(NSString *)text;

@end

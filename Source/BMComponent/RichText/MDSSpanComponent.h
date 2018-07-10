//
//  MDSSpanComponent.h
//  Pods
//
//  Created by jony on 2018/6/14.
//
//

#import <WeexSDK/WeexSDK.h>

@interface MDSSpanComponent : WXComponent

@property (nonatomic, copy) NSString *text;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, assign) CGFloat fontSize;
@property (nonatomic, copy) NSString *fontFamily;
@property (nonatomic, assign) CGFloat fontWeight;
@property (nonatomic, assign) WXTextStyle fontStyle;
@property (nonatomic, assign) WXTextDecoration textDecoration;

@property (nonatomic, assign) BOOL clickEvent;

@end

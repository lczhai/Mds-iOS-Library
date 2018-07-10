//
//  MDSInputView.h
//  MDS-Chia
//
//  Created by 窦静轩 on 2017/3/11.
//  Copyright © 2017年 XHY. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MDSInputView;

typedef NS_ENUM(NSInteger, MDSInputTextType) {
    MDSInputIDCardType, //默认从0开始
    MDSInputOtherType
};

@interface MDSInputView : UIView

-(instancetype)initWithInputType:(MDSInputTextType)type;

@property (nonatomic,assign)UITextField * textFiled;

@end


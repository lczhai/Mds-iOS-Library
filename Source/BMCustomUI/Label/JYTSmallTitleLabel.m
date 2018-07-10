//
//  JYTSmallTitleLabel.m
//  JingYitong
//
//  Created by XHY on 15/9/22.
//  Copyright © 2015年 京医通. All rights reserved.
//

#import "JYTSmallTitleLabel.h"
#import "MDSDefine.h"

@implementation JYTSmallTitleLabel

- (id)init
{
    if (self = [super init]) {
        
        [self changeFontSize];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeFontSize) name:K_CHANGE_FONT_SIZE_NOTIFICATION object:nil];
        
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self changeFontSize];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeFontSize) name:K_CHANGE_FONT_SIZE_NOTIFICATION object:nil];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        
        [self changeFontSize];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeFontSize) name:K_CHANGE_FONT_SIZE_NOTIFICATION object:nil];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self changeFontSize];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeFontSize) name:K_CHANGE_FONT_SIZE_NOTIFICATION object:nil];
}

- (void)changeFontSize
{
    NSString *fontSize = [[NSUserDefaults standardUserDefaults] objectForKey:K_FONT_SIZE_KEY];
    // 标准字体
    if (!fontSize || [fontSize isEqualToString:K_FONT_SIZE_NORM])
    {
        self.font = K_FONT_10;
    }
    else if ([fontSize isEqualToString:K_FONT_SIZE_BIG])
    {
        self.font = K_FONT_12;
    }
    else if ([fontSize isEqualToString:k_FONT_SIZE_EXTRALARGE])
    {
        self.font = K_FONT_14;
    }
}

- (void)dealloc
{
    // 销毁时移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self name:K_CHANGE_FONT_SIZE_NOTIFICATION object:nil];
}

@end

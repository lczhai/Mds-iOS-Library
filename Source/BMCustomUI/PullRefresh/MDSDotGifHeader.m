//
//  MDSDotGifHeader.m
//  Pods
//
//  Created by jony on 2018/5/9.
//
//

#import "MDSDotGifHeader.h"

@implementation MDSDotGifHeader

- (void)prepare
{
    [super prepare];
    
    
    NSMutableArray *idleImages = [NSMutableArray array];
    for (int i = 1; i<=24; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"loadding00%02d", i]];
        [idleImages addObject:image];
    }
    
    // 设置普通状态的动画图片
    [self setImages:idleImages forState:MJRefreshStateIdle];
    
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
//    [self setImages:idleImages forState:MJRefreshStatePulling];
    
    // 设置正在刷新状态的动画图片
    [self setImages:idleImages duration:0.8 forState:MJRefreshStateRefreshing];
}

@end

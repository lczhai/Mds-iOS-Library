//
//  WXRecyclerComponent+BMExtend.m
//  MDSBaseLibrary
//
//  Created by jony on 2018/9/22.
//

#import "WXRecyclerComponent+BMExtend.h"

@implementation WXRecyclerComponent (BMExtend)

- (UIView *)mdsRecycler_loadView
{
    UIView *view = [self mdsRecycler_loadView];
//    UICollectionView *collectionView = (UICollectionView *)view;
//    if (@available(iOS 11.0, *)) {
//        if (!isIphoneX) collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
//    }
    return view;
}

@end

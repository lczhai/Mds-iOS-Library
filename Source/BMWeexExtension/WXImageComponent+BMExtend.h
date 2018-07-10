//
//  WXImageComponent+BMExtend.h
//  MDS-Chia
//
//  Created by 窦静轩 on 2017/3/21.
//  Copyright © 2017年 XHY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WeexSDK/WXImageComponent.h>

@interface WXImageComponent (BMExtend)

- (void)updatePlaceHolderWithFailedBlock:(void(^)(NSString *, NSError *))downloadFailedBlock;
- (void)mds_updatePlaceHolderWithFailedBlock:(void(^)(NSString *, NSError *))downloadFailedBlock;

- (void)updateContentImageWithFailedBlock:(void(^)(NSString *, NSError *))downloadFailedBlock;
- (void)mds_updateContentImageWithFailedBlock:(void(^)(NSString *, NSError *))downloadFailedBlock;

@end

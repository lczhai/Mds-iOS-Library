//
//  WXSDKInstance+BMExtend.h
//  MDS-Chia
//
//  Created by jony on 2018/3/29.
//  Copyright © 2017年 XHY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WeexSDK/WeexSDK.h>

@interface WXSDKInstance (BMExtend)

-(void)mds_destroyInstance;


- (void)_renderWithMainBundleString:(NSString *)mainBundleString;
- (void)mds__renderWithMainBundleString:(NSString *)mainBundleString;


@end

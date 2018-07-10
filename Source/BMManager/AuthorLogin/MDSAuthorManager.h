//
//  MDSAuthorManager.h
//  Pods
//
//  Created by 窦静轩 on 2017/5/5.
//
//

#import <Foundation/Foundation.h>
#import "MDSModuleProtocol.h"
#import <WechatOpenSDK/WXApi.h>

@interface MDSAuthorManager : NSObject<WXApiDelegate>

+ (instancetype)shareInstance;

@property (nonatomic,copy)WXModuleCallback wechatLoginCallback;
@property (nonatomic,copy)WXModuleCallback failed;

/* 从其他app掉起次app时调用 */
- (BOOL)applicationOpenURL:(NSURL *)url;
@end

//
//  MDSDefine.h
//  WeexDemo
//
//  Created by jony on 2018/1/10.
//  Copyright © 2017年 taobao. All rights reserved.
//

#ifndef MDSDefine_h
#define MDSDefine_h

#import "MDSConfigManager.h"
#import "MDSMediatorManager.h"

/**----------------------------- 一些需要用到的页面path ------------------------------------*/

// js中介者页面
#define K_JS_MEDIATOR_PATH @"/pages/mediator/index.js"

// js 路径前面默认添加的路径
#define K_JS_ADD_PATH @"/dist/js"

/**--------------------------------- 本地资源目录 -------------------------------------------------**/
#define K_DOCUMENT_PATH [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]

#define K_LIBRARY_PATH [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0]

/* 本地的bundlejs目录 */
#define K_JS_BUNDLE_PATH [K_LIBRARY_PATH stringByAppendingPathComponent:@"Bundlejs"]

/* 缓存的js压缩包目录 */
#define K_JS_CACHE_PATH [K_JS_BUNDLE_PATH stringByAppendingPathComponent:@"cache"]

/* 当前本地缓存目录中js的版本 */
#define K_JS_CACHE_VERSION_PATH [K_JS_CACHE_PATH stringByAppendingPathComponent:@"bundle.config"]

/* 存放解压后的js文件pages目录 */
#define K_JS_PAGES_PATH [K_JS_BUNDLE_PATH stringByAppendingPathComponent:@"bundle"]

/* 存放当前js版本号的路径 */
#define K_JS_VERSION_PATH [K_JS_BUNDLE_PATH stringByAppendingPathComponent:@"bundle.config"]


/**----------------------------- 字体大小key ------------------------------------*/
#define K_CHANGE_FONT_SIZE_NOTIFICATION     @"change_font_size"
#define K_FONT_SIZE_KEY                     @"font_size"
#define K_FONT_SIZE_NORM                    @"NORM"
#define K_FONT_SIZE_BIG                     @"BIG"
#define k_FONT_SIZE_EXTRALARGE              @"EXTRALARGE"
// 字体方法倍数
#define K_FontSizeBig_Scale 1.15
#define K_FontSizeExtralarge_Scale 1.3

/**----------------------------- MDSNotification ------------------------------------*/
#define K_MDSAppReStartNotification          @"MDSAppReStartNotification"

/**----------------------------- key ------------------------------------*/
#define K_HomePagePath @"HomePagePathKey"
#define MDS_LOCAL @"bmlocal"

/** 获取配置信息 */
CG_INLINE MDSPlatformModel* TK_PlatformInfo() {
    return [MDSConfigManager shareInstance].platform;
}

/** 返回当前栈顶vc */
CG_INLINE UIViewController* TK_CurrentVC() {
    return [MDSMediatorManager shareInstance].currentViewController;
}

#define MDS_Weex_Interceptor @"MDS_Weex_Interceptor"
/** 获取当前拦截器开关状态 */
CG_INLINE BOOL MDS_InterceptorOn() {
#ifdef DEBUG
    id value = [[NSUserDefaults standardUserDefaults] objectForKey:MDS_Weex_Interceptor];
    if (nil == value) {
        value = [NSNumber numberWithBool:YES];
        [[NSUserDefaults standardUserDefaults] setObject:value forKey:MDS_Weex_Interceptor];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    return [value boolValue];
#else
    return YES;
#endif
}

#endif /* MDSDefine_h */

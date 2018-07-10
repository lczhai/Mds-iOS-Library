//
//  MDSRouterManager.m
//  Pods
//
//  Created by 窦静轩 on 2017/4/26.
//
//

#import "MDSRouterManager.h"
#import "NSString+Util.h"
#import "NSObject+YYModel.h"
#import "MDSRouterModel.h"
#import "MDSMediatorManager.h"
#import "MDSBaseViewController.h"
#import "MDSAppResource.h"
#import "MDSDefine.h"
#import <MDSConfigManager.h>


static NSString * schemeKey = @"weexeros";

static NSString * openPageKey = @"openpage";

static NSString * openTabKey = @"opentab";

static NSString * oauthKey = @"oauth";

@implementation MDSRouterManager

+(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    NSString * scheme = url.scheme;
    NSString * host = url.host;
    
    if ([scheme isEqualToString:schemeKey]) {
        /* openPage */
        if ([[host lowercaseString] isEqualToString:openPageKey]) {
            return [[self class] openPage:url];
        }
        
        /* openTab */
        else if ([[host lowercaseString] isEqualToString:openTabKey]) {
            return [[self class] openTab:url];
        }
        
    }
    
    return NO;
}

#pragma mark openPage
+(BOOL)openPage:(NSURL*)url
{
    NSString * query = url.query;
    NSString * decodeQuery = [query decodeString];
    NSLog(@"decodeQuery is %@",decodeQuery);
    
    NSDictionary * decodeInfo = [decodeQuery dictionaryFromQuery];
    NSDictionary * info = decodeInfo[@"data"];
    
    
    MDSRouterModel *routerModel = [MDSRouterModel yy_modelWithJSON:info];
    
    if ([routerModel isKindOfClass:[MDSRouterModel class]]) {
        
        MDSMediatorManager * mediatorManager =  [MDSMediatorManager shareInstance];
    
        
        //如果最顶端应该是MDSBaseViewController
        if ([mediatorManager.currentViewController isKindOfClass:[MDSBaseViewController class]]) {
            
            //完整的URL
            NSURL * toUrl = [MDSAppResource configJSFullURLWithPath:routerModel.url];
            
            //如果两者相等,则刷新当前页
            if ([[toUrl absoluteString] isEqualToString:[[(MDSBaseViewController*)mediatorManager.currentViewController url] absoluteString]]) {
                [(MDSBaseViewController*)mediatorManager.currentViewController refreshWeex];
            }
            else{
                /* 通过中介者跳转页面 */
                
                [mediatorManager openViewControllerWithRouterModel:routerModel weexInstance:mediatorManager.currentWXInstance];
            }
        }
    }
    return YES;
}
+(BOOL)openTab:(NSURL*)url
{
    NSString * query = url.query;
    NSString * decodeQuery = [query decodeString];
    NSLog(@"decodeQuery is %@",decodeQuery);
    
    NSDictionary * decodeInfo = [decodeQuery dictionaryFromQuery];

    
    NSNumber *  index = decodeInfo[@"index"];
    
    if (index) {
         MDSMediatorManager * mediatorManager =  [MDSMediatorManager shareInstance];
        [mediatorManager backToHomeIndex:[index intValue]];
    }

    return YES;
}


@end

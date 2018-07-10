//
//  WXSDKEngine+BMExtend.m
//  Pods
//
//  Created by 窦静轩 on 2017/5/5.
//
//

#import "WXSDKEngine+BMExtend.h"
#import "WXResourceRequestHandlerDefaultImpl.h"

@implementation WXSDKEngine(BMExtend)

+(void)mds_registerDefaultHandlers
{
    [self mds_registerDefaultHandlers];
    
    if (nil == [WXSDKEngine handlerForProtocol:@protocol(WXResourceRequestHandler)]) {
        [WXSDKEngine registerHandler:[WXResourceRequestHandlerDefaultImpl new] withProtocol:@protocol(WXResourceRequestHandler)];
    }


}

+(void)mds_registerDefaultModules
{
    [self mds_registerDefaultModules];
    
    [self registerModule:@"picker" withClass:NSClassFromString(@"MDSPickerModule")];

}
@end

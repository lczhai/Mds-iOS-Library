//
//  MDSHotRefreshWebScoket.m
//  MDSBaseLibrary
//
//  Created by XHY on 2018/3/15.
//

#ifdef DEBUG
#import "MDSHotRefreshWebScoket.h"
#import "MDSWebSocketLoader.h"
#import "MDSDebugManager.h"
#import "SVProgressHUD.h"

#define MDS_HOT_REFRESH @"SERVER/JS_BUNDLE_CHANGED"

@implementation MDSHotRefreshWebScoket
{
    MDSWebSocketLoader *loader;
}

- (void)connect
{
    [self webSocket:TK_PlatformInfo().url.socketServer protocol:nil];
}

- (void)close
{
    if (loader) {
        [loader close];
    }
}

- (void)reConnect
{
    if (![[NSUserDefaults standardUserDefaults] boolForKey:MDS_HotRefreshKey]) {
        return;
    }
    
    static int delay = 2;
    delay += 2;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self connect];
    });
}

- (void)webSocket:(NSString *)url protocol:(NSString *)protocol
{
    if(loader)
    {
        [loader clear];
    }
    loader = [[MDSWebSocketLoader alloc] initWithUrl:url protocol:protocol];
    __weak typeof(self) weakSelf = self;
    loader.onReceiveMessage = ^(id message) {
        WXLogInfo(@"%@",message);
        if ([message isEqualToString:MDS_HOT_REFRESH]) {
            [[MDSDebugManager shareInstance] refreshWeex];
        }
    };
    loader.onOpen = ^() {
        WXLogInfo(@"MDSHotRefresh Websocket connected");
        [SVProgressHUD showImage:nil status:@"hot refresh connected."];
    };
    loader.onFail = ^(NSError *error) {
        WXLogError(@"MDSHotRefresh Websocket Failed With Error %@", error);
        if (weakSelf) {
            [weakSelf reConnect];
        }
    };
    loader.onClose = ^(NSInteger code,NSString *reason,BOOL wasClean) {
        WXLogInfo(@"MDSHotRefresh Websocket colse: %@", reason);
        if (weakSelf) {
            [weakSelf reConnect];
        }
    };
    
    [loader open];
}

@end

#endif

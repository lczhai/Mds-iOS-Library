//
//  WXWebComponent+BMExtend.m
//  Pods
//
//  Created by jony on 2018/5/5.
//
//

#import "WXWebComponent+BMExtend.h"
#import <WeexSDK/WXUtility.h>
#import "MDSNative.h"
#import <JavaScriptCore/JavaScriptCore.h>

@class WXWebView;

@implementation WXWebComponent (BMExtend)

- (void)mds_webViewDidFinishLoad:(UIWebView *)webView
{
    [self mds_webViewDidFinishLoad:webView];
    
    CGFloat contentHeight = webView.scrollView.contentSize.height;
    
    CGFloat pixelScale = [WXUtility defaultPixelScaleFactor];
    
    contentHeight = contentHeight/(pixelScale*2);
    
    [self fireEvent:@"mdsPageFinish" params:@{@"contentHeight": @(contentHeight)}];
}
- (void)mds_viewDidLoad
{
    [self mds_viewDidLoad];
    UIWebView * webview = (UIWebView *)self.view;
    webview.opaque = NO;
    webview.backgroundColor = [UIColor clearColor];
    
    JSContext *jsContext = [self valueForKey:@"jsContext"];
    MDSNative *mdsNative = [[MDSNative alloc] init];
    jsContext[@"MDSNative"] = mdsNative;
    
    if (self.attributes[@"scrollEnabled"] && NO == [self.attributes[@"scrollEnabled"] boolValue]) {
        webview.scrollView.scrollEnabled = NO;
    }

}

/** 修复如果url为 NSNull、或者nil的时候 崩溃的问题 weex没有做判断 */
- (void)mds_setUrl:(NSString *)url;
{
    if (![url isKindOfClass:[NSString class]]) {
        return;
    }
    
    [self mds_setUrl:url];
}

/**
 这里主要判断是否是本地html，如果是本地html，则加载本地html
 */
-(void)mds_loadURL:(NSString *)url
{
    WXPerformBlockOnMainThread(^{
        UIWebView * webview = (UIWebView *)self.view;
        
        if(webview){
            NSURL *urlPath = [NSURL URLWithString:url];
            if([urlPath.scheme isEqualToString:MDS_LOCAL]){
                if (MDS_InterceptorOn()) {
                    NSString *webPath = [NSString stringWithFormat:@"%@/%@%@",K_JS_PAGES_PATH,urlPath.host,urlPath.path];
                    NSURLRequest *request = [NSURLRequest requestWithURL:[[NSURL alloc]initFileURLWithPath:webPath]];
                    [webview loadRequest:request];
                }else {
                    NSString *debugUrl = [NSString stringWithFormat:@"%@/dist/%@%@",TK_PlatformInfo().url.jsServer,urlPath.host,urlPath.path];
                    [self mds_loadURL:debugUrl];
                }
            }else {
                [self mds_loadURL:url];
            }
        }
    });
}

@end

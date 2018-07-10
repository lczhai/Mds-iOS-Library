//
//  WXWebComponent+BMExtend.h
//  Pods
//
//  Created by jony on 2018/5/5.
//
//

#import <WeexSDK/WeexSDK.h>
#import <WXWebComponent.h>

@interface WXWebComponent (BMExtend)

- (void)mds_webViewDidFinishLoad:(UIWebView *)webView;

- (void)mds_viewDidLoad;

- (void)setUrl:(NSString *)url;
- (void)mds_setUrl:(NSString *)url;

@end

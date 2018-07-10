//
//  UIWebView+BMExtend.m
//  Pods
//
//  Created by jony on 2018/6/30.
//
//

#import "UIWebView+MDSExtend.h"

@implementation UIWebView (MDSExtend)

- (void)checkCurrentFontSize
{
    NSNumber *level = [[NSUserDefaults standardUserDefaults] objectForKey:K_WebView_FontSize];
    if (!level) {
        return;
    }
    
    NSUInteger currentLevel = [level unsignedIntegerValue];
    
    NSInteger fontSize = 100 + currentLevel * 5 - 5;
    NSString *jsStr = [NSString stringWithFormat:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '%ld%%'",(long)fontSize];
    [self stringByEvaluatingJavaScriptFromString:jsStr];
}

@end

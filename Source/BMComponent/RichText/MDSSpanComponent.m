//
//  MDSSpanComponent.m
//  Pods
//
//  Created by jony on 2018/6/14.
//
//

#import "MDSSpanComponent.h"
#import <WeexSDK/WXComponent_internal.h>
#import "MDSRichTextComponent.h"

@interface MDSSpanComponent ()

@end

@implementation MDSSpanComponent

- (id)initWithRef:(NSString *)ref type:(NSString *)type styles:(NSDictionary *)styles attributes:(NSDictionary *)attributes events:(NSArray *)events weexInstance:(WXSDKInstance *)weexInstance
{
    if (self = [super initWithRef:ref type:type styles:styles attributes:attributes events:events weexInstance:weexInstance]) {
        
        if ([events containsObject:@"click"]) {
            _clickEvent = YES;
        }
        
        [self fillCssStyles:styles];
        [self fillAttributes:attributes];
        
    }
    
    return self;
}

- (UIView *)loadView
{
    [self updateRichText:self.supercomponent];
    UIView *view = [UIView new];
    view.userInteractionEnabled = NO;
    return view;
}

#pragma mark - Add Event
- (void)addEvent:(NSString *)eventName
{
    if ([eventName isEqualToString:@"click"]) {
        _clickEvent = YES;
    }
}

- (void)fillCssStyles:(NSDictionary *)styles
{
    if (styles[@"color"]) {
        self.textColor = [WXConvert UIColor:styles[@"color"]];
    }
    
    if (styles[@"fontSize"]) {
        self.fontSize = [WXConvert CGFloat:styles[@"fontSize"]];
    }
    
    if (styles[@"fontFamily"]) {
        _fontFamily = [WXConvert NSString:styles[@"fontFamily"]];
    }
    
    if (styles[@"fontWeight"]) {
        _fontWeight = [WXConvert WXTextWeight:styles[@"fontWeight"]];
    }
    
    if (styles[@"fontStyle"]) {
        _fontStyle = [WXConvert WXTextStyle:styles[@"fontStyle"]];
    }
    
    if (styles[@"textDecoration"]) {
        _textDecoration = [WXConvert WXTextDecoration:styles[@"textDecoration"]];
    }
}

- (void)fillAttributes:(NSDictionary *)attributes
{
    id text = attributes[@"value"];
    if (text) {
        _text = [WXConvert NSString:text];
        [self updateRichText:self.supercomponent];
    }
    
}

- (void)updateAttributes:(NSDictionary *)attributes
{
    [self fillAttributes:attributes];
}

- (void)_updateAttributesOnComponentThread:(NSDictionary *)attributes
{
    [super _updateAttributesOnComponentThread:attributes];
    
    [self fillAttributes:attributes];
}

- (void)updateRichText:(WXComponent *)component
{
    if (!component) {
        return;
    }
    
    if ([component isKindOfClass:[MDSRichTextComponent class]]) {
        [(MDSRichTextComponent *)component updateRichText];
        return;
    }
    
    /** 递归查询 MDSRichTextComponent */
    [self updateRichText:component.supercomponent];
}

@end

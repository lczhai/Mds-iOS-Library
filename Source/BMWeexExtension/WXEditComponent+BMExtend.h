//
//  WXEditComponent+BMExtend.h
//  Pods
//
//  Created by jony on 2018/4/24.
//
//

#import <WeexSDK/WeexSDK.h>
#import <WXEditComponent.h>

@interface WXEditComponent (BMExtend)

- (instancetype)mdsEdit_initWithRef:(NSString *)ref type:(NSString *)type styles:(NSDictionary *)styles attributes:(NSDictionary *)attributes events:(NSArray *)events weexInstance:(WXSDKInstance *)weexInstance;

- (void)mdsEdit_viewDidLoad;

- (void)setAutofocus:(BOOL)b;
- (void)mdsEdit_setAutofocus:(BOOL)b;

- (BOOL)mdsEdit_textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text;

- (void)setType;
-(void)mdsSetType;

- (void)setViewMovedUp:(BOOL)movedUp;
- (void)keyboardWasShown:(NSNotification*)notification;
- (void)mdsEdit_keyboardWasShown:(NSNotification*)notification;

@end

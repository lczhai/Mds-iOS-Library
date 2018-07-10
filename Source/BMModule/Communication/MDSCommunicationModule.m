//
//  MDSCommunicationModule.m
//  MDSBaseLibrary
//
//  Created by jony on 2018/12/27.
//

#import "MDSCommunicationModule.h"
#import <HYAlertView.h>
#import <MessageUI/MessageUI.h>
#import <AddressBookUI/AddressBookUI.h>
#import <MDSMediatorManager.h>
#import <Messages/MSMessagesAppViewController.h>

@interface MDSCommunicationModule () <MFMessageComposeViewControllerDelegate,ABPeoplePickerNavigationControllerDelegate>

@property (nonatomic, copy) WXModuleCallback smsCallback; /**< 发送短信的回调 */
@property (nonatomic, copy) WXModuleCallback contactsCallback; /**< 选择联系人的回调 */

@end

@implementation MDSCommunicationModule
@synthesize weexInstance;

WX_EXPORT_METHOD(@selector(call:))
WX_EXPORT_METHOD(@selector(sms:::))
WX_EXPORT_METHOD(@selector(contacts:))

/** 打电话 */
- (void)call:(NSDictionary *)info
{
    NSString *phone = info[@"to"];
    if (!phone) {
        WXLogError(@"电话号码错误");
        return;
    }
    
    /* ios10 以后会弹系统弹窗 */
    if (K_SYSTEM_VERSION > 10.2) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",phone]]];
    } else {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:phone preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
        UIAlertAction *callPhone = [UIAlertAction actionWithTitle:@"拨打" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",phone]]];
        }];
        [alert addAction:cancel];
        [alert addAction:callPhone];
        [[MDSMediatorManager shareInstance].currentViewController presentViewController:alert animated:YES completion:nil];
    }
}

/** 发短信 */
- (void)sms:(NSArray *)recipients :(NSString *)content :(WXModuleCallback)callback
{
    self.smsCallback = callback;
    //判断是否有短信功能
    if ([MFMessageComposeViewController canSendText]) {
        MFMessageComposeViewController *messageController = [[MFMessageComposeViewController alloc] init];
        messageController.messageComposeDelegate = self;
        //短信内容
        messageController.body = content;
        //收件人
        messageController.recipients = recipients;
        [[MDSMediatorManager shareInstance].currentViewController presentViewController:messageController animated:YES completion:nil];
    }else{
        if (callback) {
            NSDictionary *resData = [NSDictionary configCallbackDataWithResCode:MDSResCodeError msg:@"The current device does not support SMS" data:nil];
            callback(resData);
        }
    }
}

/** 打开通讯录 */
- (void)contacts:(WXModuleCallback)callback
{
    self.contactsCallback = callback;
    
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
    ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
        if (granted) {
            NSLog(@"Authorized");
            CFRelease(addressBook);
            
            ABPeoplePickerNavigationController *abVc = [[ABPeoplePickerNavigationController alloc] init];
            abVc.peoplePickerDelegate = self;
            abVc.predicateForSelectionOfPerson = [NSPredicate predicateWithValue:false];
            [[MDSMediatorManager shareInstance].currentViewController presentViewController:abVc animated:YES completion:nil];
            
        }else{
            if (callback) {
                NSDictionary *resData = [NSDictionary configCallbackDataWithResCode:MDSResCodeError msg:@"Denied or Restricted" data:nil];
                callback(resData);
            }
        }
    });
}

#pragma mark - MFMessageComposeViewControllerDelegate
-(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    NSString *tipContent;
    NSInteger status = 0;
    switch (result) {
        case MessageComposeResultCancelled:
        {
            tipContent = @"Cancelled";
            status = MDSResCodeOther;
            break;
        }
        case MessageComposeResultFailed:
        {
            tipContent = @"Failed";
            status = MDSResCodeError;
            break;
        }
        case MessageComposeResultSent:
        {
            tipContent = @"Sent";
            status = MDSResCodeSuccess;
            break;
        }
        default:
            break;
    }
    if (self.smsCallback) {
        NSDictionary *resData = [NSDictionary configCallbackDataWithResCode:status msg:tipContent data:nil];
        self.smsCallback(resData);
    }
    [controller dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark ABPeoplePickerNavigationControllerDelegate
- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController*)peoplePicker didSelectPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier{
    //    kABPersonJobTitleProperty;           // Job Title - kABStringPropertyType
    //    AB_EXTERN const ABPropertyID kABPersonDepartmentProperty
    NSString *firstName = (__bridge NSString *)ABRecordCopyValue(person, kABPersonFirstNameProperty);
    NSString *lastName = (__bridge NSString *)ABRecordCopyValue(person, kABPersonLastNameProperty);
    NSString *company = (__bridge NSString *)(ABRecordCopyValue(person, kABPersonOrganizationProperty));
    NSString *phone = (__bridge NSString *)(ABRecordCopyValue(person, kABPersonPhoneProperty));
    long index = ABMultiValueGetIndexForIdentifier((__bridge ABMultiValueRef)(phone), identifier);
    NSString *phoneNumber = (__bridge NSString *)ABMultiValueCopyValueAtIndex((__bridge ABMultiValueRef)(phone), index);
    phoneNumber = [phoneNumber stringByReplacingOccurrencesOfString:@"-" withString:@""];
    phoneNumber = [phoneNumber stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *name = [NSString stringWithFormat:@"%@%@",lastName?:@"",firstName?:@""];

    if (self.contactsCallback) {
        NSDictionary *resData = [NSDictionary configCallbackDataWithResCode:MDSResCodeSuccess msg:nil data:@{
                                                                                                            @"name":name?:@"",
                                                                                                            @"phone":phoneNumber?:@""
                                                                                                            }];
        self.contactsCallback(resData);
    }
    
    [peoplePicker dismissViewControllerAnimated:YES completion:nil];
}

- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker
{
    
    if (self.contactsCallback) {
        NSDictionary *resData = [NSDictionary configCallbackDataWithResCode:MDSResCodeOther msg:@"cancel" data:nil];
        self.contactsCallback(resData);
    }
    
    [peoplePicker dismissViewControllerAnimated:YES completion:nil];
}

@end

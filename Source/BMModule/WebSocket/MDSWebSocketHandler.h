//
//  MDSWebSocketHandler.h
//  MDSBaseLibrary
//
//  Created by jony on 2018/10/23.
//

#ifndef MDSWebSocketHandler_h
#define MDSWebSocketHandler_h
#import "WXModuleProtocol.h"

@protocol MDSWebSocketDelegate<NSObject>
- (void)didOpen;
- (void)didFailWithError:(NSError *)error;
- (void)didReceiveMessage:(id)message;
- (void)didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean;
@end

@protocol MDSWebSocketHandler<NSObject>

- (void)open:(NSString *)url protocol:(NSString *)protocol withDelegate:(id<MDSWebSocketDelegate>)delegate;
- (void)sendData:(NSString *)data;
- (void)close;
- (void)closeWithCode:(NSInteger)code reason:(NSString *)reason;
- (void)clear;
@end

#endif /* MDSWebSocketHandler_h */

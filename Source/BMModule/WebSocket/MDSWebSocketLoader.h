//
//  MDSWebSocketLoader.h
//  MDSBaseLibrary
//
//  Created by jony on 2018/10/23.
//

#import <Foundation/Foundation.h>

@interface MDSWebSocketLoader : NSObject <NSCopying>

@property (nonatomic, copy) void (^onOpen)();
@property (nonatomic, copy) void (^onReceiveMessage)(id);
@property (nonatomic, copy) void (^onClose)(NSInteger,NSString *,BOOL);
@property (nonatomic, copy) void (^onFail)(NSError *);

- (instancetype)initWithUrl:(NSString *)url protocol:(NSString *)protocol;
- (void)open;
- (void)send:(NSString *)data;
- (void)close;
- (void)close:(NSInteger)code reason:(NSString *)reason;
- (void)clear;

@end

//
//  MDSHandlerFactory.m
//  MDSBaseLibrary
//
//  Created by XHY on 2018/6/28.
//

#import "MDSHandlerFactory.h"

@interface MDSHandlerFactory ()

@property (nonatomic, strong)  NSMutableDictionary *handlerMap;
@property (nonatomic, strong)  NSLock *handlerLock;

@end

@implementation MDSHandlerFactory

#pragma mark - Private Func
+ (instancetype)shareInstance
{
    static MDSHandlerFactory *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[MDSHandlerFactory alloc] init];
    });
    
    return _instance;
}

- (instancetype)init
{
    @synchronized(self) {
        self = [super init];
        if (self) {
            _handlerMap = [NSMutableDictionary dictionary];
            _handlerLock = [[NSLock alloc] init];
        }
    }
    return self;
}

- (void)_registerHandler:(id)handler withProtocol:(Protocol *)protocol
{
    [self.handlerLock lock];
    [self.handlerMap setValue:handler forKey:NSStringFromProtocol(protocol)];
    [self.handlerLock unlock];
}


#pragma mark - Public Func
+ (void)registerHandler:(id)handler withProtocol:(Protocol *)protocol
{
    [[MDSHandlerFactory shareInstance] _registerHandler:handler withProtocol:protocol];
}

+ (id)handlerForProtocol:(Protocol *)protocol
{
    if (!protocol) {
        WXLogError(@"Can not find handler for a nil protocol");
        return nil;
    }
    
    return [[MDSHandlerFactory shareInstance].handlerMap objectForKey:NSStringFromProtocol(protocol)];
}

+ (NSDictionary *)handlerConfigs
{
    return [MDSHandlerFactory shareInstance].handlerMap;
}

@end

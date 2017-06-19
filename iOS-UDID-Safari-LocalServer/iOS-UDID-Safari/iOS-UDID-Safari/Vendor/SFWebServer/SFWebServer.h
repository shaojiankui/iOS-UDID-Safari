//
//  SFWebServer.h
//  SFWebServer
//
//  Created by www.skyfox.org on 2017/6/19.
//  Copyright © 2017年 Jakey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SFWebServerRouter.h"
#import "SFWebServerRequest.h"
#import "SFWebServerRespone.h"
#import "GCDAsyncSocket.h"
@interface SFWebServer : NSObject
@property(nonatomic, readonly) NSUInteger port;
@property(nonatomic, readonly) NSString *host;
@property(nonatomic, readonly) NSString *address;


- (instancetype)init __attribute__((unavailable("Forbidden use init!")));
+ (SFWebServer*)shared;


+ (instancetype)startWithPort:(NSInteger)port;

- (void)router:(NSString*)method basePath:(NSString*)basePath handler:(SFWebServerRouterHandler)handler;

- (void)router:(NSString*)method path:(NSString*)path handler:(SFWebServerRouterHandler)handler;

- (void)router:(NSString*)method filename:(NSString*)filename handler:(SFWebServerRouterHandler)handler;

- (void)router:(NSString*)method extension:(NSString*)extension handler:(SFWebServerRouterHandler)handler;
@end

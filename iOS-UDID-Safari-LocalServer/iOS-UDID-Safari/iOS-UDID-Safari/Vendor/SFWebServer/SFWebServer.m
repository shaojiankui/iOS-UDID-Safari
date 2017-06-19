//
//  SFWebServer.m
//  SFWebServer
//
//  Created by www.skyfox.org on 2017/6/19.
//  Copyright © 2017年 Jakey. All rights reserved.
//

#import "SFWebServer.h"
#import <UIKit/UIKit.h>
@interface SFWebServer()<GCDAsyncSocketDelegate>
{
    GCDAsyncSocket *_server;
    NSMutableArray *_routers;
}
@end
@implementation SFWebServer
+ (SFWebServer*)shared
{
    static SFWebServer *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[self alloc] init];
    });
    return shared;
}
- (NSDictionary*)getTableData{
    return nil;
}
+ (instancetype)startWithPort:(NSInteger)port{
    SFWebServer *server = [[SFWebServer shared] initWithPort:port];
    [server startServer];
    return server;
}

- (BOOL)startServer{
    _server =  [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    NSError *error = nil;
    if ([_server acceptOnPort:self.port error:&error]) {
        NSLog(@"server start on %@:%zd",_server.localHost,_server.localPort);
        _host = _server.localHost;
        return YES;
    }else{
        NSLog(@"error %@",error);
        return NO;
    }
    return NO;
}

- (instancetype)initWithPort:(NSInteger)port{
    self = [super init];
    if (self) {
        _port = port;
    }
    return self;
}
-(NSString *)address{
    return [NSString stringWithFormat:@"http://%@:%zd",[SFWebServer shared].host,[SFWebServer shared].port];
}

- (void)router:(NSString*)method basePath:(NSString*)basePath handler:(SFWebServerRouterHandler)handler{
    [self _router:method path:basePath type:@"basepath" handler:handler];
}
- (void)router:(NSString*)method path:(NSString*)path handler:(SFWebServerRouterHandler)handler{
    [self _router:method path:path type:@"url" handler:handler];
}
- (void)router:(NSString*)method filename:(NSString*)filename handler:(SFWebServerRouterHandler)handler{
    NSString *path = [[NSBundle mainBundle]pathForResource:filename ofType:[filename pathExtension]];
    [self _router:method path:path type:@"url" handler:handler];
}
- (void)router:(NSString*)method extension:(NSString*)extension handler:(SFWebServerRouterHandler)handler{
    [self _router:method path:extension type:@"extension" handler:handler];
}

- (void)_router:(NSString*)method path:(NSString*)path type:(NSString*)type handler:(SFWebServerRouterHandler)handler{
    SFWebServerRouter *router = [[SFWebServerRouter alloc]init];
    router.method = method;
    router.path = path?:@"/";
    router.handler = handler;
    router.type = type?:@"url";
    if (!_routers) {
        _routers = [NSMutableArray array];
    }
    [_routers addObject:router];
}

-(void)socket:(GCDAsyncSocket *)sock didAcceptNewSocket:(GCDAsyncSocket *)newSocket{
    NSLog(@"didAcceptNewSocket");
    NSLog(@"newSocket %@ %@ %zd",newSocket.userData,newSocket.localHost,newSocket.localPort);
    
    
    //    NSMutableString *serverStr = [NSMutableString string];
    //    [serverStr appendString:@"connect\n"];
    //    [newSocket writeData:[serverStr dataUsingEncoding:NSUTF8StringEncoding] withTimeout:-1 tag:0];
    [newSocket readDataWithTimeout:-1 tag:0];
}
- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag{
    NSLog(@"didReadData");
    NSLog(@"sock %@ %@ %zd",sock.userData,sock.localHost,sock.localPort);
    
    SFWebServerRequest *request = [[SFWebServerRequest alloc]initWithData:data];
    
    BOOL found = NO;
    for (SFWebServerRouter *router in _routers)
    {
        if ([router.method isEqualToString:request.method] && router.handler)
        {
            if ([router.type isEqualToString:@"url"])
            {
                if ([router.path isEqualToString:request.path]) {
                    SFWebServerRespone *respone = router.handler(request);
                    [sock writeData:respone.data withTimeout:-1 tag:0];
                    found = YES;
                }
            }
            else if ([router.type isEqualToString:@"extension"]) {
                if ([request.path hasSuffix:router.path]) {
                    SFWebServerRespone *respone = router.handler(request);
                    [sock writeData:respone.data withTimeout:-1 tag:0];
                    found = YES;
                }
            }
            else if ([router.type isEqualToString:@"basepath"]) {
                if ([request.path hasPrefix:router.path]) {
                    SFWebServerRespone *respone = router.handler(request);
                    [sock writeData:respone.data withTimeout:-1 tag:0];
                    found = YES;
                }
            }
        }
    }
    if (!found) {
        NSLog(@"request.path %@ 404",request.path);
        SFWebServerRespone *respone = [[SFWebServerRespone alloc]initWithHTML:@"401"];
        respone.statusCode = 404;
        [sock writeData:respone.data withTimeout:-1 tag:0];
    }
}
- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err
{
    
}
@end

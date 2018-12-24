//
//  AppDelegate.m
//  iOS-UDID-Safari
//
//  Created by Jakey on 2017/6/17.
//  Copyright © 2017年 Jakey. All rights reserved.
//

#import "AppDelegate.h"
#import "SFWebServer.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    SFWebServer *server = [SFWebServer startWithPort:6699];
    [server router:@"GET" path:@"/udid.do" handler:^SFWebServerRespone *(SFWebServerRequest *request) {
        NSString *config = [[NSBundle mainBundle] pathForResource:@"udid" ofType:@"mobileconfig"];
        SFWebServerRespone *response = [[SFWebServerRespone alloc]initWithFile:config];
        response.contentType =  @"application/x-apple-aspen-config";
        return response;
    }];
    
    [server router:@"POST" path:@"/receive.do" handler:^SFWebServerRespone *(SFWebServerRequest *request) {

        NSString *raw = [[NSString  alloc]initWithData:request.rawData encoding:NSISOLatin1StringEncoding];
        NSString *plistString = [raw substringWithRange:NSMakeRange([raw rangeOfString:@"<?xml"].location, [raw rangeOfString:@"</plist>"].location + [raw rangeOfString:@"</plist>"].length)];
        
        NSDictionary *plist = [NSPropertyListSerialization propertyListWithData:[plistString dataUsingEncoding:NSISOLatin1StringEncoding] options:NSPropertyListImmutable format:nil error:nil];
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"获取设备信息成功" message:[plist description] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        
        NSLog(@"device info%@",plist);
        SFWebServerRespone *response = [[SFWebServerRespone alloc]initWithHTML:@"success"];
        //值得注意的是重定向一定要使用301重定向,有些重定向默认是302重定向,这样就会导致安装失败,设备安装会提示"无效的描述文件
        response.statusCode = 301;
        response.location = [NSString stringWithFormat:@"iOS-UDID-Safari-APP://?udid=%@",[plist objectForKey:@"UDID"]];
        return response;
    }];
    [server router:@"GET" path:@"/show.do" handler:^SFWebServerRespone *(SFWebServerRequest *request) {
       SFWebServerRespone *response = [[SFWebServerRespone alloc]initWithHTML:@"success"];
        return response;
    }];
    
    [application openURL:[NSURL URLWithString:@"http://127.0.0.1:6699/udid.do"]];
    
    return YES;
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    _bgTask = [application beginBackgroundTaskWithExpirationHandler:^{
        [application endBackgroundTask:_bgTask];
        _bgTask = UIBackgroundTaskInvalid;
    }];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    NSLog(@"打开app %@",url);
    return YES;

}
@end

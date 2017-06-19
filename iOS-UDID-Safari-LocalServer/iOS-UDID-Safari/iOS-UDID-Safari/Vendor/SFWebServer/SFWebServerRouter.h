//
//  SFWebServerRouter.h
//  SFWebServer
//
//  Created by www.skyfox.org on 2017/6/19.
//  Copyright © 2017年 Jakey. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SFWebServerRequest.h"
#import "SFWebServerRespone.h"


typedef SFWebServerRespone* (^SFWebServerRouterHandler)(SFWebServerRequest *request);

@interface SFWebServerRouter : NSObject
@property (nonatomic,copy) NSString *type;
@property (nonatomic,copy) NSString *method;
@property (nonatomic,copy) NSString *path;
@property (nonatomic,copy) SFWebServerRouterHandler handler;
@end

//
//  SFWebServerRequest.h
//  SFWebServer
//
//  Created by www.skyfox.org on 2017/6/19.
//  Copyright © 2017年 Jakey. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SFWebServerRequest : NSObject
@property (nonatomic,copy) NSMutableDictionary <NSString*,NSString*> *headers;
@property (nonatomic,copy) NSString *headerString;
@property (nonatomic,copy) NSString *method;
@property (nonatomic,copy) NSString *path;
@property (nonatomic,copy) NSString *body;
@property (nonatomic,strong) NSData *rawData;
@property (nonatomic,copy) NSString *HTTPVersion;
- (instancetype)initWithData:(NSData*)data;
@end

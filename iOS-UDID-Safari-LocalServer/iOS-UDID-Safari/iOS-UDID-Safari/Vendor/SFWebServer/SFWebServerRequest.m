//
//  SFWebServerRequest.m
//  SFWebServer
//
//  Created by www.skyfox.org on 2017/6/19.
//  Copyright © 2017年 Jakey. All rights reserved.
//

#import "SFWebServerRequest.h"

@implementation SFWebServerRequest
- (instancetype)initWithData:(NSData*)data{
    self = [super init];
    if (self) {
        NSString *string = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        if (!string) {
            string = [[NSString alloc]initWithData:data encoding:NSISOLatin1StringEncoding];

        }
        self.headerString = string;
        NSArray *headerArray = [string componentsSeparatedByString:@"\r\n"];
        NSString *info = [headerArray firstObject];
        
        _headers =  [NSMutableDictionary dictionary];
        if (info) {
            NSArray *infoArray = [info componentsSeparatedByString:@" "];
            if ([infoArray count] == 3)
            {
                _method      = infoArray[0];
                _path        = infoArray[1];
                _HTTPVersion = infoArray[2];
            }
            for (int i = 1; i<[headerArray count]; i++) {
                NSString *h = [headerArray objectAtIndex:i];
                NSString *key   = [[h componentsSeparatedByString:@": "] firstObject];
                NSString *value = [[h componentsSeparatedByString:@": "] lastObject];
                _headers[key] = value;
            }
        }
        if (!string) {
            _method      = @"GET";
            _path        = @"/";
            _HTTPVersion = @"HTTP/1.1";
        }
        self.rawData = data;
        NSLog(@"SFWebServerRequest path:%@",_path);
    }
    return self;
}

@end

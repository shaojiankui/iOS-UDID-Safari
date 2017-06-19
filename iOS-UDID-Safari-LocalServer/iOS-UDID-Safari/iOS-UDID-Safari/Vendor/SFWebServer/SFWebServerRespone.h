//
//  SFWebServerRespone.h
//  SFWebServer
//
//  Created by www.skyfox.org on 2017/6/19.
//  Copyright © 2017年 Jakey. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SFWebServerRespone : NSObject
@property (nonatomic,copy)   NSString *html;
@property (nonatomic,strong) NSData *htmlData;
@property (nonatomic,assign) NSInteger statusCode;
@property (nonatomic,strong) NSData *data;
@property (nonatomic,copy)   NSString *contentType;
@property (nonatomic,copy)   NSString *location;

@property (nonatomic,assign) NSUInteger contentLength;
@property (nonatomic,copy)   NSString *fileName;

- (instancetype)initWithHTML:(NSString*)html;
- (instancetype)initWithHTMLData:(NSData*)htmlData;
- (instancetype)initWithFile:(NSString*)filePath;
- (instancetype)initWithFileName:(NSString*)fileName;
@end

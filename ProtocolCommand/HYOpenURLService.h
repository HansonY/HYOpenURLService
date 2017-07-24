//
//  HYOpenURLService.h
//  HYOpenURLService
//
//  Created by HansonYang on 16/12/30.
//  Copyright © 2016年 HansonYang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

// 常用key
#define Hanson_WebViewControler   @"WebView"


@interface HYOpenURLService : NSObject

typedef id (^HYMappingHandler)(NSDictionary *routerParameters);

@property(retain,nonatomic)UINavigationController *nav;

+(instancetype)Shared;
#pragma mark  对象 事件 ;
 
-(id)openURL:(NSString*)command;

-(id)openURL:(NSString*)command  withParam:(NSDictionary*)param;

#pragma mark   方法  注册  相关  函数

// 动态添加 注册页面；
+(void)regViewCmdForKey:(NSString*)Key   withClassName:(NSString*)className;

// 注册方法，不带参
+(void)addBlockMappingKey:(NSString*)command
               completion:(id (^)(NSDictionary* param ) ) completion;
// 注册方法，带参
+(void)addBlockMappingKey:(NSString*)URL
                withParam:(NSDictionary*)param
               completion:(id (^)(NSDictionary* param ) ) completion;

// url
+(NSString*)cmd_URL_View:(NSString*)cmd;
// block
+(NSString*)cmd_URL_Block:(NSString*)cmd;

@end

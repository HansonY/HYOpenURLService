//
//  HYCommadMapping.h
//  TestRuntime
//
//  Created by HansonYang on 16/11/3.
//  Copyright © 2016年 HansonYang. All rights reserved.
//

#define CMD_View   @"local://view/"
#define CMD_Block   @"local://block/"

#define Hanson_Test_Action   @"TEST_HANSON_Action"
#define Hanson_Test_OpenView   @"TEST_HANSON_View"


#define Hanson_Test_webBlock   @"searchbarclick"

#define Hanson_Test_webChatView   @"dialog"

#define Hanson_Test_webMyWeb   @"Hanson_Test_webMyWeb"


#import <Foundation/Foundation.h>

@interface HYCommadMapping : NSObject

/**
 *  routerParameters 里内置的几个参数会用到上面定义的 string
 */
typedef id (^HYMappingHandler)(NSDictionary *routerParameters);

extern  const   NSString *HYVIEW;
extern  const   NSString *HYBLOCK;
extern  const   NSString *HYACTION;


@property(retain,nonatomic)NSMutableDictionary  *webcommadMappingViewCommandDic;

+(NSMutableDictionary*)addBlockMappingKey:(NSString*)command
                                       params:(NSDictionary*)params
                                       completion:(void (^)(NSDictionary* param))completion;
 
+(id)runBlockForMapping:(NSString*)key;
+(id)runBlockForMapping:(NSString*)key  withParam:(NSDictionary*)dicParam;

+(void)addBlockMappingKey:(NSString*)command
                               completion:(id (^)(NSDictionary* param ) ) completion;

+(void)addBlockMappingKey:(NSString*)URL
                withParam:(NSDictionary*)param
               completion:(id (^)(NSDictionary* param ) ) completion;

+(NSString*)getCommandKey:(NSString*)key;

// url 
+(NSString*)cmd_URL_View:(NSString*)cmd;

+(NSString*)cmd_URL_Block:(NSString*)cmd;

@end


//
//  HYCommadMapping.m
//  TestRuntime
//
//  Created by HansonYang on 16/11/3.
//  Copyright © 2016年 HansonYang. All rights reserved.
//
#import "HYCommadMapping.h"
#import "NSMutableDictionary+checkNil.h"

@implementation HYCommadMapping

const   NSString *HYVIEW = @"view";
const   NSString *HYBLOCK = @"block";
const   NSString *HYACTION = @"action";

static HYCommadMapping *singleViewCommandMapping;

//  handle' 事件 键值对  自定义；
static NSMutableDictionary  *blockMappingCommand;
//  view ' 事件 键值对；
static NSMutableDictionary  *viewMappingCommand;

static NSMutableDictionary  *webcommadMappingViewCommand;


+(NSString*)cmd_URL_View:(NSString*)cmd{
    return [NSString stringWithFormat:@"%@%@", CMD_View , cmd ];
}

+(NSString*)cmd_URL_Block:(NSString*)cmd{
    return [NSString stringWithFormat:@"%@%@", CMD_Block , cmd ];
}


//  初始 默认  类  映射
//params:(NSDictionary*)params
+(void)addBlockMappingKey:(NSString*)URL
                                       completion:(id (^)(NSDictionary* param ) ) completion
{
    if (!blockMappingCommand) {
        blockMappingCommand = [[NSMutableDictionary alloc]init];
    }
    
    HYMappingHandler handler = completion ;
    [blockMappingCommand setObjectCheckNil:handler forKey:URL];
    
}

+(void)addBlockMappingKey:(NSString*)URL
                withParam:(NSDictionary*)param
               completion:(id (^)(NSDictionary* param ) ) completion{

    if (!blockMappingCommand) {
        blockMappingCommand = [[NSMutableDictionary alloc]init];
    }
    
    HYMappingHandler handler = completion ;
    [blockMappingCommand setObjectCheckNil:handler forKey:URL];
    [blockMappingCommand setObjectCheckNil:param forKey:[ [ self class ] handlerParamKey:URL ] ];
    
}

+(NSString*)handlerParamKey:(NSString*)url{
    NSString *handlerParamKey = [NSString stringWithFormat:@"%@%@" , url,@"_BLock"];
    return handlerParamKey;
}


+(id)runBlockForMapping:(NSString*)key {
    
    return    [[self class] runBlockForMapping:key withParam:nil];

}

+(id)runBlockForMapping:(NSString*)key  withParam:(NSDictionary*)dicParam{
    
    HYMappingHandler handler;
    NSDictionary *handleParam = [[NSDictionary alloc]init];
    if (!blockMappingCommand) {
        return nil;
    }
    
    id  handleDefParam =     [blockMappingCommand objectForKey:[ [ self class ] handlerParamKey:key ] ];
    if ( [ handleDefParam isKindOfClass: [ NSDictionary class ] ] )  handleParam = handleDefParam;
    
    if (dicParam){
        handleParam = dicParam;
    }
    
    handler =  [blockMappingCommand objectForKey:key];
    if (!handler)  return nil;
    id  temp = handler(handleParam);
    NSLog(@"test is  %@" , temp);
    
    return   temp;
    
}



+(NSMutableDictionary*)loadViewMappingCommand{
    
    // 增加 对应 指令 页面；
    if (!viewMappingCommand) {
        viewMappingCommand = [[NSMutableDictionary alloc]init];
        
        [viewMappingCommand setObjectCheckNil:@"HYBaseWebController" forKey:Hanson_Test_OpenView];
        [viewMappingCommand setObjectCheckNil:@"HYTestViewController" forKey:Hanson_Test_webChatView];
        [viewMappingCommand setObjectCheckNil:@"HYMyWebViewController" forKey:Hanson_Test_webMyWeb];

    }
    
    return viewMappingCommand;

}


+(NSString*)getCommandKey:(NSString*)key{
    NSDictionary * mappingKey = [[self class] loadViewMappingCommand];
    return   [mappingKey objectForKey:key] ;

}


+(NSMutableDictionary*)getBlockMappingKey{
      return  blockMappingCommand;
    
}



@end

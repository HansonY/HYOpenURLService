//
//  HYOpenURLService.m
//  HYOpenURLService
//
//  Created by HansonYang on 16/12/30.
//  Copyright © 2016年 HansonYang. All rights reserved.
//
#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)

#define CMD_View   @"local://view/"
#define CMD_Block   @"local://block/"

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import "HYCmdModel.h"
#import "NSMutableDictionary+checkNil.h"
 

#import "HYOpenURLService.h"


@implementation HYOpenURLService

static  HYOpenURLService  *singleRunTime;

const   NSString *HYVIEW = @"view";
const   NSString *HYBLOCK = @"block";
#pragma mark  事件 功能 ;

#pragma mark    精简 动态 运行
//  创建  初始化 对象；
+(instancetype)Shared{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!singleRunTime) {
            singleRunTime = [[HYOpenURLService  alloc]init];
        }
  
    });
    
    return singleRunTime;
    
}

-(id)openURL:(NSString*)command{
    return   [self openURL:command withParam:nil];
}

-(id)openURL:(NSString*)command  withParam:(NSDictionary*)param{

    HYCmdModel *HYCmdModel = [self analysisCommand:command];
    if (param)  HYCmdModel.protocolParma = param;
    
    id  returnView;

    if ( [HYVIEW  isEqualToString: HYCmdModel.protocolHeader] ) {
        returnView = [self anyClassObject:HYCmdModel];
        [self.nav pushViewController:returnView animated:YES];
        return  returnView;
    }
    
    if ( [HYBLOCK  isEqualToString: HYCmdModel.protocolHeader] ) {
        [HYOpenURLService runBlockForMapping:HYCmdModel.protocolCommand
                                            withParam:HYCmdModel.protocolParma];
        return  returnView;
    }
    
    return  returnView;
    
}

#pragma mark  基础 功能；
// 解析
-(HYCmdModel*)analysisCommand:(NSString*)cmdURL{
    
    NSString *protocolHeader = @"";
    NSString *protocolCommand = @"" ;
    NSString *protocolParma = @"";

     HYCmdModel *cmdModel = [ [ HYCmdModel  alloc] init ];

    // http 处理；
    if ([cmdURL hasPrefix:@"http"]) {
            cmdModel.protocolHeader   =  (NSString*)HYVIEW;
            cmdModel.protocolCommand  =  @"WebView";
            cmdModel.protocolParma =  @{@"strURL":cmdURL}  ;
        
        return cmdModel;
    }
    
    NSString *check = @"^local://([\\w-]+/)+([\\w-?%&=.]*)?$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", check];
    
    if (([predicate evaluateWithObject:cmdURL] == NO)) {
        NSLog(@"  command  ,  校验不通过 ");
        return nil;
    }
    
    // 清除 协议端；
    if ([cmdURL hasPrefix:@"local://"]) {
        cmdURL = [cmdURL stringByReplacingOccurrencesOfString:@"local://" withString:@""];
    }
    
    //  头命令 ；  view/login?sfsf=231&232=3232
    NSArray *comandArray = [cmdURL componentsSeparatedByString:@"/"];
     //  头命令 ；

     // 初始化类；
    if (comandArray.count == 2 ) {
        protocolHeader = [comandArray objectAtIndex:0];
        protocolCommand = [comandArray objectAtIndex:1];
        
        NSArray *subCommandArray;
        if ([protocolCommand rangeOfString:@"?"].location != NSNotFound) {
            subCommandArray = [protocolCommand componentsSeparatedByString:@"?"];
            // 命令
            protocolCommand = [subCommandArray objectAtIndex:0];
            // 参数
            protocolParma = [subCommandArray objectAtIndex:1];
            cmdModel.protocolParma = [self getUrlDataInfo:protocolParma];
         }
        
        cmdModel.protocolHeader   =  protocolHeader;
        cmdModel.protocolCommand  =  protocolCommand;
        
    }
    
     // 初始化类 调用放发；
    NSLog(@"protocolHeader   %@" ,protocolHeader ) ;
    NSLog(@"protocolCommand  %@" ,protocolCommand ) ;
    NSLog(@"protocolParma    %@" ,protocolParma ) ;
    
    return cmdModel;
    
}

-(NSDictionary*)getUrlDataInfo:(NSString*)commandStr{
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
 
        NSArray *mapArray    = [commandStr componentsSeparatedByString:@"&"];
        for (NSString *temp  in mapArray) {
            NSArray *mapKv = [temp componentsSeparatedByString:@"="];
            NSString *content = [mapKv lastObject];
            // 解释  encode  值 ；
            //          content = [[self class] deCodeData:content];
            [dic setObject:content forKey:[mapKv firstObject]];
        }
        
    return [dic copy];
    
}


//  view 命令 事件；
-(id)anyClassObject:(HYCmdModel*)cmdModel {
     // 是否为 解析成功；
    NSDictionary *commandDic = cmdModel.protocolParma;
    
    NSString *selStr = cmdModel.protocolCommand;
    NSString *locationCommand  =  [HYOpenURLService getCommandKey:selStr];
    
    Class AnyClass = NSClassFromString(locationCommand);
    if(!AnyClass){
        NSLog(@" 该类 不存在 ");
        return         nil;
    }
    
    id  myVC = [[AnyClass alloc]init];
    
    if (!myVC)  return nil;
    
    SuppressPerformSelectorLeakWarning( [myVC performSelector:NSSelectorFromString(@"registeredURLBlock")] ) ;
     if ([commandDic allKeys].count >=1 ) {
                 // 给变量 赋值；
                 SuppressPerformSelectorLeakWarning( [myVC performSelector:NSSelectorFromString(@"setParameter:") withObject:commandDic] );
     }
    
    return myVC;
    
}

#pragma mark  注册 方法；


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
    if (!viewMappingCommand)  viewMappingCommand = [[NSMutableDictionary alloc]init];
    //  添加 默认 页面  ;
        [viewMappingCommand setObjectCheckNil:@"HYBaseWebController" forKey:Hanson_WebViewControler];
    return viewMappingCommand;
}

// 动态添加 注册页面；
+(void)regViewCmdForKey:(NSString*)Key   withClassName:(NSString*)className{
    if (!viewMappingCommand) viewMappingCommand = [[NSMutableDictionary alloc]init];
    [viewMappingCommand setObjectCheckNil:className forKey:Key];
    
}


+(NSString*)getCommandKey:(NSString*)key{
    NSDictionary * mappingKey = [[self class] loadViewMappingCommand];
    return   [mappingKey objectForKey:key] ;
    
}


+(NSMutableDictionary*)getBlockMappingKey{
    return  blockMappingCommand;
    
}

 @end

//
//  CRMHttpManager.m
//  crm_ios
//
//  Created by HansonYang on 16/2/22.
//  Copyright © 2016年 pingan. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@implementation CRMHttpManager : NSObject
/*
static NSString *URL_TEST_Heaher = @"https://test-umap-crm.pa18.com:56434/umap-crm-mobile/";
static NSString *URL_PRD_Heaher = @"https://umap-crm.pa18.com/umap-crm-mobile/";

static NSString *URL_Paphone_TEST_Heaher = @"https://test-eim-mcp.pingan.com.cn:8093/eim-mcp-portal/common/";
static NSString *URL_Paphone_PRD_Heaher  = @"https://eim-mcp.pingan.com.cn/eim-mcp-portal/common/";

static NSString *URL_AdvisoryQ_A_TEST_Heaher = @"http://test-pad-info.pa18.com:22080/pad-info/informationSDK.do";
static NSString *URL_AdvisoryQ_A_PRD_Heaher  = @"http://pad-info.pa18.com/pad-info/informationSDK.do";


static NSString *URL_Paphone_Header = @"";
static NSString *URL_Header = @"";
static NSString *URL_AdvisoryQ_A = @"";



+ (NSString *)strURLWithType:(FIHttpRequestType)type
{
    
    NSString *urlString = @"";
    NSDictionary  *URLDict;
    
    NSString *environment = [[CRMUserDefaultTool share] getValueForKey:k_CRMEnvironment];
    
    if ( 1 == [environment intValue]) {
        URL_Header = URL_TEST_Heaher;
        URL_Paphone_Header = URL_Paphone_TEST_Heaher;
        URL_AdvisoryQ_A = URL_AdvisoryQ_A_TEST_Heaher;
    }else{
        URL_Header = URL_PRD_Heaher;
        URL_Paphone_Header = URL_Paphone_PRD_Heaher;
        URL_AdvisoryQ_A = URL_AdvisoryQ_A_PRD_Heaher;

    }
    
    URLDict = @{
                //登录
                @"FIHttpRequestTypeLogin":[[self class] strURLWithHeader:@"aat/login.do"],
                // 会话列表
                @"FIHttpRequestTypeDialogList":[[self class] strURLWithHeader:@"dialogueInfo/getDialogueInfo.do"],
                // 结束聊天
                @"FIHttpRequestTypeCloseDialog":[[self class] strURLWithHeader:@"dialogClose/closeDialog.do"],
                // 消息初始化;
                @"FIHttpRequestTypeMsgInit":[[self class] strURLWithHeader:@"sendMsgInit/initMessage.do"],
                //###       历史聊天界面      ###
                @"FIHttpRequestTypeGetHistoryMessage":[[self class] strURLWithHeader:@"msgInfo/getAgentChats.do"],
                // 退出接口；
                @"FIHttpRequestTypeLogOut":[[self class] strURLWithHeader:@"stock/logout.do"],
                // 视频沟通接口
                @"FIHttpRequestTypeVideoCommunicate":[[self class] strURLWithHeader:@"videoSession/videoCommunicate.do"],
                // 获取组件图片
                @"FIHttpRequestGetImage":[[self class] strURLWithHeader:@"addonsImg/getImage.do"],
                // 上传图片
                @"FIHttpRequestTypeUploadImg":[[self class] strURLWithHeader:@"uploadImage/uploadAgentSendImage.do"],
                // 图片资源 头地址 ；
                @"FIIMageHeadURL":[[self class] strURLWithHeader:@"writeImage/getImageFile.do?medioId="],
                // 获取终端动态分机号码
                @"HTTPS_clientInit":[[self class] strPaPhoneURLWithHeader:@"clientInit.do"],
                @"HTTPS_registExtension":[[self class] strPaPhoneURLWithHeader:@"registExtension.do"],
                @"HTTPS_releaseExtension":[[self class] strPaPhoneURLWithHeader:@"releaseExtension.do"],
                @"HTTPS_call":[[self class] strPaPhoneURLWithHeader:@"call.do"],
                //满意度
                @"HTTPS_SatisfactionSurvey":[[self class]strURLWithHeader:@"satisfactionSurvey/satisfactionSurvey.do"],
                
                @"AATCommand_CollectResource":[[self class]strURLWithHeader:@"resource/collectResource.do"],
                @"AATCommand_DelCollectResource":[[self class]strURLWithHeader:@"resource/delResourceCollect.do"],
                @"AATCommand_CollectResourceList":[[self class]strURLWithHeader:@"resource/getResourceCollect.do"],
                @"AATAdvisoryQ_A":URL_AdvisoryQ_A,
                @"AATSignKey": @"fasjd70asdassad0",   // 加密KEY
                @"AAT_BURRYING_POINT":[[self class]strURLWithHeader:@"buryingPointRest/buryingPoint.do"]
                };
    
    switch (type) {
            
        case FIHttpRequestTypeLogin:
            urlString = URLDict[@"FIHttpRequestTypeLogin"];
            break;
        case FIHttpRequestTypeDialogList:// 会话列表
            urlString = URLDict[@"FIHttpRequestTypeDialogList"];
            break;
        case FIHttpRequestTypeMsgInit:// 会话界面
            urlString = URLDict[@"FIHttpRequestTypeMsgInit"];
            break;
        case FIHttpRequestTypeCloseDialog://结束聊天
            urlString = URLDict[@"FIHttpRequestTypeCloseDialog"];
            break;
        case FIHttpRequestTypeGetHistoryMessage:// 历史消息_所有消息
            urlString = URLDict[@"FIHttpRequestTypeGetHistoryMessage"];
            break;
            //  logOut  接口
        case FIHttpRequestTypeLogOut:
            urlString = URLDict[@"FIHttpRequestTypeLogOut"];
            break;
        case FIHttpRequestTypeVideoCommunicate:
            urlString = URLDict[@"FIHttpRequestTypeVideoCommunicate"];
            break;
        case FIHttpRequestGetImage:
            urlString = URLDict[@"FIHttpRequestGetImage"];
            break;
        case FIHttpRequestTypeUploadImg:
            urlString = URLDict[@"FIHttpRequestTypeUploadImg"];
            break;
        case HTTPS_clientInit:
            urlString = URLDict[@"HTTPS_clientInit"];
            break;
        case HTTPS_registExtension:
            urlString = URLDict[@"HTTPS_registExtension"];
            break;
        case HTTPS_releaseExtension:
            urlString = URLDict[@"HTTPS_releaseExtension"];
            break;
        case HTTPS_call:
            urlString = URLDict[@"HTTPS_call"];
            break;
        case FIIMageHeadURL:
            urlString = URLDict[@"FIIMageHeadURL"];
            break;
        case HTTPS_SatisfactionSurvey:
            urlString = URLDict[@"HTTPS_SatisfactionSurvey"];
            break;
        case AATCommand_CollectResource:
            urlString = URLDict[@"AATCommand_CollectResource"];
            break;
        case AATCommand_DelCollectResource:
            urlString = URLDict[@"AATCommand_DelCollectResource"];
            break;
        case AATCommand_CollectResourceList:
            urlString = URLDict[@"AATCommand_CollectResourceList"];
            break;
        case AATAdvisoryQ_A:
            urlString = URLDict[@"AATAdvisoryQ_A"];
            break;
         case AATSignKey:
            urlString = URLDict[@"AATSignKey"];
            break;
        case AAT_BURRYING_POINT:
            urlString = URLDict[@"AAT_BURRYING_POINT"];
        default:
            break;
    }
    
    return urlString;
}


+(NSString*)strURLWithHeader:(NSString*)subURL {
    
    return [NSString stringWithFormat:@"%@%@",URL_Header, subURL];
}

+(NSString*)strPaPhoneURLWithHeader:(NSString*)subURL {
    
    return [NSString stringWithFormat:@"%@%@",URL_Paphone_Header, subURL];
}






*/
@end










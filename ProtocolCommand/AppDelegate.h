//
//  AppDelegate.h
//  ProtocolCommand
//
//  Created by HansonYang on 2017/6/9.
//  Copyright © 2017年 HansonYang. All rights reserved.
//
#define Hanson_Test_webChatView   @"dialog"
#define Hanson_WebViewDialog   @"Hanson_WebViewDialog"

#define Hanson_Test_webBlock   @"searchbarclick"
#define Hanson_Block_Alert   @"Hanson_Block_Alert"

#import "HYOpenURLService.h"

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) HYOpenURLService *commandService;

+(AppDelegate*)shared;


@end


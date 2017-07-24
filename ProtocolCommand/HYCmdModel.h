//
//  HYCmdModel.h
//  ProtocolCommand
//
//  Created by HansonYang on 2017/7/12.
//  Copyright © 2017年 HansonYang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HYCmdModel : NSObject

 // 协议
@property(assign,nonatomic)NSString *protocolHeader;

// 指令 类对象
@property(assign,nonatomic)NSString *protocolCommand;

// 参数 ；
@property(retain,nonatomic)NSDictionary *protocolParma;

@end

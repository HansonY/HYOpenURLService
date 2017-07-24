//
//  HYBaseViewController.h
//  ProtocolCommand
//
//  Created by HansonYang on 2017/6/14.
//  Copyright © 2017年 HansonYang. All rights reserved.
//

#import "ViewController.h"

@interface HYBaseViewController : UIViewController

 // 获取 接受 变量 传参；
-(void)setParameter:(NSMutableDictionary*)parameter;

 // 获取 变量  赋值；
-(void)registeredURLBlock;

@end

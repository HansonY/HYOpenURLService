//
//  HYTestViewController.m
//  ProtocolCommand
//
//  Created by HansonYang on 2017/6/9.
//  Copyright © 2017年 HansonYang. All rights reserved.
//

#import "HYTestViewController.h"

@interface HYTestViewController ()

@end

@implementation HYTestViewController{

    UILabel *_name;
    NSString *_nameStr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _name = [[UILabel alloc]initWithFrame:CGRectMake(100, 100, 500, 60)];
    _name.backgroundColor = [UIColor greenColor];
    _name.textAlignment = NSTextAlignmentLeft;
    _name.text = _nameStr;
    [self.view addSubview:_name];
     
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 200, 500, 60)];
    btn.backgroundColor = [UIColor brownColor];
    [btn setTitle:@"URL 打开" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(openURL) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
}

-(void)openURL{
    
//    [ [ AppDelegate shared ].commandService  openURL: [HYOpenURLService cmd_URL_Block:Hanson_Test_Action]  ];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)openTest{

    NSLog(@"666666 ")       ;
}


//// 创建  方法 对应  键值；
//-(NSMutableDictionary*)webCommandMapping{
//
//}
// 获取 变量 变量；
-(void)setParameter:(NSMutableDictionary*)parameter{

    NSLog(@"  URL 获得   age is  %@ " , parameter[@"cellindex"]);
     _nameStr = [NSString stringWithFormat:@"打开会话 ID :  #  %@ " ,parameter[@"cellindex"] ];
    
}
// 获取 变量  赋值；
-(void)webDataInit{

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

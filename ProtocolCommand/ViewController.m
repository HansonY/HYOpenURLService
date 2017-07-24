//
//  ViewController.m
//  ProtocolCommand
//
//  Created by HansonYang on 2017/6/9.
//  Copyright © 2017年 HansonYang. All rights reserved.
//
#import "AppDelegate.h"

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController{

    UITableView *_tableView;
    NSArray *tableData;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"中间件";
    self.view.backgroundColor = [UIColor whiteColor];
 
    [self createView];
    NSLog(@" view UI  当前 线程 " );
    
    [self registered];
    
    
}

-(void)createView{

    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.tableFooterView= [[UIView alloc]init];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    tableData = @[
                            @"URL 打开 block ",
                            @"URL 打开 block   带参数",
                            @"URL 打开 一个http地址 ",
                            @"URL 打开 会话页面  不带参(远程加载)",
                            @"URL 打开 会话页面  带参数(加载本地)",
                            @"============分割线============",

                            @"接口方式 打开 block   带参数",
                            @"接口方式 打开 会话页面  带参数(加载本地)",

                            ];
    
    [self.view addSubview:_tableView];
    
}

 

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
 
    return tableData.count;
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    
    cell.textLabel.text = [tableData objectAtIndex:indexPath.row];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    // 分割线
    if (indexPath.row == 5)    return;
    
    if (indexPath.row == 0) {
        // 不传参  默认取注册时 的参数；
        [ [ AppDelegate shared ].commandService openURL: [HYOpenURLService cmd_URL_Block:Hanson_Block_Alert] ];
        return;
    }
    // 传参 取值；
    if (indexPath.row == 1) {
        NSString *urlCommand = [NSString stringWithFormat:@"%@?%@",Hanson_Block_Alert,@"title=酸辣粉"];
        [ [ AppDelegate shared ].commandService openURL: [HYOpenURLService cmd_URL_Block:urlCommand]  ];
        return;
    }
    // 支持 https/http 自动打开一WebViewController 页面
    if (indexPath.row == 2) {
        [ [ AppDelegate shared ].commandService openURL: @"https://www.baidu.com"  ];
        return;
    }
    //  打开原始 会话 列表  不传参；
    if (indexPath.row == 3) {
        [ [ AppDelegate shared ].commandService openURL: [HYOpenURLService cmd_URL_View:Hanson_WebViewDialog]  ];
        return;
    }
    //  打开原始 会话 列表  传参， isLoadLocal = YES  加载本地资源,  反之加载 远程地址；
    if (indexPath.row == 4) {
        NSString *cmd = [NSString stringWithFormat:@"%@?%@" , [HYOpenURLService cmd_URL_View:Hanson_WebViewDialog] ,@"isLoadLocal=YES"  ];
        [ [ AppDelegate shared ].commandService openURL:cmd ];
        return;
    }

//
    if (indexPath.row == 6) {
        [ [ AppDelegate shared ].commandService  openURL: [HYOpenURLService cmd_URL_Block:Hanson_Block_Alert] withParam:@{@"title":@"酸辣粉2222"} ];
         return;
    }
    
    if (indexPath.row == 7) {
        [ [ AppDelegate shared ].commandService openURL:[HYOpenURLService cmd_URL_View:Hanson_WebViewDialog] withParam:@{@"isLoadLocal":@"YES"}];
        return;
    }

    
    
}






-(void)registered{

    NSDictionary *dic = @{  @"title":@"good good study day day up" };
     // 注册  URL  绑定 bolck
 
    [HYOpenURLService addBlockMappingKey:Hanson_Block_Alert
                              withParam:dic completion:^id(NSDictionary *param) {
                                  
                                  NSString *test = param[@"title"];
                                  if (!test)  test = @"";
                                  
                                  UIAlertView *alter = [ [ UIAlertView alloc] initWithTitle:@"test" message:test delegate:self cancelButtonTitle:@"ok" otherButtonTitles:@"cancel", nil];
                                  
                                  [alter show];
                                  
                                  return [NSString stringWithFormat:@"%@",test];
                                  
                              }];

}

-(void)testThread{

        NSLog(@"我是 子 线程 ");
}

-(void)openURL{
 //      URL  方式, 方便嵌入Web / 静态页面 ;
    NSString *urlCommand = [NSString stringWithFormat:@"%@?%@",Hanson_Block_Alert,@"title=酸辣粉"];
    [ [ AppDelegate shared ].commandService openURL: [HYOpenURLService cmd_URL_Block:urlCommand]  ];
     // 参数传递；
    [ [ AppDelegate shared ].commandService openURL: [HYOpenURLService cmd_URL_Block:Hanson_Block_Alert] ];
    
}

-(void)openMapURL{
//    URL 地址；
//    NSString *testViewPush = @"HYLocal://view/HYTestView";
//    // 参数；
    NSDictionary *infoParam = @{@"name":@"hanson",@"age":@"19"};
//    [[AppDelegate shared].commandService   openURL:testViewPush  withParam:infoParam];
//    [ [ AppDelegate shared ].commandService  openURL: [HYOpenURLService cmd_URL_View:Hanson_Test_OpenView ]
//                                                                          withParam:infoParam  ];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





@end

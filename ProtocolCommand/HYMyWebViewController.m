//
//  HYMyWebViewController.m
//  ProtocolCommand
//
//  Created by HansonYang on 2017/7/10.
//  Copyright © 2017年 HansonYang. All rights reserved.
//

#import "HYMyWebViewController.h"

@interface HYMyWebViewController ()

@end

@implementation HYMyWebViewController{
    NSMutableArray  *dataArary;
    NSMutableArray  *iconArary;
    BOOL  isLoadLocal;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 获取 变量 变量；
-(void)setParameter:(NSMutableDictionary*)parameter{
    
    isLoadLocal = parameter[@"isLoadLocal"] == @"YES"?@YES:@NO;
    
}

-(void)registeredURLBlock{
    
    NSDictionary *dic2 = @{  @"title":@"这是一个 web测试 来自当前页面 注册" };

    [HYOpenURLService addBlockMappingKey:Hanson_Test_webBlock
                               withParam:dic2 completion:^id(NSDictionary *param) {
                                   
                                   NSString *test = param[@"title"];
                                   if (!test)  test = @"";
                                   UIAlertView *alter = [[UIAlertView alloc]initWithTitle:@"test" message:test delegate:self cancelButtonTitle:@"ok" otherButtonTitles:@"cancel", nil];
                                   [alter show];
                                   return nil;
                                   
                               }];

}



-(void)initWebView{
    [super initWebView];
    
    [self createView];
}

// 自定义加载路径 或方法；
-(void)loadWeb{
    
    NSString *strURL = @"http://1.hanson1024.applinzi.com/distVue/index.html";
    NSURL *url = [NSURL URLWithString:strURL];
    
    NSURLRequest * urlReuqest = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:0];
    [self.myWeb loadRequest:urlReuqest];
    
    //         加载 HTML  本地文件  例子；
    if(isLoadLocal)  [self loadLocalHtml:@"dist/index" catalogPath:@"/dist/"];

 
}

-(void)createView{
    
    dataArary = [[NSMutableArray alloc]init];
    iconArary = [[NSMutableArray alloc]init];
    
    [iconArary addObject:@"http://img5.imgtn.bdimg.com/it/u=1366499415,1057914362&fm=26&gp=0.jpg"];
    [iconArary addObject:@"https://www.baidu.com/img/bd_logo1.png"];
    [iconArary addObject:@"http://img3.duitang.com/uploads/blog/201605/29/20160529072811_ZPWcY.thumb.224_0.jpeg"];
    [iconArary addObject:@"http://img5.imgtn.bdimg.com/it/u=1981331305,170397280&fm=26&gp=0.jpg"];
    [iconArary addObject:@"http://img5.imgtn.bdimg.com/it/u=1981331305,170397280&fm=26&gp=0.jpg"];
    
    
    NSArray * _titles = @[@"增加", @"清空",@"更新",@"性能测试",@"查看"];
    UISegmentedControl * _segmentedControl = [[UISegmentedControl alloc] initWithItems:_titles];
    
    //修改字体的默认颜色与选中颜色
    //选择后的字体颜色（在NSDictionary中 可以添加背景颜色和字体的背景颜色）
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor],
                         NSForegroundColorAttributeName,
                         [UIFont systemFontOfSize:12],
                         NSFontAttributeName,nil];
    
    [ _segmentedControl setTitleTextAttributes:dic forState:UIControlStateSelected];
    
    //默认字体颜色
    NSDictionary *dic1 = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor blueColor],
                          NSForegroundColorAttributeName,
                          [UIFont systemFontOfSize:12],
                          NSFontAttributeName,nil];
    
    [ _segmentedControl setTitleTextAttributes:dic1 forState:UIControlStateNormal];
    
    [_segmentedControl addTarget:self action:@selector(segmentValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    _segmentedControl.frame = CGRectMake(0.0, 0.0, 200.0, 29.0);
    self.navigationItem.titleView = _segmentedControl;
    
}

-(void)addMsg{
    
    
    int randIcon = (arc4random()%5 -1) ;                                  // 随机数；
    if (randIcon < 0 ) {
        randIcon = 0;
    }
    
    NSString *unRead = [NSString stringWithFormat:@"%d" , randIcon ];
    NSMutableDictionary *data = [[NSMutableDictionary alloc]init];
    [data setObject: [iconArary objectAtIndex:randIcon] forKey:@"customerIcon"];
    [data setObject: @"小刘123" forKey:@"customerName"];
    [data setObject: @"faskjfal;" forKey:@"msg"];
    [data setObject: unRead forKey:@"unRead"];
    [data setObject: @"1499666187" forKey:@"timeStamp"];
    [data setObject: @"phone" forKey:@"paImType"];
    
    [dataArary addObject:data];
    
    [self webLoadData:dataArary];
    
}

-(void)cleanData{
    
    [dataArary removeAllObjects];
    [self webLoadData:nil];
}

-(void)updateData{
    
    if (dataArary.count >1) {
    }else{
        return;
    }
    
    int randData = 3;
    if (dataArary.count < randData) {
        randData = (int)dataArary.count;
    }
    
    int randIcon = (arc4random()%randData -1) ;                                  // 随机数；
    if (randIcon < 0 ) {
        randIcon = 0;
    }
    
    NSString *unRead = [NSString stringWithFormat:@"%d" , randIcon ];
    NSMutableDictionary *temp =(NSMutableDictionary*) [dataArary objectAtIndex:randIcon];
    
    temp[@"unRead"] = unRead;
    unRead = [NSString  stringWithFormat:@"test Update*********  %@" , unRead ];
    temp[@"customerName"] = unRead;
    
    [self webLoadData:dataArary];
    
}

-(void)testData{
    
    for (int i = 0 ; i< 20 ; i++) {
        [self addMsg];
    }
    
}


-(void)segmentValueChanged:(UISegmentedControl *)seg{
    NSLog(@"seg.tag-->%ld",seg.selectedSegmentIndex);
    
    switch (seg.selectedSegmentIndex) {
        case 0:{
            
            [self addMsg];
            
            break;
            
        }
            
        case 1:{
            
            [self cleanData];
            
            break;
        }
            
        case 2:{
            
            [self updateData];
            
            break;
        }
            
        case 3:{
            
            [self testData];
            
            break;
        }
            
        case 4:{
            
            break;
        }
            
        default:
            break;
    }
    
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

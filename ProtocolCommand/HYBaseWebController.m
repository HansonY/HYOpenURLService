//
//  HYBaseWebController.m
//  HYTabBarController
//
//  Created by HansonYang on 17/4/11.
//  Copyright © 2017年 HansonYang. All rights reserved.
//

#import "HYBaseWebController.h"

@interface HYBaseWebController ()

@end

@implementation HYBaseWebController
- (void)viewDidLoad {
    
    [super viewDidLoad];

}

-(void)viewWillAppear:(BOOL)animated{
    if (!self.myWeb) {
        [self initWebView];
    }

}

-(void)initWebView{
    
    self.myWeb = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    self.myWeb.UIDelegate = self;
    self.myWeb.navigationDelegate = self;
    [self.view addSubview:self.myWeb];
    self.view.backgroundColor = [UIColor whiteColor];
    
//  加载 web；
    [self loadWeb];

}

-(void)loadWeb{
    
    if(self.strURL)
        [self.myWeb loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.strURL]]];

//     加载 HTML  本地文件  例子；
//    [self loadLocalHtml:@"dist/index" catalogPath:@"/dist/"];

}

#pragma mark   加载 HTML  本地文件；
-(void)loadLocalHtml:(NSString*)PathForResource   catalogPath:(NSString*)catalogPath{
    
    NSString *html = [[NSBundle mainBundle]
                      pathForResource: PathForResource  ofType:@"html"];
     //UTF8编码，解决中文乱码
    //获得 html 文件 内容；
    NSString *htmlContent = [NSString stringWithContentsOfFile:html encoding:NSUTF8StringEncoding error:nil ];
    NSString *path = [ [ [ NSBundle mainBundle ] bundlePath ] stringByAppendingString: catalogPath ];
    
    NSLog(@"Bundle Path: %@", path);
    NSURL *basePath = [NSURL fileURLWithPath:path];
    [self.myWeb loadHTMLString:htmlContent baseURL:basePath];

}








-(void)webLoadData:(id)object{

    NSString * jsonStr = [[self  class] dictionaryToJson:object];
    NSString *jsonString = [NSString stringWithFormat:@"chatlist.setuplist(%@)" , jsonStr];

    [self.myWeb   evaluateJavaScript:jsonString completionHandler:^(id _Nullable  data , NSError * _Nullable error) {
        NSLog(@" sdfaf  asfds  dwdw %@", data);
    }];
 
}

+ (NSString*)dictionaryToJson:(id)dic
{
    if ( dic != nil) {
        NSError *parseError = nil;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
        return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
    }
    
    return nil;
}

- (void)goBack{
    [self.myWeb goBack];

}

-(void)registeredURLBlock{

}

-(void)setParameter:(NSMutableDictionary*)parameter{
    
    self.strURL = parameter[@"strURL"];
    
    NSLog(@"  URL data     is  %@ " , parameter);
    
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation{

    
}


- (void)observeValueForKeyPath:(nullable NSString *)keyPath ofObject:(nullable id)object change:(nullable NSDictionary<NSKeyValueChangeKey, id> *)change context:(nullable void *)context{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    
    NSString *strURL =  [navigationAction.request.URL absoluteString];
    NSLog(@"strURL  is  %@", strURL );
  
    if ([strURL hasPrefix:@"local:"]) {
         [ [ AppDelegate shared ].commandService  openURL:strURL];

        decisionHandler(WKNavigationActionPolicyCancel);
        return ;
    }
    
    decisionHandler(WKNavigationActionPolicyAllow);
    
}

#pragma mark  alert ;
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:([UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }])];
    [self presentViewController:alertController animated:YES completion:nil];
    
}
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler{
    //    DLOG(@"msg = %@ frmae = %@",message,frame);
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:([UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(NO);
    }])];
    [alertController addAction:([UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(YES);
    }])];
    [self presentViewController:alertController animated:YES completion:nil];
}
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable))completionHandler{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:prompt message:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.text = defaultText;
    }];
    [alertController addAction:([UIAlertAction actionWithTitle:@"完成" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(alertController.textFields[0].text?:@"");
    }])];
    
}

@end

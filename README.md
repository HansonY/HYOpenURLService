 # HYOpenURLService
定义一套原生交互的协议iOS URL ，方便原始与原始组件化，也方便Web页面与原生无缝交互；<br/>
### 提供了两种类型注册
#### 1.页面注册
    页面ViewController 注册 , 传入Key名，对应页面Class类名;<br/>
  
    [HYOpenURLService regViewCmdForKey:@"key名" withClassName:@"类名"];
    
#### 2.block 注册
##### 传入参数 "dic" 可以在 block "param"  被调用，可设定返回值；

      NSDictionary *dic = @{  @"title":@"good good study day day up" };

      [HYOpenURLService addBlockMappingKey:Hanson_Block_Alert
                                 withParam:dic 
                                 completion:^id(NSDictionary *param) {
                                 
                                      NSString *title = param[@"title"];
                                      NSLog(@"title is %@" ,title );
                                  
                                    return nil;
                                 }];
                                 
##### 不传参 方法

    [HYOpenURLService addBlockMappingKey:Hanson_Block_Alert
                                completion:^id(NSDictionary *param) {
                                return nil;
                                }

    

 
## API 说明
初始化   <br/>

    ViewController * VC = [[ViewController alloc]init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:VC];
    self.window.rootViewController = nav;
    [HYOpenURLService Shared].nav = nav;


    [HYOpenURLService regViewCmdForKey:Hanson_WebViewDialog withClassName:@"HYMyWebViewController"];




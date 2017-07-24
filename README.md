 # HYOpenURLService
定义一套原生交互的协议iOS URL ，方便原生与原生组件化，也方便Web页面与原生无缝交互；<br/>

协议类型://指令类型/指令?参数1=值1&参数2=值2；

local://view/   打开页面或传值类型    <br/>
local://block/" 执行block或传值类型  <br/>

### 提供了两种类型注册
#### 1.页面注册
    页面ViewController 注册 , 传入Key名，对应页面Class类名;<br/>
  
    [HYOpenURLService regViewCmdForKey:@"key名" withClassName:@"类名"];
    [HYOpenURLService regViewCmdForKey:@"Hanson_WebViewDialog" withClassName:@"HYMyWebViewController"];

#### 2.block 注册
##### 传入参数 "dic" 可以在 block "param"  被调用，可设定返回值；

      NSDictionary *dic = @{  @"title":@"good good study day day up" };

      [HYOpenURLService addBlockMappingKey:@"Hanson_Block_Alert"
                                 withParam:dic 
                                 completion:^id(NSDictionary *param) {
                                 
                                      NSString *title = param[@"title"];
                                      NSLog(@"title is %@" ,title );
                                  
                                    return nil;
                                 }];
                                 
##### 不传参 方法

    [HYOpenURLService addBlockMappingKey:@"Hanson_Block_Alert"
                                completion:^id(NSDictionary *param) {

                                 // 自定义;
                                 return nil;
                                 }

### 页面，block 调用方式：
#### URL:   方式打开 可兼容 Web 页面调用；<br/>
#### 接口:  方式打开 更好的；<br/>

#### 页面调用

          [HYOpenURLService cmd_URL_View:@"Hanson_WebViewDialog"]   URL 为：local://block/Hanson_WebViewDialog

          [[HYOpenURLService Shared] openURL: [HYOpenURLService cmd_URL_View:@"Hanson_WebViewDialog"]];

          [[HYOpenURLService Shared] openURL:[HYOpenURLService cmd_URL_View:@"Hanson_WebViewDialog"] 
                                                withParam:@{@"isLoadLocal":@"YES"}];
          //  URL 打开                                     
          NSString *cmd = [NSString stringWithFormat:@"%@?%@",[HYOpenURLService cmd_URL_View:Hanson_WebViewDialog] ,@"isLoadLocal=YES"];
          //即 cmd = local://block/Hanson_WebViewDialog?isLoadLocal=YES;
          [[HYOpenURLService Shared] openURL:cmd ];


#### block调用
##### 若传参按新传参数 执行block，未传参数默认注册时的参数；

         
          [ HYOpenURLService cmd_URL_Block:@"Hanson_Block_Alert" ]  URL 为：local://block/Hanson_Block_Alert

          [[HYOpenURLService Shared] openURL: [HYOpenURLService cmd_URL_Block:Hanson_Block_Alert ]];

          //  接口方式 打开;
          [[HYOpenURLService Shared] openURL: [ HYOpenURLService cmd_URL_Block: @"Hanson_Block_Alert" ]
                                                 withParam: @{@"title":@"酸辣粉2222"} ];

          //  URL 打开； 
          NSString *urlCommand = [NSString stringWithFormat:@"%@?%@",@"Hanson_Block_Alert",@"title=酸辣粉"];
          //即 cmd = local://block/Hanson_Block_Alert?title=酸辣粉;
          [[HYOpenURLService Shared] openURL: [ HYOpenURLService cmd_URL_Block: urlCommand ]];

 
## 使用初始化
#### 初始化 建议 nav = 赋值全局UINavigationController ；

     ViewController * VC = [[ViewController alloc]init];
     UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:VC];
     self.window.rootViewController = nav;
    
     [HYOpenURLService Shared].nav = nav;
    
  
    

 



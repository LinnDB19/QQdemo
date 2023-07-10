//
//  ViewController.m
//  demo
//
//  Created by Abakus on 2023/6/25.
//

#import "ViewController.h"
#import "TableViewController.h"
@interface ViewController ()
@property(strong, nonatomic) UICollectionView *collectionView;
@end

@implementation ViewController

- (void)viewDidLoad {

    //self.view.backgroundColor = [UIColor whiteColor];
    
}

//NSURLSession
-(void)demo2{
    //访问百度首页
    
    //1. 创建一个网络请求
    NSURL *url = [NSURL URLWithString:@"https://baidu.com"];
    
    //2.创建请求对象
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    //3.获得会话对象
    NSURLSession *session=[NSURLSession sharedSession];
    
    //4.根据会话对象创建一个Task(发送请求）
    /*
     第一个参数：请求对象
     第二个参数：completionHandler回调（请求完成【成功|失败】的回调）
     data：响应体信息（期望的数据）
     response：响应头信息，主要是对服务器端的描述
     error：错误信息，如果请求失败，则error有值
     */
    NSURLSessionDataTask *dataTask=[session dataTaskWithRequest:request
                                              completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            //response ： 响应：服务器的响应
            //data：二进制数据：服务器返回的数据。（就是我们想要的内容）
            //error：链接错误的信息
            NSLog(@"网络响应：response：%@",response);
        
            //根据返回的二进制数据，生成字符串！NSUTF8StringEncoding：编码方式
            NSString *html = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            
            //在客户端直接打开一个网页！
            //客户端服务器：UIWebView

            //将浏览器加载到view上
            dispatch_async(dispatch_get_main_queue(), ^{
            
            //实例化一个客户端浏览器
            WKWebView *web = [[WKWebView alloc]initWithFrame:self.view.bounds];
            
            //加载html字符串：baseURL：基准的地址：相对路径/绝对路径
            [web loadHTMLString:html baseURL:nil];
            [self.view addSubview:web];
            
            });
        
            //        //在本地保存百度首页
            //        [data writeToFile:@"/Users/Liu/Desktop/baidu.html" atomically:YES];
        
        }
    ];
    
    //5.执行任务
    [dataTask resume];
}

-(void)demo1{
    //访问百度首页
    
    //1. 创建一个网络请求
    NSURL *url = [NSURL URLWithString:@"https://baidu.com"];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    //2. 发送网络请求  网络请求是个耗时操作，在子线程发送
    
    //第一种发送网络请求的方式
    
    /*
     * 利用 NSUrlConnection 发送一个异步的网络请求
     *
     * @param NSURLRequest 网络请求
     *
     * @return
     */
    //queue：操作队列，决定网络请求完成后的Block(completionHandler) 回调在那条线程执行
    //[NSOperationQueue mainQueue] 主线程
    //completionHandler ：block 回调：网络请求完成之后，就会自动调用这个 Block
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        //response ： 响应：服务器的响应
        //data：二进制数据：服务器返回的数据。（就是我们想要的内容）
        //coonectionError：链接错误的信息
        NSLog(@"网络响应：response：%@",response);
        
        //根据返回的二进制数据，生成字符串！NSUTF8StringEncoding：编码方式
        NSString *html = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        
        //在客户端直接打开一个网页！
        //客户端服务器：UIWebView
        
        //实例化一个客户端浏览器
        UIWebView *web = [[UIWebView alloc]initWithFrame:self.view.bounds];
        
        //加载html字符串：baseURL：基准的地址：相对路径/绝对路径
        [web loadHTMLString:html baseURL:nil];
        
        //将浏览器加载到view上
        [self.view addSubview:web];
        
//        //在本地保存百度首页
//        [data writeToFile:@"/Users/Liu/Desktop/baidu.html" atomically:YES];
        
        NSLog(@"网路链接错误 connectionError响应：response：%@",connectionError);
    }];
}

@end

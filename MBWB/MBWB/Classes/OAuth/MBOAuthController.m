//
//  MBOAuthController.m
//  MBWB
//
//  Created by 浩渺 on 16/5/16.
//  Copyright © 2016年 haomiao. All rights reserved.
//

#import "MBOAuthController.h"
#import "MBProgressHUD.h"
#import "MBTabBarViewController.h"
#import "MBNewFeatureController.h"
#import "MBAccount.h"
#import "MBAccountTool.h"
#import "MBChooseController.h"
#import "MBHttpTool.h"
@interface MBOAuthController ()<UIWebViewDelegate>

@end

@implementation MBOAuthController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIWebView *webView = [[UIWebView alloc]init];
    webView.frame = self.view.bounds;
    [self.view addSubview:webView];
    
    //请求
//https://api.weibo.com/oauth2/authorize?client_id=123050457758183&redirect_uri=http://www.example.com/response&response_type=code
//    //同意授权后会重定向
//http://www.example.com/response&code=CODE
    
    NSString *urlString = [NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=%@&redirect_uri=%@",MBAppKey,MBRedirect_uri];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    
    webView.delegate = self;
}

#pragma  mark --UIWebViewDelegate

/**
 *  UIWebView开始加载资源的时候调用(开始发送请求)
 */
- (void)webViewDidStartLoad:(UIWebView *)webView{
    NSLog(@"webViewDidStartLoad");
//    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    hud.labelText = @"Loading";
    
}

/**
 *  UIWebView加载完毕的时候调用(请求完毕)
 */
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    NSLog(@"webViewDidFinishLoad");
//    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

/**
 *  UIWebView加载失败的时候调用(请求失败)
 */
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
//    didFailLoadWithError = Error Domain=WebKitErrorDomain Code=102 "Frame load interrupted" UserInfo={NSErrorFailingURLStringKey=https://github.com/iMaBiao?code=36278bb8946df7d1f83351b21f64908a, NSLocalizedDescription=Frame load interrupted, NSErrorFailingURLKey=https://github.com/iMaBiao?code=36278bb8946df7d1f83351b21f64908a}
    
    NSLog(@"didFailLoadWithError = %@",error);
    
//    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

/**
 *  UIWebView每当发送一个请求之前，都会先调用这个代理方法（询问代理允不允许加载这个请求）
 *  @param request        即将发送的请求
 *  @return YES : 允许加载， NO : 禁止加载
 */
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    

     // 1.获得请求地址
    NSString *url = request.URL.absoluteString;
    //url = https://github.com/iMaBiao?code=2f5accf534edcc5e5ea7a1e525500989
    
    // 2.判断url是否为回调地址
    NSString *str  = [NSString stringWithFormat:@"%@?code=",MBRedirect_uri];
    NSRange range = [url rangeOfString:str];
    if (range.location != NSNotFound) {// 是回调地址
       
        // 截取授权成功后的请求标记
        NSInteger from = range.location + range.length;
        NSString *code = [url substringFromIndex:from];
        
        // 根据code获得一个accessToken
        [self accessTokenWithCode:code];
     
        NSLog(@"OAuthController ---code = %@",code);
        // 禁止加载回调页面
        return NO;
    }
    return  YES;
}

/**
 *  根据code获得一个accessToken
 *
 *  @param code 授权成功后的请求标记
 */
- (void)accessTokenWithCode:(NSString *)code{

   
    //2、封装参数
//    client_id	true	string	申请应用时分配的AppKey。
//    client_secret	true	string	申请应用时分配的AppSecret。
//    grant_type	true	string	请求的类型，填写authorization_code

//    code	true	string	调用authorize获得的code值。
//    redirect_uri	true	string	回调地址，需需与注册应用里的回调地址一致。
    
    NSMutableDictionary *parms = [NSMutableDictionary dictionary];
    parms[@"client_id"] = MBAppKey;
    parms[@"client_secret"] = MBAppSecret;
    parms[@"grant_type"] =  @"authorization_code";
    parms[@"redirect_uri"] = MBRedirect_uri;
    parms[@"code"] = code;
    
    // 发送POST请求 https://api.weibo.com/oauth2/access_token
    [MBHttpTool post:@"https://api.weibo.com/oauth2/access_token" params:parms success:^(id responseObject) {
        
        // 字典转成模型
        MBAccount *account = [MBAccount accountWithDict:responseObject];
        // 存储帐号模型
        [MBAccountTool save:account];
        // 切换控制器(可能去新特性\tabbar)
        [MBChooseController chooseRootViewController];

    } failure:^(NSError *error) {
        NSLog(@"请求失败-----error = %@",error);
    
    }];
    
}


//// 存储授权成功的帐号信息
//NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory,NSUserDomainMask , YES)lastObject];
//NSString *filePath = [doc stringByAppendingString:@"account.plist"];
////        [responseObject writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
//[responseObject writeToFile:filePath atomically:YES];
//
//// 切换控制器(可能去新特性\tabbar)
//NSString *versionKey = (__bridge NSString *)kCFBundleVersionKey;
//
//// 从沙盒中取出上次存储的软件版本号(取出用户上次的使用记录)
//NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//NSString *lastVersion = [defaults objectForKey:@"versionKey"];
//NSString *currentVersion = [NSBundle mainBundle].infoDictionary[versionKey];
//
//UIWindow *window = [UIApplication sharedApplication].keyWindow;
//
//if ([currentVersion isEqualToString:lastVersion]) {
//    // 当前版本号 == 上次使用的版本：显示HMTabBarViewController
//    window.rootViewController = [[MBTabBarViewController alloc]init];
//}else{
//    // 当前版本号 != 上次使用的版本：显示版本新特性
//    window.rootViewController = [[MBNewFeatureController alloc]init];
//    
//    // 存储这次使用的软件版本
//    [defaults setObject:currentVersion forKey:@"versionKey"];
//    [defaults synchronize];
//}



@end

//
//  HZQRCodeScanResultViewController.m
//  HZQRCodeExample
//
//  Created by 季怀斌 on 2017/11/8.
//  Copyright © 2017年 huazhuo. All rights reserved.
//

#import "HZQRCodeScanResultViewController.h"
#import "NSString+IsUrlString.h"
#import "UIView+Frame.h"
#import "HZWebViewProgressLine.h"
#import <WebKit/WebKit.h>
@interface HZQRCodeScanResultViewController ()<WKUIDelegate, WKNavigationDelegate>
@property (nonatomic,strong) HZWebViewProgressLine  *progressLine;
@end

@implementation HZQRCodeScanResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    //创建一个UIButton
    UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    //设置UIButton的图像
    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //给UIButton绑定一个方法，在这个方法中进行popViewControllerAnimated
    [backButton addTarget:self action:@selector(backItemClick) forControlEvents:UIControlEventTouchUpInside];
    //然后通过系统给的自定义BarButtonItem的方法创建BarButtonItem
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    //覆盖返回按键
    self.navigationItem.leftBarButtonItem = backItem;

    
    if (![self.QRCodeDataStr isUrlString]) {
        UILabel *showLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 200, self.view.width - 100, 40)];
        showLabel.textAlignment = NSTextAlignmentCenter;
        showLabel.layer.borderWidth = 1;
        showLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
        showLabel.text = self.QRCodeDataStr;
        [self.view addSubview:showLabel];
        return;
    }
   
    
    WKWebView *webView = [[WKWebView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    NSURL *url = [NSURL URLWithString:self.QRCodeDataStr];
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    webView.UIDelegate = self;
    webView.navigationDelegate = self;
    [self.view addSubview:webView];
    
    //
    self.progressLine = [[HZWebViewProgressLine alloc] initWithFrame:CGRectMake(0, 64, self.view.width, 2)];
    self.progressLine.lineColor = [UIColor greenColor];
    [self.view addSubview:self.progressLine];
    
    //
    [webView loadRequest:request];
}



- (void)setQRCodeDataStr:(NSString *)QRCodeDataStr {
    _QRCodeDataStr = QRCodeDataStr;
}


#pragma mark - WKNavigationDelegate
// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    [self.progressLine startLoadingAnimation];
}
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{

}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
     [self.progressLine endLoadingAnimation];
    self.title = webView.title;
}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{

}
// 接收到服务器跳转请求之后调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation{

}
// 在收到响应后，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{

    NSLog(@"%@",navigationResponse.response.URL.absoluteString);
    //允许跳转
    decisionHandler(WKNavigationResponsePolicyAllow);
    //不允许跳转
    //decisionHandler(WKNavigationResponsePolicyCancel);
}
// 在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{

    NSLog(@"--22:%@",navigationAction.request.URL.absoluteString);
    
    [self validateUrl:navigationAction.request.URL decisionHandler:decisionHandler];
//    //允许跳转
//    decisionHandler(WKNavigationActionPolicyAllow);
//    //不允许跳转
//    //decisionHandler(WKNavigationActionPolicyCancel);
}
#pragma mark - WKUIDelegate
// 创建一个新的WebView
- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures{
    
    
    return [[WKWebView alloc]init];
}
// 输入框
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(nullable NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * __nullable result))completionHandler{
    
    
    completionHandler(@"http");
}
// 确认框
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler{
    completionHandler(YES);
    
    
}
// 警告框
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    NSLog(@"%@",message);
    
    completionHandler();
}


-(void)validateUrl:(NSURL *) candidate decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler;{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:candidate];
    [request setHTTPMethod:@"HEAD"];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"error %@",error);
        if (error) {
            NSLog(@"不可用");
            
            //不允许跳转
            decisionHandler(WKNavigationActionPolicyCancel);
            
        }else{
            NSLog(@"可用");
            
            //允许跳转
            decisionHandler(WKNavigationActionPolicyAllow);
            
        }
    }];
    [task resume];
}


// 判断一个网址是否可用
- (NSURL *)smartURLForString:(NSString *)str
{
    NSURL *     result;
    NSString *  trimmedStr;
    NSRange     schemeMarkerRange;
    NSString *  scheme;
    
    assert(str != nil);
    
    result = nil;
    
    trimmedStr = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if ( (trimmedStr != nil) && (trimmedStr.length != 0) ) {
        schemeMarkerRange = [trimmedStr rangeOfString:@"://"];
        
        if (schemeMarkerRange.location == NSNotFound) {
            result = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@", trimmedStr]];
        } else {
            scheme = [trimmedStr substringWithRange:NSMakeRange(0, schemeMarkerRange.location)];
            assert(scheme != nil);
            
            if ( ([scheme compare:@"http"  options:NSCaseInsensitiveSearch] == NSOrderedSame)
                || ([scheme compare:@"https" options:NSCaseInsensitiveSearch] == NSOrderedSame) ) {
                result = [NSURL URLWithString:trimmedStr];
            } else {
                // It looks like this is some unsupported URL scheme.
            }
        }
    }
    
    return result;
}
#pragma mark -- ddd
- (void)backItemClick {
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

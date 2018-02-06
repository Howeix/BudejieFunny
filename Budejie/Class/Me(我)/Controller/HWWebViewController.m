//
//  HWWebViewController.m
//  Budejie
//
//  Created by 黄炜 on 2018/1/26.
//  Copyright © 2018年 黄炜. All rights reserved.
//

#import "HWWebViewController.h"
#import <WebKit/WebKit.h>

@interface HWWebViewController ()
@property (weak, nonatomic) IBOutlet UIView *contentView;
//** webView */
@property (weak, nonatomic)WKWebView *webView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *ForwardItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *refreshItem;


@end

@implementation HWWebViewController
- (IBAction)clickBack:(UIBarButtonItem *)sender {
        [self.webView goBack];
}

- (IBAction)clickForward:(UIBarButtonItem *)sender {
        [self.webView goForward];
}

- (IBAction)clickRefresh:(UIBarButtonItem *)sender {
        [self.webView reload];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    WKWebView *webView = [[WKWebView alloc] init];
    [webView loadRequest:[NSURLRequest requestWithURL:_url]];
    self.webView = webView;
    [self.contentView addSubview:webView];
    
    //KVO监听属性改变
    /*
     Observer:观察者
     KeyPath:观察webView哪个属性发生变化
     options:NSKeyValueObservingOptionNew:观察新值改变
     
     KVO注意点,一定要记住移除
     
     */
    
    [webView addObserver:self forKeyPath:@"canGoBack" options:NSKeyValueObservingOptionNew context:nil];
    [webView addObserver:self forKeyPath:@"canGoForward" options:NSKeyValueObservingOptionNew context:nil];
    [webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
 
}


// 只要观察对象属性有新值就会调用
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    self.backItem.enabled = self.webView.canGoBack;
    self.ForwardItem.enabled = self.webView.canGoForward;
    self.title = self.webView.title;
    
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.webView.frame = self.contentView.bounds;
}


-(void)dealloc{
    [self.webView removeObserver:self forKeyPath:@"canGoBack"];
    [self.webView removeObserver:self forKeyPath:@"canGoForward"];
    [self.webView removeObserver:self forKeyPath:@"title"];
}

@end

//
//  JianshuController.m
//  CCDisplay
//
//  Created by luckyCoderCai on 2017/7/21.
//  Copyright © 2017年 luckyCoderCai. All rights reserved.
//

#import "JianshuController.h"

@interface JianshuController ()

@property (nonatomic, strong) UIWebView *webView;

@end

@implementation JianshuController

#pragma mark -lazy load
- (UIWebView *)webView
{
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
        _webView.backgroundColor = [UIColor cyanColor];
        _webView.scalesPageToFit = YES;
    }
    return _webView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor orangeColor];
    self.title = @"简书";
    
    [self.view addSubview:self.webView];
    
    NSURL *url = [NSURL URLWithString:self.urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//
//  QKWebViewController.m
//  quicker-cl-ios
//
//  Created by Nguyen Huu Anh on 5/8/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCSWebViewController.h"

@interface QKCSWebViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@end

@implementation QKCSWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setAngleLeftBarButton];
    
    NSString *url = @"http://yahoo.jp";
    if (_stringURL) {
        url = _stringURL;
    }
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

//
//  QKWebViewController.m
//  quicker-cl-ios
//
//  Created by Nguyen Huu Anh on 5/8/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLWebViewController.h"

@interface QKCLWebViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@end

@implementation QKCLWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setAngleLeftBarButton];
    NSString *url = @"http://yahoo.com";
    if (_stringURL) {
        url = _stringURL;
    }
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
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

//
//  QKAboutAppViewController.m
//  quicker-cs-ios
//
//  Created by Quy on 7/1/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCSAboutAppViewController.h"

@interface QKCSAboutAppViewController ()

@end

@implementation QKCSAboutAppViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setAngleLeftBarButton];
    self.navigationItem.title = NSLocalizedString(@"このアプリについて", nil);
    [self configView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configView {
    // Config TextView
    
    [self.textView setEditable:NO];
    [self.textView setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    
    [self.textView setTextColor:[UIColor colorWithHexString:@"#444"]];
    [self.textView setFont:[UIFont systemFontOfSize:14.0]];
    self.textView.backgroundColor = kQKColorBG;
    // Config Image
    self.iconImageView.backgroundColor = [UIColor colorWithRed:217.0 / 255.0 green:217.0 / 255.0 blue:217.0 / 255.0 alpha:1];
    self.iconImageView.layer.cornerRadius = 12.0;
}

@end

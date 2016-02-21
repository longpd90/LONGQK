//
//  QKWorkConditionViewController.m
//  quicker-cl-ios
//
//  Created by Quy on 6/1/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLWorkConditionViewController.h"

@interface QKCLWorkConditionViewController ()

@end

@implementation QKCLWorkConditionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"労働条件通知書", nil);
    [self setAngleLeftBarButton];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)checkBrowser:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringFromConst:qkCLUrlWebMypageWorkingConditionns]]];
}

@end

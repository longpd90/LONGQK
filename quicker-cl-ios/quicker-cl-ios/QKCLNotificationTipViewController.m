//
//  QKNotificationTipViewController.m
//  quicker-cl-ios
//
//  Created by Viet on 5/18/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLNotificationTipViewController.h"

@interface QKCLNotificationTipViewController ()

@end

@implementation QKCLNotificationTipViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithRed:53.0 / 255.0 green:58.0 / 255.0 blue:69.0 / 255.0 alpha:1.0]];
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

#pragma mark -IBActions
- (IBAction)closeClicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end

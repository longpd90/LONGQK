//
//  QKStopViewController.m
//  quicker-cl-ios
//
//  Created by Vietnd on 6/13/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCSStopViewController.h"

@interface QKCSStopViewController ()

@end

@implementation QKCSStopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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

- (IBAction)callCenterButtonClicked:(QKGlobalButton *)sender {
    CCAlertView *numberAlert = [[CCAlertView alloc] initWithTitle:@"Do you want to call center?" message:[NSString stringFromConst:kQKCenterPhoneNum] delegate:self buttonTitles:@[@"NO", @"YES"]];
    numberAlert.delegate = self;
    numberAlert.tag = 20;
    [numberAlert showAlert];
}

- (void)alertView:(CCAlertView *)alertView selectedButtonIndex:(NSInteger)index {
    if (alertView.tag == 20) {
        if (index == 1) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@", [NSString stringFromConst:kQKCenterPhoneNum]]]];
        }
    }
}

- (IBAction)callCenterClicked:(id)sender {
}
@end

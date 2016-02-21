//
//  QKContactUsViewController.m
//  quicker-cl-ios
//
//  Created by Nguyen Huu Anh on 5/6/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLContactUsViewController.h"

@interface QKCLContactUsViewController () <CCAlertViewDelegate>

@end

@implementation QKCLContactUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = NSLocalizedString(@"お問い合わせ", nil);
    [self setAngleLeftBarButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBAction

- (IBAction)contactWithWebForm:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringFromConst:qkCLUrlWebContact]]];
}

- (IBAction)contactWithTel:(id)sender {
    CCAlertView *contactWithTelAlv = [[CCAlertView alloc] initWithTitle:@"コールセンターへ 電話をかけます"
                                                                message:kQKCenterPhoneNum
                                                               delegate:self
                                                           buttonTitles:@[@"キャンセル", @"発信"]];
    [contactWithTelAlv showAlert];
}

#pragma mark - CCAlertViewDelegate

- (void)alertView:(CCAlertView *)alertView selectedButtonIndex:(NSInteger)index {
    if (index == 1) {
        [self callCenter];
    }
}

@end

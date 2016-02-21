//
//  QKCSContactUsViewController.m
//  quicker-cs-ios
//
//  Created by C Anh on 8/11/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCSContactUsViewController.h"

@interface QKCSContactUsViewController ()

@end

@implementation QKCSContactUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setAngleLeftBarButton];
    self.navigationItem.title =NSLocalizedString(@"お問い合わせ", nil);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (IBAction)showOnWebView:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringFromConst:qkCSUrlWebContact]]];
}

- (IBAction)phoneAlert:(id)sender {
    NSString *title = [NSString stringWithFormat:@"%@\n%@",NSLocalizedString(@"コールセンターへ 電話をかけます", nil),kQKCenterPhoneNum];
    CCAlertView *contactWithTelAlv = [[CCAlertView alloc] initWithTitle:title
                                                                message:nil
                                                               delegate:self
                                                           buttonTitles:@[NSLocalizedString(@"やめる", nil),NSLocalizedString(@"発信", nil)]];
    [contactWithTelAlv showAlert];
}
@end

//
//  QKStopViewController.m
//  quicker-cl-ios
//
//  Created by Vietnd on 6/13/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLStopViewController.h"

@interface QKCLStopViewController ()

@end

@implementation QKCLStopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (_state == 1) {
        [self.sildeMenuButtonOutlet setHidden:NO];
        [self.sildeMenuButtonOutlet addTarget:self.revealViewController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
        [self.sildeMenuButtonOutlet addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    switch (_type) {
        case QKTypeAccountClose: {
            _titleLabel.text = [NSString stringWithFormat:@"%@\n%@",NSLocalizedString(@"お客様のアカウントは", nil),NSLocalizedString(@"凍結されました", nil)];
            break;
        }
        case QKTypeShopClose: {
            _titleLabel.text = [NSString stringWithFormat:@"%@\n%@",NSLocalizedString(@"ご利用中の店舗が", nil),NSLocalizedString(@"凍結されました", nil)];
            break;
        }
        default:
            break;
    }
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

- (IBAction)callCenterButtonClicked:(id)sender {
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

@end

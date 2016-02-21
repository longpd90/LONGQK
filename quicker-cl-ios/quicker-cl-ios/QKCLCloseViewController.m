//
//  QKCloseViewController.m
//  quicker-cl-ios
//
//  Created by Vietnd on 6/13/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLCloseViewController.h"

@interface QKCLCloseViewController ()

@end

@implementation QKCLCloseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.state ==1) {
        [self.slideMenuButtonOutlet setHidden:NO];
        [self.slideMenuButtonOutlet addTarget:self.revealViewController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
        [self.slideMenuButtonOutlet addGestureRecognizer:self.revealViewController.panGestureRecognizer];
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

@end

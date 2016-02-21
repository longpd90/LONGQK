//
//  QKCheckJudgeInfoViewController.m
//  quicker-cl-ios
//
//  Created by Nguyen Huu Anh on 4/16/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLShopExaminationDoneViewController.h"
#import "QKCLShopEnterInfoViewController.h"


@interface QKCLShopExaminationDoneViewController ()

@end

@implementation QKCLShopExaminationDoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupInteface];
    self.title = @"申請結果の確認";
    self.navigationItem.hidesBackButton = YES;
}

- (void)setupInteface {
    self.companyNameLabel.text = self.shopInfo.companyName;
    self.shopNameLabel.text = self.shopInfo.name;
    self.shopAddressLabel.text = [self.shopInfo getFullAddressString];
    self.telLabel.text = self.shopInfo.phoneNum;
    self.borderView.layer.borderColor = [[UIColor colorWithHexString:@"#CCCCCC"] CGColor];
    self.borderView.layer.borderWidth = 1.0;
}

- (IBAction)bottomButtonTouched:(id)sender {
    [self performSegueWithIdentifier:@"QKEnterShopInfoSegue" sender:self];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"QKEnterShopInfoSegue"]) {
        QKCLShopEnterInfoViewController *vc = (QKCLShopEnterInfoViewController *)segue.destinationViewController;
        [vc setShopInfo:_shopInfo];
    }
}

@end

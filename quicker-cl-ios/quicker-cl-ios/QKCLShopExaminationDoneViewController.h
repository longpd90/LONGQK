//
//  QKCheckJudgeInfoViewController.h
//  quicker-cl-ios
//
//  Created by Nguyen Huu Anh on 4/16/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLBaseViewController.h"
#import "QKCLShopInfoModel.h"

@interface QKCLShopExaminationDoneViewController : QKCLBaseViewController
@property (weak, nonatomic) IBOutlet UIView *borderView;
@property (weak, nonatomic) IBOutlet QKF20Label *companyNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *checkShopStatusLabel;
@property (weak, nonatomic) IBOutlet QKF20Label *shopNameLabel;
@property (weak, nonatomic) IBOutlet QKF20Label *shopAddressLabel;
@property (weak, nonatomic) IBOutlet QKF20Label *telLabel;
@property (weak, nonatomic) IBOutlet QKGlobalButton *button2;

//param
@property (strong, nonatomic) QKCLShopInfoModel *shopInfo;
@end

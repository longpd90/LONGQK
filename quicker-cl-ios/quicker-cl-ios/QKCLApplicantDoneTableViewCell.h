//
//  QKCLApplicantDoneTableViewCell.h
//  quicker-cl-ios
//
//  Created by Quy on 8/5/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QKF2Label.h"
#import "QKF20Label.h"
#import "QKGlobalButtonPrimary.h"
#import "QKCLAdoptionUserModel.h"
#import "QKImageView.h"
#import "QKCLRecruitmentModel.h"
#import "QKGlobalTextButton.h"

@interface QKCLApplicantDoneTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *narrowImageView;
@property (weak, nonatomic) IBOutlet QKImageView *avartarImageView;
@property (weak, nonatomic) IBOutlet QKF2Label *jobtypeSNameLabel;
@property (weak, nonatomic) IBOutlet QKF20Label *workTimeLabel;
@property (weak, nonatomic) IBOutlet QKGlobalTextButton *cancelButton;
@property (weak, nonatomic) IBOutlet QKGlobalButtonPrimary *paymentButton;
@property (weak, nonatomic) IBOutlet UIView *cancelView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *noPaymentButtonContrainst;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *noPaymentAndCancelButtonConstrainst;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *noCancelButtonConstrainst;


-(void)setData:(QKCLAdoptionUserModel*)adoptUserModel withRecruitment:(QKCLRecruitmentModel*)recruitmentModel;
@end

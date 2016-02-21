//
//  QKRecruitmentDoneTableViewCell.h
//  quicker-cl-ios
//
//  Created by Viet on 6/30/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QKF2Label.h"
#import "QKF20Label.h"
#import "QKF22Label.h"
#import "QKF30Label.h"
#import "QKF42Label.h"
#import "QKCLRecruitmentModel.h"
#import "QKImageView.h"
#import "NSDate+Extra.h"

@interface QKCLRecruitmentListTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *recBackgroundView;
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet QKF22Label *recruitmentStatusNameLabel;
@property (weak, nonatomic) IBOutlet QKF22Label *countDownLabel;
@property (weak, nonatomic) IBOutlet UILabel *recruitmentStatusLabel;

@property (weak, nonatomic) IBOutlet QKF2Label *jobtypeSNameLabel;
@property (weak, nonatomic) IBOutlet QKF20Label *workTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *applicationListCountLabel;
@property (weak, nonatomic) IBOutlet QKF42Label *employmentNumLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *applicantViewConstraint;
@property (weak, nonatomic) IBOutlet QKF42Label *applicantListSizeLabel;
@property (weak, nonatomic) IBOutlet QKImageView *applicantImageView1;
@property (weak, nonatomic) IBOutlet QKImageView *applicantImageView2;
@property (weak, nonatomic) IBOutlet QKImageView *applicantImageView3;
@property (weak, nonatomic) IBOutlet QKImageView *applicantImageView4;
@property (weak, nonatomic) IBOutlet QKImageView *applicantImageView5;
@property (weak, nonatomic) IBOutlet QKImageView *applicantImageView6;
@property (weak, nonatomic) IBOutlet UIView *applicantMoreView;
@property (weak, nonatomic) IBOutlet UILabel *applicantMoreLabel;

@property (strong, nonatomic) QKCLRecruitmentModel *recruitment;
@end

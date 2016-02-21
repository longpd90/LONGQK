//
//  QKCSRecuitmentTimeCell.h
//  quicker-cs-ios
//
//  Created by C Anh on 8/19/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QKF3Label.h"
#import "QKF58Label.h"
#import "QKRecruitmentModel.h"
#import "QKClockCountDownView.h"
#import "QKF41Label.h"
@interface QKCSRecuitmentTimeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomContrain;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightContrainPreCondition;

@property (weak, nonatomic) IBOutlet UIView *completeRecruimentTimeView;
@property (weak, nonatomic) IBOutlet QKF3Label *totalSalaryLabel;
@property (weak, nonatomic) IBOutlet QKF3Label *timeWorkingRecuitmentLabel;
@property (weak, nonatomic) IBOutlet QKF41Label *timeCompleteLabel;
@property (weak, nonatomic) IBOutlet QKF58Label *workStartDateLabel;

@property (weak, nonatomic) IBOutlet UIView *preConditionView;
@property (nonatomic) CGFloat height;
@property (weak, nonatomic) IBOutlet QKClockCountDownView *clockView;
@property (weak, nonatomic) IBOutlet UIImageView *condition1ImageView;
@property (weak, nonatomic) IBOutlet UIImageView *condition2ImageView;
@property (weak, nonatomic) IBOutlet UIView *conditionView;

@property (weak, nonatomic) IBOutlet QKF3Label *jobTypeSLabel;

@property (strong, nonatomic) QKRecruitmentModel *recuitmentModel;
@end

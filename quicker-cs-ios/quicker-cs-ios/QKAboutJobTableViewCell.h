//
//  QKAboutJobTableViewCell.h
//  quicker-cs-ios
//
//  Created by LongPD-PC on 6/11/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QKRecruitmentModel.h"
#import "UIImageView+AFNetworking.h"

@interface QKAboutJobTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomContrain;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightContrainPreCondition;
@property (strong, nonatomic) QKRecruitmentModel *jobEntity;
@property (weak, nonatomic) IBOutlet UILabel *jobNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *jobCatagoryLabel;
@property (weak, nonatomic) IBOutlet UILabel *workStartDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *workingTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *restTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *salaryTotalLabel;
@property (weak, nonatomic) IBOutlet UILabel *salaryPerUnitLabel;
@property (weak, nonatomic) IBOutlet UILabel *transportationExpensesLabel;
@property (weak, nonatomic) IBOutlet UILabel *employmentNuberLabel;
@property (weak, nonatomic) IBOutlet UILabel *baggedsLabel;

@property (weak, nonatomic) IBOutlet UIView *preConditionView;

@property (nonatomic) CGFloat height;

@end

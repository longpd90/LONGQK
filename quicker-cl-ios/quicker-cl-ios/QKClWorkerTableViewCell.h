//
//  QKClWorkerTableViewCell.h
//  quicker-cl-ios
//
//  Created by Quy on 8/3/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QKF20Label.h"
#import "QKF2Label.h"
#import "QKCLRecruitmentModel.h"

@interface QKClWorkerTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet QKF20Label *dayLabel;
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UILabel *leftHeaderLabel;
@property (weak, nonatomic) IBOutlet UILabel *middleHeaderLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightHeaderLabel;
@property (weak, nonatomic) IBOutlet QKF2Label *jobTypeSName;

-(void)setData:(QKCLRecruitmentModel*)recruitment;
@end

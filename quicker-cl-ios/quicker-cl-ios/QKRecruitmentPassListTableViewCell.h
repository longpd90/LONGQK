//
//  QKRecruitmentPassListTableViewCell.h
//  quicker-cl-ios
//
//  Created by Quy on 7/15/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QKF2Label.h"
#import "QKF20Label.h"
#import "QKF42Label.h"
@interface QKRecruitmentPassListTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet QKF2Label *jobttypeSName;
@property (weak, nonatomic) IBOutlet QKF20Label *jobDescription;
@property (weak, nonatomic) IBOutlet QKF42Label *endDate;

@end

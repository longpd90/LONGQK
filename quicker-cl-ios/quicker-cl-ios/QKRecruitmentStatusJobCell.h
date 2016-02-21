//
//  QKRecruitmentStatusJobCell.h
//  quicker-cl-ios
//
//  Created by Nguyen Huu Anh on 7/15/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QKCLRecruitmentModel.h"

@interface QKRecruitmentStatusJobCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *jobNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *adoptionAlreadyLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateTimeJobLabel;
@property (weak, nonatomic) IBOutlet UILabel *remainPeopleLabel;

@property (strong, nonatomic) QKCLRecruitmentModel *recruitmentModel;

@end

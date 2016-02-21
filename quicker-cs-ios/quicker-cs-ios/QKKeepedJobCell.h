//
//  QKKeepedJobCell.h
//  quicker-cs-ios
//
//  Created by Nguyen Huu Anh on 7/13/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QKRecruitmentModel.h"

@interface QKKeepedJobCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *recNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *recCategoryNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *workingTimeLabel;

@property (strong, nonatomic) QKRecruitmentModel *recModel;

@end

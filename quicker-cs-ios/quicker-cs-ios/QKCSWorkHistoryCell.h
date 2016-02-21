//
//  QKCSWorkHistoryCell.h
//  quicker-cs-ios
//
//  Created by C Anh on 8/13/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QKCSWorkHistoryModel.h"
#import "QKF58Label.h"
#import "QKF53Label.h"
#import "QKF33Label.h"
#import "QKF3Label.h"
#import "QKRecruitmentModel.h"
@interface QKCSWorkHistoryCell : UITableViewCell
@property (weak, nonatomic) IBOutlet QKF58Label *serviceLabel;
@property (weak, nonatomic) IBOutlet QKF53Label *tranferDateLAbel;
@property (weak, nonatomic) IBOutlet QKF33Label *addressShopLabel;
@property (weak, nonatomic) IBOutlet QKF3Label  *totalSalary;

@property (strong, nonatomic) QKCSWorkHistoryModel *workHistoryModel;

@property (strong, nonatomic) QKRecruitmentModel *shopModel;

@end

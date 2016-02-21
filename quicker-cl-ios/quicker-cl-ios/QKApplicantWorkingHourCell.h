//
//  QKApplicantWorkingHourCell.h
//  quicker-cl-ios
//
//  Created by Nguyen Huu Anh on 8/13/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QKCLSalaryModel.h"
#import "QKCLCustomerSalaryModel.h"

@interface QKApplicantWorkingHourCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *actualStartDt;
@property (weak, nonatomic) IBOutlet UILabel *actualEndDtLabel;
@property (weak, nonatomic) IBOutlet UILabel *worktimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *recessLabel;

@property (strong, nonatomic) QKCLCustomerSalaryModel *customerSalaryModel;
@end

//
//  QKApplicantAmountPaidCell.h
//  quicker-cl-ios
//
//  Created by Nguyen Huu Anh on 8/13/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QKCLSalaryModel.h"
#import "QKCLCustomerSalaryModel.h"

@interface QKApplicantAmountPaidCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *basicSalaryLabel;
@property (weak, nonatomic) IBOutlet UILabel *overtimeAllowanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *transportationExpensesLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalAmountLabel;

@property (strong, nonatomic) QKCLCustomerSalaryModel *customerSalaryModel;

@end

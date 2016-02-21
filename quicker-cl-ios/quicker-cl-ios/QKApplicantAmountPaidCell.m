//
//  QKApplicantAmountPaidCell.m
//  quicker-cl-ios
//
//  Created by Nguyen Huu Anh on 8/13/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKApplicantAmountPaidCell.h"

@implementation QKApplicantAmountPaidCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setCustomerSalaryModel:(QKCLCustomerSalaryModel *)customerSalaryModel {
    _customerSalaryModel = customerSalaryModel;
    self.basicSalaryLabel.text = [NSString stringWithFormat:@"%d円", customerSalaryModel.basicSalary];
    self.overtimeAllowanceLabel.text = [NSString stringWithFormat:@"%d円", customerSalaryModel.actualOvertimeAllowance + customerSalaryModel.actualNighttimeAllowance];
    self.transportationExpensesLabel.text = [NSString stringWithFormat:@"%d円", customerSalaryModel.actualTransportationExpenses];
    NSInteger total = customerSalaryModel.basicSalary + customerSalaryModel.actualOvertimeAllowance + customerSalaryModel.actualNighttimeAllowance + customerSalaryModel.actualTransportationExpenses;
    self.transportationExpensesLabel.text = [NSString stringWithFormat:@"%d円", total];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end

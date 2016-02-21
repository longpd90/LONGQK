//
//  QKCLSalaryOptionTableViewCell.m
//  quicker-cl-ios
//
//  Created by VietND on 8/26/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLSalaryOptionTableViewCell.h"
#import "QKCLConst.h"

@implementation QKCLSalaryOptionTableViewCell
-(void)setData:(QKCLOptionalItemModel*)item {
    self.itemNameTextField.text = item.itemsName;
    
    if ([item.payStatementStatus isEqualToString:[NSString stringFromConst:QK_PAYMENT_STATUS_DEDUCT]]) {
        [self.signSwitch setOn:YES];
        self.itemValueTextField.text = [NSString stringWithFormat:@"-%ld",(long)item.amount];
    }else{
        [self.signSwitch setOn:NO];
        self.itemValueTextField.text = [NSString stringWithFormat:@"%ld",(long)item.amount];
    }
}
@end

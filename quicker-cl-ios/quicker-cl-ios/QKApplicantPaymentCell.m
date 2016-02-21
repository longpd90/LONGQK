//
//  QKApplicantPaymentCell.m
//  quicker-cl-ios
//
//  Created by Nguyen Huu Anh on 8/13/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKApplicantPaymentCell.h"
#import "QKCLOptionalItemModel.h"
#import "QKF20Label.h"
#import "QKF12Label.h"
#import "QKCLConst.h"
#import "chiase-ios-core/NSString+Extra.h"

@implementation QKApplicantPaymentCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setCustomerSalaryModel:(QKCLCustomerSalaryModel *)customerSalaryModel {
    _customerSalaryModel = customerSalaryModel;
    self.withholdingLabel.text = [NSString stringWithFormat:@"%ld円", (long)customerSalaryModel.actualWithholding];
            self.payAmount.text = [NSString stringWithFormat:@"%ld円", (long)customerSalaryModel.totalAmountPaid];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    float y = 0;
    for (QKCLOptionalItemModel *optionItem in _customerSalaryModel.optionalItemList) {
        QKF20Label *itemNameLb = [[QKF20Label alloc] initWithFrame:CGRectMake(0, y, 90.0, 20)];
        itemNameLb.text = optionItem.itemsName;
        float x = CGRectGetWidth(self.optionItemsView.frame) - 80.0;
        QKF12Label *amountLabel = [[QKF12Label alloc] initWithFrame:CGRectMake(x, y, 80.0, 20.0)];
        [amountLabel setTextAlignment:NSTextAlignmentRight];
        NSString *paymentStatusString = @"";
        if ([optionItem.payStatementStatus isEqualToString:[NSString stringFromConst:QK_PAYMENT_STATUS_DEDUCT]]) {
            paymentStatusString = @"-";
        }
        amountLabel.text = [NSString stringWithFormat:@"%@%d円", paymentStatusString, optionItem.amount];
        [self.optionItemsView addSubview:itemNameLb];
        [self.optionItemsView addSubview:amountLabel];
        y += 30;
        
    }
    self.heightOptionItemsContraint.constant = y;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end

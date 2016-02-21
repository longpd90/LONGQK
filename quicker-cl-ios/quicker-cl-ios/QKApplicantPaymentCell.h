//
//  QKApplicantPaymentCell.h
//  quicker-cl-ios
//
//  Created by Nguyen Huu Anh on 8/13/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QKCLSalaryModel.h"
#import "QKCLCustomerSalaryModel.h"

@interface QKApplicantPaymentCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *withholdingLabel;
@property (weak, nonatomic) IBOutlet UILabel *payAmount;
@property (weak, nonatomic) IBOutlet UIView *optionItemsView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightOptionItemsContraint;

@property (strong, nonatomic) QKCLCustomerSalaryModel *customerSalaryModel;

@end

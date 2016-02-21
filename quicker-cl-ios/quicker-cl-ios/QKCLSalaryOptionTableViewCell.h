//
//  QKCLSalaryOptionTableViewCell.h
//  quicker-cl-ios
//
//  Created by VietND on 8/26/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QKGlobalNoBorderTextField.h"
#import "QKCLSwitch.h"
#import "QKCLOptionalItemModel.h"

@interface QKCLSalaryOptionTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet QKGlobalNoBorderTextField *itemNameTextField;
@property (weak, nonatomic) IBOutlet QKGlobalNoBorderTextField *itemValueTextField;
@property (weak, nonatomic) IBOutlet QKCLSwitch *signSwitch;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;

-(void)setData:(QKCLOptionalItemModel*)item;
@end

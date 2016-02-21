//
//  QKChoosePaymentMethodViewController.h
//  quicker-cl-ios
//
//  Created by Nguyen Huu Anh on 4/21/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLBaseViewController.h"


@interface QKCLChoosePaymentMethodViewController : QKCLBaseViewController
- (IBAction)paymentCardClicked:(id)sender;
- (IBAction)paymentBankClicked:(id)sender;

@property (weak, nonatomic) IBOutlet QKF42Label *hintLabel;
//param
@property (nonatomic) QKPaymentSettingMode mode;
@property (strong,nonatomic) NSString* shopId;
@end

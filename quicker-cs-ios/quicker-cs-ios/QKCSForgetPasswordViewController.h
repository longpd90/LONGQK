//
//  QKForgetPasswordViewController.h
//  quicker-cs-ios
//
//  Created by LongPD-PC on 5/7/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCSBaseViewController.h"

@interface QKCSForgetPasswordViewController : QKCSBaseViewController
@property (weak, nonatomic) IBOutlet UILabel *mailAddressFailLabel;
@property (weak, nonatomic) IBOutlet QKGlobalButton *sendMailButton;
@property (weak, nonatomic) IBOutlet QKGlobalTextField *mailAddressTextField;

- (IBAction)sendMailLogin:(id)sender;
- (IBAction)edittingChanged:(id)sender;

@end

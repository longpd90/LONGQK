//
//  QKRegisterAccAuthCodeViewController.h
//  quicker-cl-ios
//
//  Created by Viet on 4/16/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLBaseViewController.h"
#import "QKCLSignUpModel.h"

@interface QKCLConfirmAccountViewController : QKCLBaseViewController
@property (weak, nonatomic) IBOutlet QKGlobalTextField *confirmCodeTextField;
@property (weak, nonatomic) IBOutlet UILabel *errorConfirmLabel;

- (IBAction)confirmCodeClicked:(id)sender;
- (IBAction)resendConfirmCodeClicked:(id)sender;
@property (weak, nonatomic) IBOutlet QKGlobalButton *confirmCodeOutLet;


//param
@property (strong, nonatomic) QKCLSignUpModel *signupModel;
@end

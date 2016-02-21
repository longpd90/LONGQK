//
//  QKSigninViewController.h
//  quicker-cl-ios
//
//  Created by Viet on 6/4/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLBaseViewController.h"

@interface QKCLSigninViewController : QKCLBaseViewController
@property (weak, nonatomic) IBOutlet QKGlobalTextField *emailTextField;
@property (weak, nonatomic) IBOutlet QKGlobalTextField *passwordTextField;
@property (weak, nonatomic) IBOutlet QKGlobalButton *signinButton;
@property (weak, nonatomic) IBOutlet UILabel *errorLabel;
@property (weak, nonatomic) IBOutlet QKGlobalTextButton *forgetPassButton;


- (IBAction)signinClicked:(id)sender;
- (IBAction)valueChanged:(id)sender;
- (IBAction)forgetPassButtonClicked:(id)sender;

@end

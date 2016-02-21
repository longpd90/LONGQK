//
//  QKSignupViewController.h
//  quicker-cl-ios
//
//  Created by Viet on 6/4/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLBaseViewController.h"

@interface QKCLSignupViewController : QKCLBaseViewController
@property (weak, nonatomic) IBOutlet QKGlobalTextField *firstNameTextField;
@property (weak, nonatomic) IBOutlet QKGlobalTextField *lastNameTextField;
@property (weak, nonatomic) IBOutlet QKGlobalTextField *firstNameKanaTextField;
@property (weak, nonatomic) IBOutlet QKGlobalTextField *lastNameKanaTextField;
@property (weak, nonatomic) IBOutlet QKGlobalTextField *emailTextField;
@property (weak, nonatomic) IBOutlet QKGlobalTextField *passwordTextField;
@property (weak, nonatomic) IBOutlet QKGlobalButton *signupButton;

- (IBAction)termOfUseClicked:(id)sender;
- (IBAction)policyClicked:(id)sender;
- (IBAction)signupClicked:(id)sender;
- (IBAction)valueChanged:(id)sender;


@end

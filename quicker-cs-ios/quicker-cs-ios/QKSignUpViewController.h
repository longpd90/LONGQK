//
//  QKSignUpViewController.h
//  quicker-cs-ios
//
//  Created by LongPD-PC on 4/29/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCSBaseViewController.h"
typedef enum {
	QKAlertViewModeLogoutSuccess = 0,
	QKAlertViewModeSignup
} QKAlertViewMode;
typedef enum {
	QKSignupModeNormal = 0,
	QKSignupModeFacebook
} QKSignupMode;

@interface QKSignUpViewController : QKCSBaseViewController

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic)QKAlertViewMode signUpmode;

@property (weak, nonatomic) IBOutlet QKGlobalTextField *emailTextField;
@property (weak, nonatomic) IBOutlet QKGlobalTextField *passwordTextField;
@property (weak, nonatomic) IBOutlet QKGlobalPrimaryButton *signUpButton;
@property (weak, nonatomic) IBOutlet QKGlobalSecondaryButton *signupByFacebook;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;


- (IBAction)signupButtonClicked:(id)sender;
- (IBAction)facebookLoginButtonClicked:(id)sender;
- (IBAction)termOfUseClicked:(id)sender;
- (IBAction)policyClicked:(id)sender;
- (IBAction)editingChanged:(id)sender;

@end

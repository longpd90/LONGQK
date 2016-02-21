//
//  QKLoginViewController.h
//  quicker-cs-ios
//
//  Created by LongPD-PC on 5/7/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCSBaseViewController.h"

typedef enum {
    QKSigninModeNormal = 0,
    QKSigninModeFacebook
} QKSigninMode;


@interface QKCSSigninViewController : QKCSBaseViewController
@property (weak, nonatomic) IBOutlet QKGlobalTextField *addressMailTexfield;
@property (weak, nonatomic) IBOutlet QKGlobalTextButton *forgetPassWordButton;
@property (weak, nonatomic) IBOutlet QKGlobalTextField *passwordTextField;
@property (weak, nonatomic) IBOutlet QkF59Label *loginFailLabel;
@property (weak, nonatomic) IBOutlet QKGlobalPrimaryButton *signinButton;
@property (weak, nonatomic) IBOutlet UIButton *termOfUseButton;
@property (weak, nonatomic) IBOutlet UIButton *privacyPolicyButton;


- (IBAction)loginButtonClicked:(id)sender;
- (IBAction)registNewAccount:(id)sender;
- (IBAction)facebookLoginButton:(id)sender;
@property (weak, nonatomic) IBOutlet QKGlobalSecondaryButton *facebookLoginOutletButton;
- (IBAction)termOfUseClicked:(id)sender;
- (IBAction)policyClicked:(id)sender;
- (IBAction)edittingChanged:(id)sender;

@end

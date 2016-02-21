//
//  QKSignupViewController.m
//  quicker-cl-ios
//
//  Created by Viet on 6/4/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLSignupViewController.h"
#import "QKCLViewController.h"
#import "QKCLSignUpModel.h"

@interface QKCLSignupViewController () <UITextFieldDelegate>

@end

@implementation QKCLSignupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_signupButton setEnabled:NO];
    
    //set keyboard
    [_firstNameTextField setInputMode:InputModeJapanse];
    [_lastNameTextField setInputMode:InputModeJapanse];
    [_firstNameKanaTextField setInputMode:InputModeJapanse];
    [_lastNameKanaTextField setInputMode:InputModeJapanse];
    [_emailTextField setInputMode:InputModeEnglish];
    [_passwordTextField setInputMode:InputModeEnglish];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (IBAction)termOfUseClicked:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.yahoo.com"]];
}

- (IBAction)policyClicked:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.yahoo.com"]];
}
us
- (IBAction)signupClicked:(id)sender {
    //call api to request code
    NSLog(@"Sign up...");
    if ([self connected]) {
        NSMutableDictionary *params = [NSMutableDictionary initWithApiKey];
        [params setValue:_firstNameTextField.text forKey:@"firstName"];
        [params setValue:_lastNameTextField.text forKey:@"lastName"];
        [params setValue:_firstNameKanaTextField.text forKey:@"firstNameKana"];
        [params setValue:_lastNameKanaTextField.text forKey:@"lastNameKana"];
        [params setValue:_emailTextField.text forKey:@"email"];
        [params setValue:[QKCLEncryptUtil encyptBlowfish:_passwordTextField.text] forKey:@"password"];
        NSDictionary *response;
        NSError *error;
        BOOL result =  [[QKCLRequestManager sharedManager] syncPOST:[NSString stringFromConst:qkUrlAccountRegist] parameters:params response:&response error:&error showLoading:YES showError:YES];
        
        if (result) {
            NSLog(@"Sign up successful...");
            
            QKCLSignUpModel *signupModel = [[QKCLSignUpModel alloc]init];
            [signupModel setFirstName:_firstNameTextField.text];
            [signupModel setLastName:_lastNameTextField.text];
            [signupModel setFirstNameKana:_firstNameKanaTextField.text];
            [signupModel setLastNameKana:_lastNameKanaTextField.text];
            [signupModel setEmail:_emailTextField.text];
            signupModel.password = [QKCLEncryptUtil encyptBlowfish:_passwordTextField.text];
            
            QKCLViewController *parentViewController = (QKCLViewController *)self.parentViewController;
            parentViewController.signupModel = signupModel;
            [self.parentViewController performSegueWithIdentifier:@"QKConfirmCdSeque" sender:self.parentViewController];
        }
    }
    else {
        [self showNoInternetViewWithSelector:nil];
    }
}

- (IBAction)valueChanged:(id)sender {
    if (![_firstNameTextField.text isEqualToString:@""] && ![_lastNameTextField.text isEqualToString:@""] && ![_firstNameKanaTextField.text isEqualToString:@""] && ![_lastNameKanaTextField.text isEqualToString:@""] && ![_emailTextField.text isEqualToString:@""] && ![_passwordTextField.text isEqualToString:@""]) {
        [_signupButton setEnabled:YES];
    }
    else {
        [_signupButton setEnabled:NO];
    }
}

#pragma mark -UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == _lastNameTextField) {
        [_lastNameTextField becomeFirstResponder];
    }
    else if (textField == _firstNameTextField) {
        [_lastNameKanaTextField becomeFirstResponder];
    }
    else if (textField == _lastNameKanaTextField) {
        [_firstNameKanaTextField becomeFirstResponder];
    }
    else if (textField == _firstNameKanaTextField) {
        [_emailTextField becomeFirstResponder];
    }
    else if (textField == _emailTextField) {
        [_passwordTextField becomeFirstResponder];
    }
    else if (textField == _passwordTextField) {
        [_passwordTextField resignFirstResponder];
    }
    return YES;
}

#pragma mark -Actions
- (void)setDefaults:(NSDictionary *)response {
    [QKCLAccessUserDefaults setUserId:[response valueForKey:@"userId"]];
    [QKCLAccessUserDefaults setMail:_emailTextField.text];
    [QKCLAccessUserDefaults setToken:[response valueForKey:@"accessToken"]];
    [QKCLAccessUserDefaults setExpireDate:[response valueForKey:@"expireDt"]];
    [QKCLAccessUserDefaults setPusnaDeviceId:[response valueForKey:@"pusnaDeviceId"]];
}

@end

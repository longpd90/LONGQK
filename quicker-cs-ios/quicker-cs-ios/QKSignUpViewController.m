//
//  QKSignUpViewController.m
//  quicker-cs-ios
//
//  Created by LongPD-PC on 4/29/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKSignUpViewController.h"
#import "AppDelegate.h"
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import "QKCreatProfileViewController.h"
#import "QKCSWebViewController.h"

@interface QKSignUpViewController ()

@end

@implementation QKSignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //layout
    _signupByFacebook.backgroundColor = [UIColor colorWithHexString:@"#425D9E"];
    
    //set keyboard
    [_emailTextField setInputMode:InputModeEnglish];
    [_passwordTextField setInputMode:InputModeEnglish];
    [self checkSignupButtonEnabled];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    
    //check logout
    if (![[QKAccessUserDefaults get:kQKNeedShowLogoutAlertKey] isEqualToString:@""] || [[QKAccessUserDefaults get:@"QKAccessTokenInvalidKey"] isEqualToString:@"1"] || [[QKAccessUserDefaults get:kQKShowWithdrawAlertKey]isEqualToString:@"1"]) {
        [QKAccessUserDefaults put:@"QKAccessTokenInvalidKey" withValue:@""];
        [self performSegueWithIdentifier:@"QKShowSigninSegue" sender:self];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [_scrollView setContentSize:CGSizeMake(0, _scrollView.contentSize.height)];
    _scrollView.scrollEnabled = NO;
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}

#pragma mark - action

- (IBAction)signupButtonClicked:(id)sender {
    [self.view endEditing:YES];
    //call api
    [self signUpWithInfo:QKSignupModeNormal];
}

- (void)signUpWithInfo:(QKSignupMode)mode {
    NSString *url;
    NSMutableDictionary *params = [NSMutableDictionary initWithApiKey];
    switch (mode) {
        case QKSignupModeNormal:
        {
            [QKAccessUserDefaults setPassword:_passwordTextField.text];
            [params setValue:_emailTextField.text forKey:@"email"];
            [params setValue:[QKEncryptUtil encyptBlowfish:_passwordTextField.text] forKey:@"password"];
            url = [NSString stringFromConst:qkCSUrlAccountRegist];
            break;
        }
            
        case QKSignupModeFacebook:
        {
            [params setValue:[QKAccessUserDefaults getFBAccessToken] forKey:kQKFbAccessTokenKey];
            url = [NSString stringFromConst:qkCSUrlAccountFacebookRegist];
            break;
        }
    }
    
    NSDictionary *response;
    NSError *error;
    BOOL result =  [[QKRequestManager sharedManager] syncPOST:url parameters:params response:&response error:&error showLoading:YES showError:YES];
    
    if (result) {
        [self setDefaults:response];
        CCAlertView *signupAlertView = [[CCAlertView alloc] initWithImage:[UIImage imageNamed:@"dialog_pic_done"] title:@"アカウント登録が完了しました" message:nil delegate:self buttonTitles:@[@"次へ"]];
        signupAlertView.tag = QKAlertViewModeSignup;
        [signupAlertView showAlert];
    }
}

- (IBAction)facebookLoginButtonClicked:(id)sender {
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    [login logInWithReadPermissions:@[] handler: ^(FBSDKLoginManagerLoginResult *result, NSError *error) {
        if (error) {
            // Process error
            NSLog(@"Facebook error...");
        }
        else if (result.isCancelled) {
            // Handle cancellations
            NSLog(@"Facebook cancelled...");
        }
        else {
            // If you ask for multiple permissions at once, you
            // should check if specific permissions missing
            NSLog(@"Facebook success...");
            [QKAccessUserDefaults setFBAccessToken:[FBSDKAccessToken currentAccessToken].tokenString];
            NSLog(@"%@", [QKAccessUserDefaults getFBAccessToken]);
            [QKAccessUserDefaults setAuthTime:[[NSDate date] stringValueFormattedBy:@"yyyy/MM/dd HH:mm:ss"]];
            [self signUpWithInfo:QKSignupModeFacebook];
        }
    }];
}

- (IBAction)policyClicked:(id)sender {
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    QKCSWebViewController *webViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"QKWebViewController"];
    webViewController.title = NSLocalizedString(@"プライバシーポリシー", nil);
    webViewController.stringURL = [NSString stringFromConst:qkCSUrlWebCopyright];
    [self.navigationController pushViewController:webViewController animated:YES];
}
- (IBAction)termOfUseClicked:(id)sender {
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    QKCSWebViewController *webViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"QKWebViewController"];
    webViewController.title = NSLocalizedString(@"利用規約", nil);
    webViewController.stringURL = [NSString stringFromConst:qkCSUrlWebAgreement];
    [self.navigationController pushViewController:webViewController animated:YES];
}

- (IBAction)editingChanged:(id)sender {
    [self checkSignupButtonEnabled];
}

- (void)checkSignupButtonEnabled {
    BOOL enabled = YES;
    if ([_emailTextField.text isEqualToString:@""]) {
        enabled = NO;
    }
    if ([_passwordTextField.text isEqualToString:@""]) {
        enabled = NO;
    }
    [_signUpButton setEnabled:enabled];
}

- (void)setDefaults:(NSDictionary *)response {
    [QKAccessUserDefaults setMail:response[@"email"]];
    [QKAccessUserDefaults setUserId:[response valueForKey:@"userId"]];
    [QKAccessUserDefaults setToken:[response valueForKey:@"accessToken"]];
    [QKAccessUserDefaults setExpireDate:[response valueForKey:@"expireDt"]];
}

#pragma mark - CCAlertViewDelegate

- (void)alertView:(CCAlertView *)alertView selectedButtonIndex:(NSInteger)index {
    if (alertView.tag == QKAlertViewModeSignup) {
        [self performSegueWithIdentifier:@"QKAddProfileSegue" sender:self];
    }
}

@end

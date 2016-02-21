//
//  QKLoginViewController.m
//  quicker-cs-ios
//
//  Created by LongPD-PC on 5/7/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCSSigninViewController.h"
#import "QKSignUpViewController.h"
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import "AppDelegate.h"
#import "QKCSWebViewController.h"
@interface QKCSSigninViewController ()

@end

@implementation QKCSSigninViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupContentView];
    
    [_addressMailTexfield setInputMode:InputModeEnglish];
    [_passwordTextField setInputMode:InputModeEnglish];
    [self checkSigninButtonEnabled];
    
    [self configTextButton];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self showLogoutSuccess];
}

- (void)setupContentView {
    [self setLeftBarButtonWithTitle:@"キャンセル" target:@selector(dissmissView)];
    _facebookLoginOutletButton.backgroundColor = [UIColor colorWithHexString:@"#425D9E"];
}

- (void)configTextButton {
    self.termOfUseButton.titleLabel.font = [UIFont boldSystemFontOfSize:10.0];
    self.termOfUseButton.titleLabel.textColor = [UIColor colorWithHexString:@"#4F5868"];
    
    self.privacyPolicyButton.titleLabel.textColor = [UIColor colorWithHexString:@"#444"];
    self.privacyPolicyButton.titleLabel.font = [UIFont systemFontOfSize:10.0];
}

#pragma mark - show alert view

- (void)showLogoutSuccess {
    if ([[QKAccessUserDefaults get:kQKNeedShowLogoutAlertKey] isEqualToString:kQKNeedShowLogoutAlert]) {
        [QKAccessUserDefaults put:kQKNeedShowLogoutAlertKey withValue:@""];
        CCAlertView *logoutSuccess = [[CCAlertView alloc] initWithImage:[UIImage imageNamed:@"dialog_pic_done"] title:@"ログアウトしました" andMessage:nil style:QKAlertViewStyleWhite];
        [logoutSuccess showAlert];
    }
    if ([[QKAccessUserDefaults get:kQKShowWithdrawAlertKey]isEqualToString:@"1"]) {
        [QKAccessUserDefaults put:kQKShowWithdrawAlertKey withValue:@""];
        CCAlertView *logoutSuccess = [[CCAlertView alloc] initWithImage:[UIImage imageNamed:@"dialog_pic_done"] title:@"アカウントを削除しました" andMessage:nil style:QKAlertViewStyleWhite];
        [logoutSuccess showAlert];
    }
}

#pragma mark - action

- (IBAction)loginButtonClicked:(id)sender {
    if ([_addressMailTexfield.text length] == 0) {
        UIAlertView *signinFail = [[UIAlertView alloc] initWithTitle:@"user name or password empty" message:nil delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [signinFail show];
    }
    else {
        [self signinWithInfo:QKSigninModeNormal];
    }
    [self.view endEditing:YES];
}

- (IBAction)facebookLoginButton:(id)sender {
    [self signinWithInfo:QKSigninModeFacebook];
}

- (void)signinWithInfo:(QKSigninMode)mode {
    NSString *url;
    NSMutableDictionary *params = [NSMutableDictionary initWithApiKey];
    switch (mode) {
        case QKSigninModeNormal:
        {
            [QKAccessUserDefaults setPassword:_passwordTextField.text];
            [params setValue:_addressMailTexfield.text forKey:@"email"];
            [params setValue:[QKEncryptUtil encyptBlowfish:_passwordTextField.text] forKey:@"password"];
            url = [NSString stringFromConst:qkCSUrlAccountLogin];
            break;
        }
            
        case QKSignupModeFacebook:
        {
            [params setValue:[QKAccessUserDefaults getFBAccessToken] forKey:kQKFbAccessTokenKey];
            url = [NSString stringFromConst:qkCSUrlAccountFacebookLogin];
            break;
        }
    }
    
    NSDictionary *response;
    NSError *error;
    BOOL result =  [[QKRequestManager sharedManager] syncPOST:url parameters:params response:&response error:&error showLoading:YES showError:NO];
    
    if (result) {
        [self setDefaults:response];
        _loginFailLabel.hidden = YES;
        
        [QKAccessUserDefaults put:kQKNeedShowLoginAlertKey withValue:kQKNeedShowLoginAlert];
        
        UIViewController *mainMenuNavigationViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"QKNavigationMainMenuViewController"];
        [[UIApplication sharedApplication] keyWindow].rootViewController = mainMenuNavigationViewController;
        [[[UIApplication sharedApplication] keyWindow] makeKeyAndVisible];
    }
    else {
        NSArray *statusArrays = [NSArray arrayWithObjects:QK_STT_CODE_NEW_VERSION, QK_STT_CODE_ACCOUNT_STOP, QK_STT_CODE_ACCOUNT_CLOSED, nil];
        if ([statusArrays containsObject:response[QK_API_STATUS_CODE]]) {
            AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
            [appDelegate moveToScreen:response[QK_API_STATUS_CODE]];
        }
        else {
            //login fail
            _loginFailLabel.hidden = NO;
            _loginFailLabel.text = response[@"msg"];
        }
    }
}

- (IBAction)registNewAccount:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)checkSigninButtonEnabled {
    BOOL enabled = YES;
    if ([_addressMailTexfield.text isEqualToString:@""]) {
        enabled = NO;
    }
    if ([_passwordTextField.text isEqualToString:@""]) {
        enabled = NO;
    }
    [_signinButton setEnabled:enabled];
}

- (void)setDefaults:(NSDictionary *)response {
    [QKAccessUserDefaults setUserId:[response valueForKey:@"userId"]];
    [QKAccessUserDefaults setMail:_addressMailTexfield.text];
    [QKAccessUserDefaults setToken:[response valueForKey:@"accessToken"]];
    [QKAccessUserDefaults setExpireDate:[response valueForKey:@"expireDt"]];
}

- (IBAction)termOfUseClicked:(id)sender {
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    QKCSWebViewController *webViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"QKWebViewController"];
    webViewController.title = NSLocalizedString(@"利用規約", nil);
    webViewController.stringURL = [NSString stringFromConst:qkCSUrlWebAgreement];
    [self.navigationController pushViewController:webViewController animated:YES];
}

- (IBAction)policyClicked:(id)sender {
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    QKCSWebViewController *webViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"QKWebViewController"];
    webViewController.title = NSLocalizedString(@"プライバシーポリシー", nil);
    webViewController.stringURL = [NSString stringFromConst:qkCSUrlWebCopyright];
    [self.navigationController pushViewController:webViewController animated:YES];
}

- (IBAction)edittingChanged:(id)sender {
    [self checkSigninButtonEnabled];
}

@end

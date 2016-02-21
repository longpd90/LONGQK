//
//  QKViewController.m
//  quicker-cl-ios
//
//  Created by Viet on 6/4/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLViewController.h"
#import "IQKeyboardManager.h"
#import "QKCLWebViewController.h"
#import "QKCLConfirmAccountViewController.h"

@interface QKCLViewController () <CCAlertViewDelegate>

@end

@implementation QKCLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self checkShowAlertView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:NO];
    
    if (_isSignUp) {
        [self showSignUp];
    }
    else {
        [self showSignin];
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.destinationViewController isKindOfClass:[QKCLWebViewController class]]) {
        QKCLWebViewController *webVC = (QKCLWebViewController *)segue.destinationViewController;
        if ([segue.identifier isEqualToString:@"QKForgetPasswordSeque"]) {
            [webVC setStringURL:@"http://yahoo.co.jp"];
        }
    }
    //confirm code
    if ([segue.identifier isEqualToString:@"QKConfirmCdSeque"]) {
        QKCLConfirmAccountViewController *vc = (QKCLConfirmAccountViewController *)segue.destinationViewController;
        [vc setSignupModel:_signupModel];
    }
}

- (IBAction)signupButtonSelected:(id)sender {
    [self showSignUp];
}

- (IBAction)signinButtonSelected:(id)sender {
    [self showSignin];
}

#pragma mark - Actions
- (void)showSignUp {
    self.signupContainer.hidden = NO;
    self.signupArrow.hidden = NO;
    self.signinArrow.hidden = YES;
    self.signinContainer.hidden = YES;
    //    self.signinButton.backgroundColor = kQKColorBtnPrimary;
    //    self.signupButton.backgroundColor = kQKColorBG;
    //    [self.signinButton setTintColor:[UIColor colorWithRed:255.0 / 255.0 green:255.0 / 255.0 blue:255.0 / 255.0 alpha:1]];
    //    [self.signupButton setTintColor:[UIColor colorWithRed:79.0 / 255.0 green:88.0 / 255.0 blue:104.0 / 255.0 alpha:1]];
}

- (void)showSignin {
    self.signupContainer.hidden = YES;
    self.signupArrow.hidden = YES;
    self.signinArrow.hidden = NO;
    self.signinContainer.hidden = NO;
    //    self.signupButton.backgroundColor = kQKColorBtnPrimary;
    //    self.signinButton.backgroundColor = kQKColorBG;
    //    [self.signupButton setTintColor:[UIColor colorWithRed:255.0 / 255.0 green:255.0 / 255.0 blue:255.0 / 255.0 alpha:1]];
    //    [self.signinButton setTintColor:[UIColor colorWithRed:79.0 / 255.0 green:88.0 / 255.0 blue:104.0 / 255.0 alpha:1]];
}

- (void)checkShowAlertView {
    if ([[CCAccessUserDefaults get:@"QKNeedShowWithDrawAlert"] isEqualToString:@"1"]) {
        CCAlertView *withDrawAlv = [[CCAlertView alloc] initWithImage:[UIImage imageNamed:@"dialog_pic_done"] title:@"アカウントを削除しました。" andMessage:nil style:QKAlertViewStyleWhite];
        withDrawAlv.delegate = self;
        [withDrawAlv showAlert];
        [QKCLAccessUserDefaults put:@"QKNeedShowWithDrawAlert" withValue:@"0"];
        return;
    }
    
    if ([[CCAccessUserDefaults get:@"QKNeedShowLogoutAlert"] isEqualToString:@"1"]) {
        CCAlertView *withDrawAlv = [[CCAlertView alloc] initWithImage:[UIImage imageNamed:@"dialog_pic_done"] title:@"ログアウトしました" andMessage:nil style:QKAlertViewStyleWhite];
        withDrawAlv.delegate = self;
        [withDrawAlv showAlert];
        [QKCLAccessUserDefaults put:@"QKNeedShowLogoutAlert" withValue:@"0"];
        
        return;
    }
}

- (void)clickOnAlertView:(CCAlertView *)alertView {
    [[UIApplication sharedApplication] keyWindow].rootViewController = self.navigationController;
}

@end

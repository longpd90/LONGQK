//
//  QKConfirmKeyViewController.m
//  quicker-cs-ios
//
//  Created by LongPD-PC on 5/7/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKConfirmKeyViewController.h"

@interface QKConfirmKeyViewController () <CCAlertViewDelegate>

@end

@implementation QKConfirmKeyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.confirmView.layer.borderWidth = 1.0;
    self.confirmView.layer.borderColor = [UIColor colorWithRed:204.0 / 255.0 green:204.0 / 255.0 blue:204.0 / 255.0 alpha:1].CGColor;
    [self setAngleLeftBarButton];
    _wrongConfirmKeyLabel.text = @"認証番号に誤りがあります。\nSMSをご確認の上再度お試し下さい。";
    [self.confirmButton setEnabled:NO];
    [self.confirmKeyTextField addTarget:self action:@selector(textFieldChange:) forControlEvents:UIControlEventEditingChanged];
    [self.smsLabel setText:@"SMSをご確認の上、以下に入力してください"];
    _timeLimitLabel.text = _timeLimitString;
    [_resendKeyButton setTintColor:[UIColor colorWithHexString:@"#4F5868"]];
    if (_mode == QKConfirmKeyModeEdit) {
        self.satusViewContraintToTop.constant = -50;
        self.backgroundViewContraintToBottom.constant = 50;
        self.bottomView.hidden = YES;
        [self.expiredLabel setHidden:YES];
        self.phoneNumerContraintToTop.constant = -25;
        self.navigationItem.title = NSLocalizedString(@"認証キーを入力", nil);
        self.resendButtonContraintToBottom.constant = 20;
    } else if (_mode == QKConfirmKeyModeRecruitment) {
        self.phoneNumerContraintToTop.constant = -25;
        self.navigationItem.title = NSLocalizedString(@"応募する", nil);
        self.backgroundViewContraintToBottom.constant = 50;
        self.satusViewContraintToTop.constant = -50;
        [self.expiredLabel setHidden:YES];
    } else {
        self.resendButtonContraintToBottom.constant = 20;
        self.navigationItem.title = NSLocalizedString(@"認証番号を入力", nil);
        self.backgroundViewContraintToBottom.constant = 0;
        self.bottomView.hidden = YES;
        [self.smsLabel setText:@"SMSをご確認の上、以下に入力してください。"];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - action

- (void)textFieldChange:(UITextField *)textField {
    if (textField.text.length > 0) {
        [self.confirmButton setEnabled:YES];
    } else {
        [self.confirmButton setEnabled:NO];
    }
}

- (IBAction)resendConfirmKey:(id)sender {
    [self.view endEditing:YES];
    
    if ([self connected]) {
        NSMutableDictionary *params = [NSMutableDictionary initWithApiKeyAndToken];
        [params setValue:[QKAccessUserDefaults getUserId] forKey:@"userId"];
        
        NSDictionary *response;
        NSError *error;
        BOOL result =  [[QKRequestManager sharedManager] syncPOST:[NSString stringFromConst:qkCSUrlSMSAuthSend] parameters:params response:&response error:&error showLoading:YES showError:YES];
        
        if (result) {
            NSLog(@"resend confirm key successful...");
            CCAlertView *resendKeyMessage = [[CCAlertView alloc] initWithImage:[UIImage imageNamed:@"dialog_pic_done"] title:@"認証番号を再送しました" andMessage:nil style:QKAlertViewStyleWhite];
            resendKeyMessage.tag = 0;
            [resendKeyMessage showAlert];
        }
        else {
            NSLog(@"resend confirm key fail...");
        }
    }
    
    else {
        [self showNoInternetViewWithSelector:nil];
    }
}

- (IBAction)confirmButtonClicked:(id)sender {
    [self.view endEditing:YES];
    
    if ([self connected]) {
        NSMutableDictionary *params = [NSMutableDictionary initWithApiKeyAndToken];
        [params setValue:[QKAccessUserDefaults getUserId] forKey:@"userId"];
        [params setValue:_confirmKeyTextField.text forKey:@"authCd"];
        NSDictionary *response;
        NSError *error;
        BOOL result =  [[QKRequestManager sharedManager] syncPOST:[NSString stringFromConst:qkCSUrlSMSAuth] parameters:params response:&response error:&error showLoading:YES showError:NO];
        if (result) {
            _wrongConfirmKeyLabel.hidden = YES;
            CCAlertView *successMessage = [[CCAlertView alloc] initWithImage:[UIImage imageNamed:@"dialog_pic_done"] title:@"認証に成功しました" andMessage:nil style:QKAlertViewStyleWhite];
            successMessage.delegate = self;
            successMessage.tag = 1;
            [successMessage showAlert];
        }
        else {
            _wrongConfirmKeyLabel.hidden = NO;
            //_wrongConfirmKeyLabel.text = response[@"msg"];
        }
    }
    else {
        [self showNoInternetViewWithSelector:nil];
    }
}

#pragma mark - CCAlertView Delegate

- (void)clickOnAlertView:(CCAlertView *)alertView {
    if (alertView.tag == 1) {
        if (self.mode == QKConfirmKeyModeRecruitment || self.mode == QKConfirmKeyModeEdit) {
            NSUInteger ownIndex = [self.navigationController.viewControllers indexOfObject:self];
            [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:ownIndex - 2] animated:YES];
            [[NSNotificationCenter defaultCenter]
             postNotificationName:@"confirmKey"
             object:self];
        }else {
            [self performSegueWithIdentifier:@"showJobHistorySegue" sender:self];
        }
    }
}

@end

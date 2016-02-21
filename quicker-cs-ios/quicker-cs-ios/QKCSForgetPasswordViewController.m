//
//  QKForgetPasswordViewController.m
//  quicker-cs-ios
//
//  Created by LongPD-PC on 5/7/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCSForgetPasswordViewController.h"

@interface QKCSForgetPasswordViewController () <CCAlertViewDelegate>

@end

@implementation QKCSForgetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setAngleLeftBarButton];
    self.navigationItem.title = NSLocalizedString(@"パスワード再設定", nil);
    [self.mailAddressTextField setInputMode:InputModeEnglish];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)sendMailLogin:(id)sender {
    [self.view endEditing:YES];
    
    
    if ([self connected]) {
        NSMutableDictionary *params = [NSMutableDictionary initWithApiKeyAndToken];
        
        [params setObject:_mailAddressTextField.text forKey:@"email"];
        NSDictionary *response;
        NSError *error;
        BOOL result =  [[QKRequestManager sharedManager] syncPOST:[NSString stringFromConst:qkCSUrlAccountPasswordReissue] parameters:params response:&response error:&error showLoading:YES showError:NO];
        
        if (result) {
            CCAlertView *reSendMailAlertView = [[CCAlertView alloc] initWithImage:[UIImage imageNamed:@"dialog_pic_send"] title:@"送信が完了しました" andMessage: [NSString stringWithFormat:@"%@\n%@",@"パスワードを再設定するための",@"手順をお送りしました。"] style:QKAlertViewStyleWhite];
            
            reSendMailAlertView.delegate = self;
            [reSendMailAlertView showAlert];
        }
        else {
            _mailAddressFailLabel.hidden = NO;
            _mailAddressFailLabel.text = response[@"msg"];
            NSLog(@"resend confirm key fail...");
        }
    }
    
    else {
        [self showNoInternetViewWithSelector:nil];
    }
    
}

#pragma mark - CCAlertView Delegate

- (void)clickOnAlertView:(CCAlertView *)alertView {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)edittingChanged:(id)sender {
    [self checkButtonEnabled];
}
-(void)checkButtonEnabled {
    BOOL enabled= YES;
    if ([_mailAddressTextField.text isEqualToString:@""]) {
        enabled=NO;
    }
    [_sendMailButton setEnabled:enabled];
    
}
@end

//
//  QKRegisterAccAuthCodeViewController.m
//  quicker-cl-ios
//
//  Created by Viet on 4/16/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLConfirmAccountViewController.h"
#import "AppDelegate.h"


@interface QKCLConfirmAccountViewController () <CCAlertViewDelegate>
@property (strong, nonatomic) CCAlertView *alertResend;
@property (strong, nonatomic) CCAlertView *alertComplete;
@end

@implementation QKCLConfirmAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:NSLocalizedString(@"確認コードの入力", nil)];
    [self setAngleLeftBarButton];
    [self.confirmCodeOutLet setEnabled:NO];
    
    [self.confirmCodeTextField addTarget:self action:@selector(textChange:)
                        forControlEvents:UIControlEventEditingChanged];
    //set keyboard
    [_confirmCodeTextField setInputMode:InputModeEnglish];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _errorConfirmLabel.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)textChange:(id)sender {
    if (self.confirmCodeTextField.text.length > 0) {
        [self.confirmCodeOutLet setEnabled:YES];
    }
    else {
        [self.confirmCodeOutLet setEnabled:NO];
    }
}

- (void)setDefaults:(NSDictionary *)response {
    [QKCLAccessUserDefaults setUserId:[response valueForKey:@"userId"]];
    [QKCLAccessUserDefaults setToken:[response valueForKey:@"accessToken"]];
    [QKCLAccessUserDefaults setExpireDate:[response valueForKey:@"expireDt"]];
    [QKCLAccessUserDefaults setMail:[response valueForKey:@"email"]];
}

- (IBAction)confirmCodeClicked:(id)sender {
    if ([_confirmCodeTextField.text isEqualToString:@""]) {
        _errorConfirmLabel.hidden = NO;
    }
    else {
        _errorConfirmLabel.hidden = YES;
        NSLog(@"url  = %@", qkUrlAccountRegistComplete);
        
        //call api
        if ([self connected]) {
            NSMutableDictionary *params = [NSMutableDictionary initWithApiKey];
            [params setValue:self.confirmCodeTextField.text forKey:@"confirmCd"];
            
            NSDictionary *response;
            NSError *error;
            BOOL result =  [[QKCLRequestManager sharedManager] syncPOST:[NSString stringFromConst:qkUrlAccountRegistComplete] parameters:params response:&response error:&error showLoading:YES showError:NO];
            
            NSLog(@"Code:%@", response[QK_API_STATUS_CODE]);
            
            if (result) {
                NSLog(@"Confirm successful...");
                [self setDefaults:response];
                
                NSString *title = @"アカウントの作成が\n完了しました";
                NSString *detail = @"作成した情報は「マイぺージ」から\n変更することができます。";
                
                //register from sign up
                _alertComplete = [[CCAlertView alloc] initWithImage:[UIImage imageNamed:@"dialog_pic_done"] title:title message:detail delegate:self buttonTitles:@[@"OK"]];
                _alertComplete.delegate = self;
                [_alertComplete showAlert];
            }
            else {
                NSLog(@"Confirm error...");
                _errorConfirmLabel.hidden = NO;
                _errorConfirmLabel.text = response[@"msg"];
            }
        }
        else {
            [self showNoInternetViewWithSelector:nil];
        }
    }
}

- (IBAction)resendConfirmCodeClicked:(id)sender {
    if ([self connected]) {
        NSMutableDictionary *params = [NSMutableDictionary initWithApiKey];
        [params setValue:_signupModel.firstName forKey:@"firstName"];
        [params setValue:_signupModel.lastName forKey:@"lastName"];
        [params setValue:_signupModel.firstNameKana forKey:@"firstNameKana"];
        [params setValue:_signupModel.lastNameKana forKey:@"lastNameKana"];
        [params setValue:_signupModel.email forKey:@"email"];
        [params setValue:_signupModel.password forKey:@"password"];
        NSDictionary *response;
        NSError *error;
        BOOL result =  [[QKCLRequestManager sharedManager] syncPOST:[NSString stringFromConst:qkUrlAccountRegist] parameters:params response:&response error:&error showLoading:YES showError:YES];
        
        if (result) {
            CCAlertView *comfirmAlertView = [[CCAlertView alloc] initWithImage:[UIImage imageNamed:@"dialog_pic_send"]
                                                                         title:@"確認コードを再送信しました"
                                                                    andMessage:[NSString stringWithFormat:@"%@\n%@", @"入力したメールアドレス宛に", @"確認コードを再送信しました"] style:QKAlertViewStyleWhite];
            comfirmAlertView.delegate = self;
            [comfirmAlertView showAlert];
        }
    }
    else {
        [self showNoInternetViewWithSelector:@selector(resendConfirmCodeClicked:)];
    }
}

#pragma mark - CCAlert delegate
- (void)alertView:(CCAlertView *)alertView selectedButtonIndex:(NSInteger)index {
    if (index == 0) {
        [self performSegueWithIdentifier:@"QKShowAddNewShopSegue" sender:self];
    }
}

#pragma mark - Navigation

//In a storyboard - based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    //  Get the new view controller using [segue destinationViewController].
    //  Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"QKShowAddNewShopSegue"]) {
    }
}

@end

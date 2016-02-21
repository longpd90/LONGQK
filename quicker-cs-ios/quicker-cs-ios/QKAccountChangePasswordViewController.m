//
//  QKAccountChangePasswordViewController.m
//  quicker-cs-ios
//
//  Created by Nguyen Huu Anh on 5/19/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKAccountChangePasswordViewController.h"
#import "QKMyPageTableViewController.h"
#import "QKGlobalNoBorderTextField.h"

static NSString *const TextFieldCell = @"QKTittleAndTextFieldTableViewCell";
@interface QKAccountChangePasswordViewController ()
@property (strong, nonatomic) QKGlobalNoBorderTextField *currentPassAccount;
@property (strong, nonatomic) QKGlobalNoBorderTextField *confirmPassAccount;
@property (strong, nonatomic) QKGlobalNoBorderTextField *confirmNewPassAccount;

@end
@implementation QKAccountChangePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setAngleLeftBarButton];
    self.title = NSLocalizedString(@"パスワード変更", nil);
    [self.thisTableView registerNib:[UINib nibWithNibName:TextFieldCell bundle:[NSBundle mainBundle]] forCellReuseIdentifier:TextFieldCell];
    self.thisTableView.scrollEnabled = NO;
    [self.updatePassOutlet setEnabled:NO];
}

#pragma mark UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    switch (indexPath.row) {
        case 0: {
            QKTittleAndTextFieldTableViewCell *cells = (QKTittleAndTextFieldTableViewCell *)[tableView dequeueReusableCellWithIdentifier:TextFieldCell];
            if (cells == nil) {
                cell = [[QKTittleAndTextFieldTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:TextFieldCell];
            }
            cells.titleLabel.text = @"現在のパスワード";
            [cells.textField setInputMode:InputModeEnglish];
            self.currentPassAccount = cells.textField;
            cells.textField.placeholder = @"入力してください";
            
            [self.currentPassAccount addTarget:self action:@selector(textFieldChange:) forControlEvents:UIControlEventEditingChanged];
            [cells.textField setSecureTextEntry:YES];
            cell = cells;
            break;
        }
            
        case 1: {
            QKTittleAndTextFieldTableViewCell *cells = (QKTittleAndTextFieldTableViewCell *)[tableView dequeueReusableCellWithIdentifier:TextFieldCell];
            if (cells == nil) {
                cell = [[QKTittleAndTextFieldTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:TextFieldCell];
            }
            cells.titleLabel.text = @"新しいパスワード";
            [cells.textField setInputMode:InputModeEnglish];
            self.confirmPassAccount = cells.textField;
            cells.textField.placeholder = @"入力してください";
            
            [self.confirmPassAccount addTarget:self action:@selector(textFieldChange:) forControlEvents:UIControlEventEditingChanged];
            [cells.textField setSecureTextEntry:YES];
            cell = cells;
            break;
        }
        case 2: {
            QKTittleAndTextFieldTableViewCell *cells = (QKTittleAndTextFieldTableViewCell *)[tableView dequeueReusableCellWithIdentifier:TextFieldCell];
            if (cells == nil) {
                cell = [[QKTittleAndTextFieldTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:TextFieldCell];
            }
            cells.titleLabel.text = @"新しいパスワード(確認)";
            [cells.textField setInputMode:InputModeEnglish];
            self.confirmNewPassAccount = cells.textField;
            cells.textField.placeholder = @"入力してください";
            
            [self.confirmNewPassAccount addTarget:self action:@selector(textFieldChange:) forControlEvents:UIControlEventEditingChanged];
            [cells.textField setSecureTextEntry:YES];
            cell = cells;
            break;
        }
            
        default:
            break;
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

#pragma action TextField change
- (void)textFieldChange:(UITextField *)textField {
    [self checkEnableChangPassButton];
}

- (void)checkEnableChangPassButton {
    BOOL enable = YES;
    if (self.currentPassAccount == nil || [self.currentPassAccount.text isEqualToString:@""]) {
        enable = NO;
    }
    if (self.confirmPassAccount == nil || [self.confirmPassAccount.text isEqualToString:@""]) {
        enable = NO;
    }
    if (self.confirmNewPassAccount == nil || [self.confirmNewPassAccount.text isEqualToString:@""]) {
        enable = NO;
    }
    [self.updatePassOutlet setEnabled:enable];
}

- (IBAction)changePassword:(id)sender {
    if ([self connected]) {
        if ([self.confirmNewPassAccount.text isEqualToString:self.confirmPassAccount.text]) {
            if (![self.confirmPassAccount.text isEqualToString:self.currentPassAccount.text]) {
            
                NSMutableDictionary *params = [NSMutableDictionary initWithApiKeyAndToken];
                [params setObject:[QKAccessUserDefaults getUserId] forKey:@"userId"];
                [params setObject:[QKEncryptUtil encyptBlowfish:self.currentPassAccount.text]  forKey:@"password"];
                [params setObject:[QKEncryptUtil encyptBlowfish:self.confirmPassAccount.text] forKey:@"newPassword"];
                NSDictionary *response;
                NSError *error;
                BOOL result =  [[QKRequestManager sharedManager] syncPOST:[NSString stringFromConst:qkCSUrlAccountPasswordUpdate] parameters:params response:&response error:&error showLoading:YES showError:YES];
        
                if (result) {
                    CCAlertView *changePasswordAlv = [[CCAlertView alloc] initWithImage:[UIImage    imageNamed:@"dialog_pic_done"] title:nil andMessage:@"パスワード変更の成功を" style:QKAlertViewStyleWhite];
                    changePasswordAlv.delegate = self;
                    [changePasswordAlv setTag:1000];
                    [changePasswordAlv showAlert];
                }
            }
            else {
                NSLog(@"Current Password and new password is same!");
            }
        }
        else {
            NSLog(@"New pass word with confirm password not same!");
        }
    }
    else {
        [self showNoInternetViewWithSelector:(nil)];
    }
}

#pragma mark - CCAlertViewDelegate
- (void)clickOnAlertView:(CCAlertView *)alertView {
    if (alertView.tag == 1000) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

@end

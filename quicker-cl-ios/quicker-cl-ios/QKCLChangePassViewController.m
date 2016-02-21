//
//  QKChangePassViewController.m
//  quicker-cl-ios
//
//  Created by Viet on 6/17/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLChangePassViewController.h"
#import "QKTextFieldTableViewCell.h"
#define oldPassIdentifi @"oldPassWordCell"
#define newPassIdentifi @"passWordCell"
#define confirmPassIdentifi @"confirmPassWordCell"
#define registerCell @"QKTextFieldTableViewCell"
@interface QKCLChangePassViewController ()

@end
@implementation QKCLChangePassViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:registerCell bundle:nil] forCellReuseIdentifier:oldPassIdentifi];
    [self.tableView registerNib:[UINib nibWithNibName:registerCell bundle:nil] forCellReuseIdentifier:newPassIdentifi];
    [self.tableView registerNib:[UINib nibWithNibName:registerCell bundle:nil] forCellReuseIdentifier:confirmPassIdentifi];
    [self.tableView setScrollEnabled:NO];
    [self.changPassButton setEnabled:NO];
    [self setAngleLeftBarButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

# pragma mark - tableview delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 1;
            
        case 1:
            return 2;
            
        default: return 0;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    switch (indexPath.section) {
        case 0: {
            QKTextFieldTableViewCell *cells = (QKTextFieldTableViewCell *)[tableView dequeueReusableCellWithIdentifier:oldPassIdentifi];
            if (cells == nil) {
                cells = [[QKTextFieldTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:oldPassIdentifi];
            }
            
            [cells.textField setInputMode:InputModeEnglish];
            [cells.textField setSecureTextEntry:YES];
            _oldPassWord = cells.textField;
            [_oldPassWord setPlaceholder:NSLocalizedString(@"現在のパスワードを入力", nil)];
            [_oldPassWord addTarget:self action:@selector(textChanged:) forControlEvents:UIControlEventEditingChanged];
            
            cell = cells;
            break;
        }
            
        case 1: {
            switch (indexPath.row) {
                case 0: {
                    QKTextFieldTableViewCell *cells = (QKTextFieldTableViewCell *)[tableView dequeueReusableCellWithIdentifier:newPassIdentifi];
                    if (cells == nil) {
                        cells = [[QKTextFieldTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:newPassIdentifi];
                    }
                    
                    
                    
                    [cells.textField setSecureTextEntry:YES];
                    [cells.textField setInputMode:InputModeEnglish];
                    _theNewPassWord = cells.textField;
                    [_theNewPassWord addTarget:self action:@selector(textChanged:) forControlEvents:UIControlEventEditingChanged];
                    [_theNewPassWord setPlaceholder:NSLocalizedString(@"新しいパスワードを入力", nil)];
                    
                    cell = cells;
                    break;
                }
                    
                case 1: {
                    QKTextFieldTableViewCell *cells = (QKTextFieldTableViewCell *)[tableView dequeueReusableCellWithIdentifier:confirmPassIdentifi];
                    if (cells == nil) {
                        cells = [[QKTextFieldTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:confirmPassIdentifi];
                    }
                    
                    
                    
                    [cells.textField setSecureTextEntry:YES];
                    [cells.textField setInputMode:InputModeEnglish];
                    _confirmPassWord = cells.textField;
                    [_confirmPassWord addTarget:self action:@selector(textChanged:) forControlEvents:UIControlEventEditingChanged];
                    [_confirmPassWord setPlaceholder:NSLocalizedString(@"再度パスワードを入力", nil)];
                    cell = cells;
                    break;
                }
                    
                default:
                    break;
            }
        }
            
        default: break;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}

# pragma mark - Actions
- (void)textChanged:(UITextField *)textField {
    [self checkEnableChangPassButton];
}

- (void)checkEnableChangPassButton {
    BOOL enable = YES;
    
    if (_oldPassWord == nil || [_oldPassWord.text isEqualToString:@""]) {
        enable = NO;
    }
    if (_theNewPassWord == nil || [_theNewPassWord.text isEqualToString:@""]) {
        enable = NO;
    }
    if (_confirmPassWord == nil || [_confirmPassWord.text isEqualToString:@""]) {
        enable = NO;
    }
    [_changPassButton setEnabled:enable];
}

- (BOOL)checkEqualNewPassWord {
    return [_theNewPassWord.text isEqualToString:_confirmPassWord.text];
}

- (void)enbleMessageWarning {
    [UIView animateWithDuration:0.1
                     animations: ^{
                         self.topContraintButton.constant = 60;
                         [self.view layoutIfNeeded];
                     }];
    [_warningLabel setHidden:NO];
}

# pragma mark - IBActions
- (IBAction)changPassButtonClicked:(id)sender {
    if ([self checkEqualNewPassWord] == YES) {
        if ([self connected]) {
            NSMutableDictionary *params = [NSMutableDictionary initWithApiKeyAndToken];
            [params setObject:[QKCLAccessUserDefaults getUserId] forKey:@"userId"];
            [params setObject:[QKCLEncryptUtil encyptBlowfish:_oldPassWord.text] forKey:@"password"];
            [params setObject:[QKCLEncryptUtil encyptBlowfish:_theNewPassWord.text] forKey:@"newPassword"];
            
            [[QKCLRequestManager sharedManager] asyncPOST:[NSString stringFromConst:qkUrlAccountPasswordUpdate]  parameters:params showLoading:YES showError:NO success: ^(AFHTTPRequestOperation *operation, id responseObject) {
                if ([responseObject[QK_API_STATUS_CODE] isEqualToString:[NSString stringFromConst:QK_STT_CODE_SUCCESS]]) {
                    [self.navigationController popViewControllerAnimated:YES];
                }
                else {
                    [self enbleMessageWarning];
                    [_warningLabel setText:responseObject[@"msg"]];
                }
            } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
                [self enbleMessageWarning];
                [_warningLabel setText:@"server error "];
                
                NSLog(@"Error: %@", error);
            }];
        }
        else {
            [self showNoInternetViewWithSelector:nil];
        }
    }
    else {
        [self enbleMessageWarning];
        [_warningLabel setText:NSLocalizedString(@"確認用のパスワードが一致しません", nil)];
        return;
    }
}

@end

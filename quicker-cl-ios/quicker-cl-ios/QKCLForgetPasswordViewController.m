//
//  QKForgetPasswordViewController.m
//  quicker-cl-ios
//
//  Created by LongPD-PC on 5/4/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLForgetPasswordViewController.h"
#import "QKTextFieldTableViewCell.h"
@interface QKCLForgetPasswordViewController () <QKTextFieldTableViewCellDelegate>

@end

@implementation QKCLForgetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //custom button back
    [self setAngleLeftBarButton];
    
    //[self setTitle: NSLocalizedString(@"確認コードの入力", nil)];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"QKTextFieldTableViewCell" bundle:nil] forCellReuseIdentifier:@"TextFieldCell"];
    [self.sendButton setEnabled:NO];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (_emailTextField.isFirstResponder) {
        [_emailTextField resignFirstResponder];
    }
    
    if (_firstNameTextField.isFirstResponder) {
        [_firstNameTextField resignFirstResponder];
    }
    
    
    if (_lastNameTextField.isFirstResponder) {
        [_lastNameTextField resignFirstResponder];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma TableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QKTextFieldTableViewCell *cell = (QKTextFieldTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"TextFieldCell" forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[QKTextFieldTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TextFieldCell"];
    }
    switch (indexPath.row) {
        case 0: {
            [cell.textField setPlaceholder:@"氏"];
            cell.delegate = self;
            _firstNameTextField = cell.textField;
            
            break;
        }
            
        case 1: {
            [cell.textField setPlaceholder:@"名"];
            cell.delegate = self;
            _lastNameTextField = cell.textField;
            break;
        }
            
        case 2: {
            [cell.textField setPlaceholder:@"メールアドレス"];
            cell.delegate = self;
            [cell.textField setInputMode:InputModeEnglish];
            _emailTextField = cell.textField;
            break;
        }
            
        default:
            break;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

//click send mail
- (IBAction)btnSendClick:(id)sender {
    if ([self connected]) {
        NSMutableDictionary *params = [NSMutableDictionary initWithApiKey];
        [params setObject:_emailTextField.text forKey:@"email"];
        [params setObject:_firstNameTextField.text forKey:@"firstName"];
        [params setObject:_lastNameTextField.text forKey:@"lastName"];
        NSDictionary *response;
        NSError *error;
        BOOL result = [[QKCLRequestManager sharedManager] syncPOST:[NSString stringFromConst:qkUrlAccountPasswordReissue] parameters:params response:&response error:&error showLoading:YES showError:YES];
        
        if (result) {
            NSLog(@"Reset password successful...");
            CCAlertView *comfirmAlertView = [[CCAlertView alloc] initWithImage:[UIImage imageNamed:@"dialog_pic_send"]
                                                                         title:NSLocalizedString(@"送信が完了しました", nil)
                                                                    andMessage:[NSString stringWithFormat:@"%@\n%@", NSLocalizedString(@"パスワードを再設定するための", nil), NSLocalizedString(@"手順をお送りしました。", nil)]
                                                                         style:QKAlertViewStyleWhite];
            comfirmAlertView.delegate = self;
            [comfirmAlertView showAlert];
        }
    }
    else {
        [self showNoInternetViewWithSelector:nil];
    }
}

- (void)textFieldEditingChanged:(UITextField *)textField {
    if (![_firstNameTextField.text isEqualToString:@""] && ![_lastNameTextField.text isEqualToString:@""] && ![_emailTextField.text isEqualToString:@""]) {
        [self.sendButton setEnabled:YES];
    }
    else {
        [self.sendButton setEnabled:NO];
    }
}

#pragma Delegete CCAlertView
- (void)clickOnAlertView:(CCAlertView *)alertView {
    [self goBack:self];
}

@end

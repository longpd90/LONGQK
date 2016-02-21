//
//  QKChangeMailViewController.m
//  quicker-cl-ios
//
//  Created by LongPD-PC on 4/21/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLChangeMailViewController.h"
#import "QKCLConst.h"
#import "QKTextFieldTableViewCell.h"
#define registerCell @"QKTextFieldTableViewCell"
#define firstNameIdentifi @"firstNameCell"
#define lastNameIdentifi @"lastNameCell"
#define emailIdentifi @"emailCell"
#define passWordIdentifi @"passWordCell"
@interface QKCLChangeMailViewController ()

@end

@implementation QKCLChangeMailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //custom back button
    [self setAngleLeftBarButton];
    
    //set title for nav
    [self setTitle:@"メールアドレス変更"];
    [self regiterCell];
    [self.changeMailButton setEnabled:NO];
    [self.warningLabel setHidden:YES];
    [self.tableView setScrollEnabled:NO];
}

- (void)regiterCell {
    [self.tableView registerNib:[UINib nibWithNibName:registerCell bundle:nil] forCellReuseIdentifier:firstNameIdentifi];
    [self.tableView registerNib:[UINib nibWithNibName:registerCell bundle:nil] forCellReuseIdentifier:lastNameIdentifi];
    [self.tableView registerNib:[UINib nibWithNibName:registerCell bundle:nil] forCellReuseIdentifier:emailIdentifi];
    [self.tableView registerNib:[UINib nibWithNibName:registerCell bundle:nil] forCellReuseIdentifier:passWordIdentifi];
}

#pragma tableview delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 30.0f;
            
        default: return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    switch (indexPath.row) {
        case 0: {
            QKTextFieldTableViewCell *cells = (QKTextFieldTableViewCell *)[tableView dequeueReusableCellWithIdentifier:firstNameIdentifi];
            if (cells == nil) {
                cells = [[QKTextFieldTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:firstNameIdentifi];
            }
            _firstName = cells.textField;
            [_firstName addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
            [_firstName setPlaceholder:@"氏"];
            cell = cells;
            break;
        }
            
        case 1: {
            QKTextFieldTableViewCell *cells = (QKTextFieldTableViewCell *)[tableView dequeueReusableCellWithIdentifier:lastNameIdentifi];
            if (cells == nil) {
                cells = [[QKTextFieldTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:lastNameIdentifi];
            }
            _lastName = cells.textField;
            [_lastName addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
            [_lastName setPlaceholder:@"名"];
            cell = cells;
            break;
        }
            
        case 2: {
            QKTextFieldTableViewCell *cells = (QKTextFieldTableViewCell *)[tableView dequeueReusableCellWithIdentifier:emailIdentifi];
            if (cells == nil) {
                cells = [[QKTextFieldTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:emailIdentifi];
            }
            [cells.textField setInputMode:InputModeEnglish];
            _changeMailTextField = cells.textField;
            [_changeMailTextField addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
            [_changeMailTextField setPlaceholder:@"メールアドレス"];
            cell = cells;
            break;
        }
            
        case 3: {
            QKTextFieldTableViewCell *cells = (QKTextFieldTableViewCell *)[tableView dequeueReusableCellWithIdentifier:passWordIdentifi];
            if (cells == nil) {
                cells = [[QKTextFieldTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:passWordIdentifi];
            }
            [cells.textField setSecureTextEntry:YES];
            
            [cells.textField setInputMode:InputModeEnglish];
            _passwordTextField = cells.textField;
            [_passwordTextField addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
            
            [_passwordTextField setPlaceholder:NSLocalizedString(@"パスワード", nil)];
            cell = cells;
            break;
        }
    }
    return cell;
}

# pragma mark - action

- (IBAction)changeMailFinish:(id)sender {
    if (self.connected) {
        NSMutableDictionary *params = [NSMutableDictionary initWithApiKeyAndToken];
        [params setObject:[QKCLAccessUserDefaults get:@"userId"] forKey:@"userId"];
        [params setObject:self.changeMailTextField.text forKey:@"email"];
        [params setObject:[QKCLEncryptUtil encyptBlowfish:self.passwordTextField.text] forKey:@"password"];
        NSDictionary *response;
        NSError *error;
        BOOL result =  [[QKCLRequestManager sharedManager] syncPOST:[NSString stringFromConst:qkUrlAccountEmailUpdate] parameters:params response:&response error:&error showLoading:YES showError:NO];
        
        if (result) {
            [self.navigationController popViewControllerAnimated:YES];
        }
        else {
            [_warningLabel setHidden:NO];
            [_warningLabel setText:response[@"msg"]];
        }
    }
    else {
        QKCSNoInternetView *noInternetView = [[QKCSNoInternetView alloc] initWithTarget:self selector:@selector(changeMailFinish:)];
        [noInternetView show];
    }
}

- (void)dismissKeyboard {
    [_changeMailTextField resignFirstResponder];
    [_passwordTextField resignFirstResponder];
}

#pragma action
- (void)textChange:(id)sender {
    BOOL enable = YES;
    if (_firstName.text  == nil || [_firstName.text isEqualToString:@""]) {
        enable = NO;
    }
    if (_lastName.text  == nil || [_lastName.text isEqualToString:@""]) {
        enable = NO;
    }
    if (_changeMailTextField.text == nil || [_changeMailTextField.text isEqualToString:@""]) {
        enable = NO;
    }
    if (_passwordTextField.text == nil || [_passwordTextField.text isEqualToString:@""]) {
        enable = NO;
    }
    [self.changeMailButton setEnabled:enable];
}

# pragma mark - text field delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField // this method get called when you tap "Go"
{
    [self dismissKeyboard];
    [self changeMailFinish:nil];
    return YES;
}

#pragma mark - CCKeyboardHandlerDelegate

- (void)keyboardSizeChanged:(CGSize)delta {
    if (delta.height < 0) {
        CGRect frame = self.view.frame;
        frame.origin.y = 0;
        self.view.frame = frame;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

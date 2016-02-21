//
//  QKAccountDetailViewController.m
//  quicker-cs-ios
//
//  Created by Nguyen Huu Anh on 5/19/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKAccountDetailViewController.h"
#import "QKTittleAndTextFieldTableViewCell.h"
#import "QKTableViewCell.h"
#import "QKSignUpViewController.h"
#import "chiase-ios-core/CCDateUtil.h"
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>

@interface QKAccountDetailViewController ()
@property (strong, nonatomic) CCAlertView *changeEmailAlert;
@property (strong, nonatomic) CCAlertView *deleteAccountAlert;
@property (strong, nonatomic) CCAlertView *wrongPassAlert;
@property (strong, nonatomic) CCAlertView *confirmAlert;

@property (strong, nonatomic) NSString *passWord;

@property (strong, nonatomic) QKGlobalNoBorderTextField *emailAccount;

@end
static NSString *kQKTittleAndTextFieldTableViewCell = @"QKTittleAndTextFieldTableViewCell";
@implementation QKAccountDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setAngleLeftBarButton];
    [self setTitle:@"アカウント"];
    
    [self.thisTableView setScrollEnabled:NO];
    [self.thisTableView registerNib:[UINib nibWithNibName:kQKTittleAndTextFieldTableViewCell bundle:[NSBundle mainBundle]] forCellReuseIdentifier:kQKTittleAndTextFieldTableViewCell];
    [[NSNotificationCenter defaultCenter] addObserverForName:@"QKWithDrawSuccessful" object:nil queue:nil usingBlock: ^(NSNotification *note) {
        [CCAccessUserDefaults put:@"QKNeedShowWithDrawAlert" withValue:@"1"];
        UINavigationController *mainMenuNavigationViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"QKNavigationSignupViewController"];
        [[UIApplication sharedApplication] keyWindow].rootViewController = mainMenuNavigationViewController;
        [[[UIApplication sharedApplication] keyWindow] makeKeyWindow];
    }];
}

#pragma  mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    switch (indexPath.row) {
        case 0: {
            QKTittleAndTextFieldTableViewCell *cells = (QKTittleAndTextFieldTableViewCell *)[tableView dequeueReusableCellWithIdentifier:kQKTittleAndTextFieldTableViewCell];
            if (cells == nil) {
                cells = [[QKTittleAndTextFieldTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:kQKTittleAndTextFieldTableViewCell];
            }
            cells.titleLabel.text = @"メール";
            cells.textField.text = [QKAccessUserDefaults getMail];
            self.emailAccount = cells.textField;
            NSLog(@"EMail: %@", self.emailAccount.text);
            [cells.textField setUserInteractionEnabled:YES];
            cell = cells;
            break;
        }
            
        case 1: {
            QKTittleAndTextFieldTableViewCell *cells = (QKTittleAndTextFieldTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"QKTittleAndTextFieldTableViewCell"];
            cells.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            [cells.textField setText:@"12345678"];
            [cells.textField setSecureTextEntry:YES];
            cells.textField.userInteractionEnabled = NO;
            cells.titleLabel.text = @"パスワード";
            cell = cells;
            break;
        }
            
        default:
            break;
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 1) {
        [self performSegueWithIdentifier:@"QKChangePassWordSegue" sender:self];
    }
}
- (void) textFieldDidChange {
}
- (IBAction)deleteAccount:(id)sender {
    self.deleteAccountAlert = [[CCAlertView alloc]initWithTitle:@"パスワードの確認" message:@"情報の閲覧、編集にはパスワードが必要です。" delegate:self buttonTitles:@[@"キャンセル", @"OK"] haveTextField:YES];
    [self.deleteAccountAlert showAlert];
}
- (void)logOut {
    
    [QKAccessUserDefaults clear];
    [QKAccessUserDefaults put:kQKShowWithdrawAlertKey withValue:@"1"];
    
    UINavigationController *mainMenuNavigationViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"QKNavigationSignupViewController"];
    [[UIApplication sharedApplication] keyWindow].rootViewController = mainMenuNavigationViewController;
    [[[UIApplication sharedApplication] keyWindow] makeKeyAndVisible];
    
}

#pragma mark - CCAlertViewDelegate

- (void)alertView:(CCAlertView *)alertView selectedButtonIndex:(NSInteger)index {
        if (alertView == self.deleteAccountAlert) {
            if (index == 1) {
                
                self.passWord = alertView.textField.text;
                [self deleteAccount];
            }
        }
    
        if (alertView == self.changeEmailAlert) {
            if (index == 1) {
                self.passWord = alertView.textField.text;
                [self changeEmail];
            }
            else {
                [self.navigationController popViewControllerAnimated:YES];
                
            }
        }
    if (alertView.tag == 1000) {
        
    }
    
    if (alertView == self.wrongPassAlert) {
        if (index == 1) {
            if (alertView.tag == 2000) {
                [self.deleteAccountAlert showAlert];
            }
            else if (alertView.tag == 1000) {
                [self.changeEmailAlert showAlert];
            }
        }
    }
    if (alertView == self.confirmAlert) {
        if (index == 1) {
            NSMutableDictionary *params = [NSMutableDictionary initWithApiKeyAndToken];
            [params setObject:[QKAccessUserDefaults getUserId] forKey:@"userId"];
            
            NSDictionary *response;
            NSError *error;
            BOOL result =  [[QKRequestManager sharedManager] syncPOST:[NSString stringFromConst:qkCSUrlAccountRegistWithdraw] parameters:params response:&response error:&error showLoading:YES showError:YES];
            if (result) {
                [self logOut];
            }else{
                NSLog(@"logout fail %@",response[@"msg"]);
            }
        }
    }
}
- (void) changeEmail {
    if ([self connected]) {
        // Call API
        NSMutableDictionary *params = [NSMutableDictionary initWithApiKeyAndToken];
        [params setObject:[QKAccessUserDefaults getUserId] forKey:@"userId"];
        [params setObject:self.emailAccount.text forKey:@"email"];
        [params setObject:[QKEncryptUtil encyptBlowfish:self.passWord] forKey:@"password"];
        
        [[QKRequestManager sharedManager] asyncPOST:[NSString stringFromConst:qkCsUrlAccountEmailUpdate] parameters:params showLoading:YES showError:YES success: ^(AFHTTPRequestOperation *operation, id responseObject) {
            
            if ([responseObject[QK_API_STATUS_CODE] isEqualToString:[NSString stringFromConst:QK_STT_CODE_SUCCESS]]) {
                NSLog(@"Response: %@", responseObject);
                [self.navigationController popViewControllerAnimated:YES];
                NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
                [userDefault setValue:self.emailAccount.text forKey:@"USER_DEFAULT_MAIL"];
            }
        } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
            self.wrongPassAlert = [[CCAlertView alloc]initWithTitle:@"パスワードが違います" message:nil delegate:self buttonTitles:@[@"キャンセル", @"再施行"]];
            self.wrongPassAlert.tag = 1000;
            [self.wrongPassAlert showAlert];
        }];
    }
    else {
        [self showNoInternetViewWithSelector:nil];
    }
}
- (void)deleteAccount {
    if ([self connected]) {
        [self checkAccountDetail];
    }
    else {
        [self showNoInternetViewWithSelector:nil];
    }
}

- (void)checkAccountDetail {
    
    NSString *fbAccessToken = [FBSDKAccessToken currentAccessToken].tokenString;
    NSLog(@"FB Accsess Token: %@", fbAccessToken);
    NSLog(@"Token: %@", [QKAccessUserDefaults getFBAccessToken]);
    //check FBAccesstoken

    //Check Authtime
    if (![[QKAccessUserDefaults getAuthTime] isEqualToString:@""]) {
        NSInteger diff = [CCDateUtil diffDateByMinute:[NSDate date] withDate:[CCDateUtil makeDate:[QKAccessUserDefaults getAuthTime] format:@"yyyy/MM/dd HH:mm:ss"]];
        if (diff < 24 * 60) {
            NSLog(@"Register with less than 24h");
//            [self performSegueWithIdentifier:@"QKShowAccountDetailSegue" sender:self];
            return;
        }
    }
    if (![[QKAccessUserDefaults getFBAccessToken] isEqualToString:@""]) {
        NSLog(@"Test FB");
    }
    else {
        //Login normal
        NSMutableDictionary *params = [NSMutableDictionary initWithApiKeyAndToken];
        [params setObject:[QKAccessUserDefaults getUserId] forKey:@"userId"];
        [params setObject:[QKEncryptUtil encyptBlowfish:self.passWord] forKey:@"password"];
        NSDictionary *response;
        NSError *error;
        BOOL result =  [[QKRequestManager sharedManager] syncPOST:[NSString stringFromConst:qkCSUrlAccountDelete] parameters:params response:&response error:&error showLoading:YES showError:NO];
        
        if (result) {
            NSString *message = [NSString stringWithFormat:@"%@\n%@\n%@\n%@", @"削除すると、あなたのアカウント情報、経歴、", @"職歴、レジュメに加え、応募したバイト情報、", @"お気に入りの店舗などのすべての情報が", @"削除されます。"];
            
            self.confirmAlert = [[CCAlertView alloc]initWithTitle:@"アカウントを削除しますか？" message:message delegate:self buttonTitles:@[@"しない", @"削除する"] isDelete:YES];
            
            [self.confirmAlert showAlert];
        }
        else {
            self.wrongPassAlert = [[CCAlertView alloc]initWithTitle:@"パスワードが違います" message:nil delegate:self buttonTitles:@[@"キャンセル", @"再施行"]];
            self.wrongPassAlert.tag = 2000;
            [self.wrongPassAlert showAlert];
        }
    }
}
- (void) goBack:(id)sender {
    if (![self.emailAccount.text isEqualToString:[QKAccessUserDefaults getMail]]) {
        self.changeEmailAlert = [[CCAlertView alloc]initWithTitle:@"パスワードの確認" message:@"情報の閲覧、編集にはパスワードが必要です。" delegate:self buttonTitles:@[@"キャンセル", @"OK"] haveTextField:YES];
        [self.changeEmailAlert showAlert];
    }
    else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
@end

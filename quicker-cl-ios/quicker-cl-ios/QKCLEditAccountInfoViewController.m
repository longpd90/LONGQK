//
//  QKEditAccountInfoViewController.m
//  quicker-cl-ios
//
//  Created by Nguyen Huu Anh on 5/27/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLEditAccountInfoViewController.h"
#import "QKTittleAndTextFieldTableViewCell.h"
#import "QKTableViewCell.h"
#import "QKCLCameraViewController.h"
#import "QKCLCropImageViewController.h"
#import "QKCLLocalNotificationManager.h"

#define kQKAccountCameraKey @"QKAccountCameraKey"
#define kQKAccountCameraValue @"QKAccountCameraValue"

@interface QKCLEditAccountInfoViewController () <QKCropImageViewControllerDelegate>
@property (strong, nonatomic) CCAlertView *enterPassAlv;
@property (strong, nonatomic) CCAlertView *confirmDeleteAlv;

@end

@implementation QKCLEditAccountInfoViewController

static NSString *AccountInfoCellIdentifier = @"QKTittleAndTextFieldTableViewCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setLeftBarButtonWithTitle:NSLocalizedString(@"キャンセル", nil) target:@selector(goBack:)];
    [self setRightBarButtonWithTitle:@"完了" target:@selector(updateProfile)];
    [self getAccountInfo];
    
    //regist cell
    [self.accountTableView registerNib:[UINib nibWithNibName:AccountInfoCellIdentifier bundle:[NSBundle mainBundle]] forCellReuseIdentifier:AccountInfoCellIdentifier];
}

- (void)getAccountInfo {
    if (self.connected) {
        NSMutableDictionary *params = [NSMutableDictionary initWithApiKeyAndToken];
        [params setObject:[QKCLAccessUserDefaults getUserId] forKey:@"userId"];
        [[QKCLRequestManager sharedManager] asyncGET:[NSString stringFromConst:qkUrlProfileDetail] parameters:params showLoading:YES showError:YES success: ^(AFHTTPRequestOperation *operation, id responseObject) {
            if ([QK_STT_CODE_SUCCESS isEqualToString:responseObject[QK_API_STATUS_CODE]]) {
                self.profileDetail  = [[QKCLProfileDetailModel alloc] initWithResponse:responseObject];
                [self reloadData];
            }
        } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Get account in fo fail...");
        }];
    }
    else {
        [self showNoInternetViewWithSelector:@selector(getAccountInfo)];
    }
}

- (void)reloadData {
    [self.avatarImageView setImageWithQKURL:self.profileDetail.imgPath placeholderImage:[UIImage imageNamed:@"account_pic_blankprofile"] withCache:NO];
    [self.accountTableView reloadData];
}

- (void)changeAvata:(NSNotification *)notis {
    NSDictionary *dict = notis.userInfo;
    UIImage *imageAvata = [dict objectForKey:@"getImageEdited"];
    [self.avatarImageView setImage:imageAvata];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"dismissEditImage" object:nil];
}

- (void)textFieldChange:(UITextField *)textField {
    int index = (int)textField.tag - 20;
    switch (index) {
        case 0:
            self.profileDetail.lastName = textField.text;
            break;
            
        case 1:
            self.profileDetail.firstName = textField.text;
            break;
            
        case 2:
            self.profileDetail.lastNameKana = textField.text;
            break;
            
        case 3:
            self.profileDetail.firstNameKana = textField.text;
            break;
    }
}

- (void)updateProfile {
    if ([self connected]) {
        NSMutableDictionary *params = [NSMutableDictionary initWithApiKeyAndToken];
        [params setValue:[QKCLAccessUserDefaults getUserId] forKey:@"userId"];
        [params setValue:self.profileDetail.firstName forKey:@"firstName"];
        [params setValue:self.profileDetail.lastName forKey:@"lastName"];
        [params setValue:self.profileDetail.firstNameKana forKey:@"firstNameKana"];
        [params setValue:self.profileDetail.lastNameKana forKey:@"lastNameKana"];
        [params setValue:[QKCLEncryptUtil encyptBlowfish:_thisPassWord] forKey:@"password"];
        NSDictionary *response;
        NSError *error;
        BOOL result = [[QKCLRequestManager sharedManager] syncPOST:[NSString stringFromConst:qkUrlProfileNameUpdate] parameters:params response:&response error:&error showLoading:YES showError:YES];
        
        if (result) {
            [self updateMore];
        }
    }
    else {
        [self showNoInternetViewWithSelector:nil];
    }
}
- (void)updateMore {
    if ([self connected]) {
        NSMutableDictionary *params = [NSMutableDictionary initWithApiKeyAndToken];
        [params setValue:[QKCLAccessUserDefaults getUserId] forKey:@"userId"];
        //[params setValue: forKey:<#(NSString *)#>]
        NSDictionary *response;
        NSError *error;
        BOOL result = [[QKCLRequestManager sharedManager] syncPOST:[NSString stringFromConst:qkUrlProfileUpdate] parameters:params response:&response error:&error showLoading:YES showError:YES];
        
        if (result) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    else {
        [self showNoInternetViewWithSelector:nil];
    }
    
}
#pragma mark - Table delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return kCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    QKTittleAndTextFieldTableViewCell *cell1 = (QKTittleAndTextFieldTableViewCell *)[tableView dequeueReusableCellWithIdentifier:AccountInfoCellIdentifier];
    
    if (!cell1) {
        cell1 = (QKTittleAndTextFieldTableViewCell *)[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                                                           reuseIdentifier :AccountInfoCellIdentifier];
    }
    [cell1.textField addTarget:self action:@selector(textFieldChange:) forControlEvents:UIControlEventEditingChanged];
    cell1.accessoryView = nil;
    switch (indexPath.row) {
        case kLastName:
            cell1.titleLabel.text = NSLocalizedString(@"氏", nil);
            cell1.textField.tag = 20;
            cell1.textField.text = self.profileDetail.lastName;
            cell = cell1;
            break;
            
        case kFirstName:
            cell1.titleLabel.text = NSLocalizedString(@"名", nil);
            cell1.textField.tag = 21;
            cell1.textField.text = self.profileDetail.firstName;
            cell = cell1;
            break;
            
        case kLastNameKana:
            cell1.titleLabel.text = NSLocalizedString(@"氏(カナ)", nil);
            cell1.textField.tag = 22;
            cell1.textField.text = self.profileDetail.lastNameKana;
            cell = cell1;
            break;
            
        case kFirstNameKana:
            cell1.titleLabel.text = NSLocalizedString(@"名(カナ)", nil);
            cell1.textField.tag = 23;
            cell1.textField.text = self.profileDetail.firstNameKana;
            cell = cell1;
            break;
            
        case kMail: {
            QKTableViewCell *cell2 = (QKTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"QKChangeMailCell"];
            if (!cell2) {
                cell2 = [[QKTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                              reuseIdentifier :@"QKChangeMailCell"];
            }
            cell2.textLabel.text = NSLocalizedString(@"メールアドレス", nil);
            cell2.detailTextLabel.text = NSLocalizedString(@"変更", nil);
            cell2.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell = cell2;
            break;
        }
            
        case kPassword: {
            QKTableViewCell *cell3 = (QKTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"QKChangePassCell"];
            if (!cell3) {
                cell3 = [[QKTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                              reuseIdentifier :@"QKChangePassCell"];
            }
            
            cell3.textLabel.text = NSLocalizedString(@"パスワード", nil);
            cell3.detailTextLabel.text = NSLocalizedString(@"変更", nil);
            cell3.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell = cell3;
            break;
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == kMail) {
        [self performSegueWithIdentifier:@"QKChangeEmailSeque" sender:self];
    }
    else if (indexPath.row == kPassword) {
        [self performSegueWithIdentifier:@"QKChangePasswordSeque" sender:self];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return nil;
}

# pragma mark - action
- (IBAction)avatarButtonClicked:(id)sender {
    if ([[QKCLAccessUserDefaults get:kQKAccountCameraKey] isEqualToString:kQKAccountCameraValue]) {
        [self performSegueWithIdentifier:@"QKShowCameraSegue" sender:self];
    }
    else {
        [QKCLAccessUserDefaults put:kQKAccountCameraKey withValue:kQKAccountCameraValue];
        [self performSegueWithIdentifier:@"QKSnaphitCameraSeque" sender:self];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeAvata:) name:@"dismissEditImage" object:nil];
    }
}

//action delete account
- (IBAction)btnDeleteClick:(id)sender {
    self.enterPassAlv = [[CCAlertView alloc] initWithTitle:@"パスワードの確認"
                                                   message:@"アカウントの削除にはパスワードが必要です"
                                                  delegate:self
                                              buttonTitles:@[@"キャンセル", @"OK"]
                                             haveTextField:YES];
    self.enterPassAlv.textField.secureTextEntry = YES;
    [self.enterPassAlv showAlert];
}

#pragma CCAlertView Delegate
- (void)alertView:(CCAlertView *)alertView selectedButtonIndex:(NSInteger)index {
    if (alertView == self.enterPassAlv) {
        if (index == 1) {
            if ([self checkPassword:self.enterPassAlv.textField.text]) {
                NSString *msg = [NSString stringWithFormat:@"%@\n%@\n%@", NSLocalizedString(@"あなたのアカウント情報を削除すると、", nil), NSLocalizedString(@"店舗情報、勤務履歴、請求情報、など", nil), NSLocalizedString(@"関連する全ての情報が削除されます", nil)];
                self.confirmDeleteAlv = [[CCAlertView alloc] initWithTitle:@"アカウントを削除しますか？"
                                                                   message:msg
                                                                  delegate:self
                                                              buttonTitles:@[@"しない", @"削除する"]
                                                             haveTextField:NO];
                
                [self.confirmDeleteAlv showAlert];
            }
            else {
                self.enterPassAlv = [[CCAlertView alloc]initWithTitle:@"パスワードが一致しません" message:@"再度入力をしてください" delegate:self buttonTitles:@[@"キャンセル", @"OK"] haveTextField:YES];
                self.enterPassAlv.textField.secureTextEntry = YES;
                [self.enterPassAlv showAlert];
            }
        }
        return;
    }
    
    if (alertView == self.confirmDeleteAlv) {
        if (index == 1) {
            if ([self connected]) {
                NSMutableDictionary *params = [NSMutableDictionary initWithApiKeyAndToken];
                [params setObject:[QKCLAccessUserDefaults getUserId] forKey:@"userId"];
                NSDictionary *response;
                NSError *error;
                BOOL result =  [[QKCLRequestManager sharedManager] syncPOST:[NSString stringFromConst:qkUrlAccountWithDraw] parameters:params response:&response error:&error showLoading:YES showError:YES];
                if (result) {
                    if ([response[QK_API_STATUS_CODE] isEqualToString:[NSString stringFromConst:QK_STT_CODE_SUCCESS]]) {
                        [QKCLAccessUserDefaults clear];
                        [QKCLLocalNotificationManager cancelAllLocalNotification];
                        [QKCLAccessUserDefaults put:@"QKNeedShowWithDrawAlert" withValue:@"1"];
                        UIViewController *signinNavigationViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"QKNavigationSigninViewController"];
                        [UIApplication sharedApplication].keyWindow.rootViewController = signinNavigationViewController;
                        [[UIApplication sharedApplication].keyWindow makeKeyAndVisible];
                    }
                }
            }
            else {
                [self showNoInternetViewWithSelector:nil];
            }
        }
    }
}

- (BOOL)checkPassword:(NSString *)password {
    if ([self connected]) {
        NSMutableDictionary *params = [NSMutableDictionary initWithApiKeyAndToken];
        [params setObject:[QKCLAccessUserDefaults getUserId] forKey:@"userId"];
        [params setObject:[QKCLEncryptUtil encyptBlowfish:password] forKey:@"password"];
        NSDictionary *response;
        NSError *error;
        BOOL result = [[QKCLRequestManager sharedManager] syncPOST:[NSString stringFromConst:qkUrlClAccountPasswordReauth] parameters:params response:&response error:&error showLoading:YES showError:NO];
        return result;
    }
    else {
        [self showNoInternetViewWithSelector:nil];
    }
    return NO;
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"QKShowCameraSegue"]) {
        UINavigationController *nav = [segue destinationViewController];
        QKCLCameraViewController *cameraViewController = (QKCLCameraViewController *)nav.viewControllers[0];
        cameraViewController.hintSegue = @"QKAccountFaceHintSegue";
        cameraViewController.presentingVC = self;
        cameraViewController.cropImageType = QKCropImageTypeSquare;
        cameraViewController.sourceImageType = [NSString stringFromConst:QK_IMAGE_TYPE_MAIN];
        cameraViewController.mode = QKUploadModeProfile;
        cameraViewController.isCaptureForAvatar = YES;
    }
}

#pragma mark- QKCropImageDelegate
- (void)croppedImage:(UIImage *)image imageId:(NSString *)imageId {
    [self.avatarImageView setImage:image];
}

@end

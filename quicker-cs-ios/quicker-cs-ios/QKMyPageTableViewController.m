//
//  QKMyPageTableViewController.m
//  quicker-cs-ios
//
//  Created by LongPD-PC on 5/8/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKMyPageTableViewController.h"
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import "QKImageAndTittleTableViewCell.h"
#import "QKTableViewCell.h"
#import "QKCreatProfileViewController.h"
#import "QKJobHistoryViewController.h"
#import "QKAccountDetailViewController.h"
#import "QKCSWebViewController.h"
@interface QKMyPageTableViewController () <CCAlertViewDelegate>
@property (strong, nonatomic) CCAlertView *accountConfirmPassAlert;
@property (strong, nonatomic) CCAlertView *logoutAlertView;
@property (strong, nonatomic) CCAlertView *confirmAlertView;
@property (nonatomic) NSInteger selectedRow;

@property (nonatomic) qkcsWebViewType webViewType;
@end

static NSString *QKImageAndTittleTableViewCellIdentifier = @"QKImageAndTittleTableViewCell";
static NSString *QKTableViewCellIdentifier = @"QKTableViewCell";

@implementation QKMyPageTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:QKImageAndTittleTableViewCellIdentifier bundle:nil] forCellReuseIdentifier:QKImageAndTittleTableViewCellIdentifier];
}

#pragma mark - Table delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return kSectionCount;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == kSection1) {
        return kRow1Count;
    }
    else if (section == kSection2) {
        return kRow2Count;
    }
    else if (section == kSection3) {
        return kRow3Count;
    }
    else if (section == kSection4) {
        return kRow4Count;
    }
    else if (section == kSection5) {
        return kRow5Count;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == kSection2 || section == kSection3) {
        return 60.0;
    }
    
    return 30.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    
    
    switch (indexPath.section) {
        case kSection1:
        {
            QKImageAndTittleTableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:QKImageAndTittleTableViewCellIdentifier forIndexPath:indexPath];
            if (!cell1) {
                cell1 = [[QKImageAndTittleTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:QKImageAndTittleTableViewCellIdentifier];
            }
            switch (indexPath.row) {
                case kRow11:
                    cell1.qkTittleLabel.text = NSLocalizedString(@"お気に入り店舗", nil);
                    cell1.qkImageView.image = [UIImage imageNamed:@"list_ic_mypage_01"];
                    break;
                    
                case kRow12:
                    cell1.qkTittleLabel.text = NSLocalizedString(@"給料情報", nil);
                    cell1.qkImageView.image = [UIImage imageNamed:@"list_ic_mypage_02"];
                    break;
            }
            cell = cell1;
            break;
        }
            
        case kSection2:
        {
            QKImageAndTittleTableViewCell *cell2 = [tableView dequeueReusableCellWithIdentifier:QKImageAndTittleTableViewCellIdentifier forIndexPath:indexPath];
            if (!cell2) {
                cell2 = [[QKImageAndTittleTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:QKImageAndTittleTableViewCellIdentifier];
            }
            switch (indexPath.row) {
                case kRow21: {
                    cell2.qkTittleLabel.text = NSLocalizedString(@"プロフィール情報", nil);
                    cell2.qkImageView.image = [UIImage imageNamed:@"list_ic_mypage_03"];
                    break;
                }
                    
                case kRow22: {
                    cell2.qkTittleLabel.text = NSLocalizedString(@"履歴書情報", nil);
                    cell2.qkImageView.image = [UIImage imageNamed:@"list_ic_mypage_04"];
                    break;
                }
            }
            cell = cell2;
            break;
        }
            
        case kSection3:
        {
            QKTableViewCell *cell3 = [tableView dequeueReusableCellWithIdentifier:QKTableViewCellIdentifier];
            if (!cell3) {
                cell3 = [[QKTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:QKTableViewCellIdentifier];
            }
            switch (indexPath.row) {
                case kRow31:
                    cell3.textLabel.text = NSLocalizedString(@"アカウント", nil);
                    break;
                    
                case kRow32:
                    cell3.textLabel.text = NSLocalizedString(@"プッシュ通知", nil);
                    UISwitch *switchPushNotification = [UISwitch new];
                    [switchPushNotification setOn:NO];
                    cell3.accessoryView = switchPushNotification;
                    
                    break;
            }
            cell3.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell = cell3;
            break;
        }
            
        case kSection4:
        {
            QKTableViewCell *cell4 = [tableView dequeueReusableCellWithIdentifier:QKTableViewCellIdentifier];
            if (!cell4) {
                cell4 = [[QKTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:QKTableViewCellIdentifier];
            }
            switch (indexPath.row) {
                case kRow41:
                    cell4.textLabel.text = NSLocalizedString(@"利用規約", nil);
                    break;
                    
                case kRow42:
                    cell4.textLabel.text = NSLocalizedString(@"プライバシーポリシー", nil);
                    break;
                    
                case kRow43:
                    cell4.textLabel.text = NSLocalizedString(@"このアプリについて", nil);
                    break;
                    
                case kRow44:
                    cell4.textLabel.text = NSLocalizedString(@"お問い合わせ", nil);
                    break;
            }
            cell4.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell = cell4;
            break;
        }
            
        case kSection5:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"QKLogoutCell" forIndexPath:indexPath];
            if (!cell) {
                cell = [[QKTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"QKLogoutCell"];
            }
            break;
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.section) {
        case kSection1:
            switch (indexPath.row) {
                case kRow11: {
                    // Call API CS_FAV_0001
                    if ([self connected]) {
                    }
                    /*
                     Check count > 1
                     */
                    [self performSegueWithIdentifier:@"QKCSFavoriteStoreSegue" sender:self];
                    
                    /*
                     Check count < 0
                     */
                    //                    [self performSegueWithIdentifier:@"QKCSFavoriteNoneObjectSegue" sender:self];
                }
                    break;
                    
                case kRow12:
                    [self performSegueWithIdentifier:@"QKCSWorkHistorySegue" sender:self];
                    break;
            }
            break;
            
        case kSection2:
            switch (indexPath.row) {
                case kRow21:
                    [self editProfile];
                    break;
                    
                case kRow22:
                    [self editCV];
                    break;
            }
            break;
            
        case kSection3:
            switch (indexPath.row) {
                case kRow31:
//                    [self showAccountDetail];
                    [self performSegueWithIdentifier:@"QKShowAccountDetailSegue" sender:self];
                    break;
                    
                case kRow32:
                    
                    break;
            }
            break;
            
        case kSection4:
            switch (indexPath.row) {
                case kRow41:
                    self.webViewType = qkcsWebViewTypeTermOfService;
                    [self performSegueWithIdentifier:@"QKCSMypageWebViewSegue" sender:self];
                    break;
                    
                case kRow42:
                    self.webViewType = qkcsWebViewTypePolicy;
                    [self performSegueWithIdentifier:@"QKCSMypageWebViewSegue" sender:self];
                    break;
                    
                case kRow43: {
                    [self performSegueWithIdentifier:@"QKAboutAppSegue" sender:self];
                    break;
                }
                    
                case kRow44:
                    [self performSegueWithIdentifier:@"QKCSContactUsSegue" sender:self];
                    break;
            }
            break;
            
        case kSection5:
            [self logout];
            break;
    }
    _selectedRow = indexPath.row;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case kSection2:
            return NSLocalizedString(@"応募情報の編集", nil);
            break;
            
        case kSection3:
            return NSLocalizedString(@"設定", nil);
            break;
            
        default:
            return @"";
            break;
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section != 0 && indexPath.section != 1) {
        // Remove seperator inset
        if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
            [cell setSeparatorInset:UIEdgeInsetsZero];
        }
        
        // Prevent the cell from inheriting the Table View's margin settings
        if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
            [cell setPreservesSuperviewLayoutMargins:NO];
        }
        
        // Explictly set your cell's layout margins
        if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
            [cell setLayoutMargins:UIEdgeInsetsZero];
        }
    }
}

#pragma mark-Actions
- (void)editProfile {
    [self performSegueWithIdentifier:@"QKEditProfileSegue" sender:self];
}

- (void)editCV {
    [self performSegueWithIdentifier:@"QKEditCVSegue" sender:self];
}

- (void)showAccountDetail {
    //Check Authtime
    if (![[QKAccessUserDefaults getAuthTime] isEqualToString:@""]) {
        NSInteger diff = [CCDateUtil diffDateByMinute:[NSDate date] withDate:[CCDateUtil makeDate:[QKAccessUserDefaults getAuthTime] format:@"yyyy/MM/dd HH:mm:ss"]];
        if (diff < 24 * 60) {
            [self performSegueWithIdentifier:@"QKShowAccountDetailSegue" sender:self];
            return;
        }
    }
    
    //check FBAccesstoken
    if (![[QKAccessUserDefaults getFBAccessToken] isEqualToString:@""]) {
    }
    else {
        //Login normal
        _accountConfirmPassAlert = [[CCAlertView alloc]initWithTitle:@"Confirm" message:@"Enter password to access it." delegate:self buttonTitles:@[@"Cancel", @"OK"] haveTextField:YES];
        [_accountConfirmPassAlert showAlert];
    }
}

- (void)authFacebook {
    //revoke permission
    [[[FBSDKGraphRequest alloc] initWithGraphPath:@"/me/permissions"
                                       parameters:nil
                                       HTTPMethod:@"DELETE"]
     startWithCompletionHandler: ^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
         //auth again
         FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
         [login logInWithReadPermissions:@[] handler: ^(FBSDKLoginManagerLoginResult *result, NSError *error) {
             if (error) {
                 // Process error
                 NSLog(@"Facebook error...");
             }
             else if (result.isCancelled) {
                 // Handle cancellations
                 NSLog(@"Facebook cancelled...");
             }
             else {
                 NSLog(@"Facebook success...");
                 [QKAccessUserDefaults setFBAccessToken:[FBSDKAccessToken currentAccessToken].tokenString];
                 [QKAccessUserDefaults setAuthTime:[[NSDate date] stringValueFormattedBy:@"yyyy/MM/dd HH:mm:ss"]];
                 [self performSegueWithIdentifier:@"QKShowAccountDetailSegue" sender:self];
             }
         }];
     }];
}

- (void)logout {
    _logoutAlertView = [[CCAlertView alloc] initWithTitle:@"ログアウトしますか?"
                                                  message:nil
                                                 delegate:self
                                             buttonTitles:@[@"しない", @"ログアウト"]];
    [_logoutAlertView showAlert];
}

#pragma mark - CCAlertViewDelegate

- (void)alertView:(CCAlertView *)alertView selectedButtonIndex:(NSInteger)index {
    //logout
    if (alertView == _logoutAlertView) {
        if (index == 1) {
            NSMutableDictionary *params = [NSMutableDictionary initWithApiKeyAndToken];
            [params setObject:[QKAccessUserDefaults getUserId] forKey:@"userId"];
            
            NSDictionary *response;
            NSError *error;
            BOOL result =  [[QKRequestManager sharedManager] syncPOST:[NSString stringFromConst:qkCSUrlAccountLogout] parameters:params response:&response error:&error showLoading:YES showError:YES];
            if (result) {
                [QKAccessUserDefaults clear];
                [QKAccessUserDefaults put:kQKNeedShowLogoutAlertKey withValue:kQKNeedShowLogoutAlert];
                UINavigationController *mainMenuNavigationViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"QKNavigationSignupViewController"];
                [[UIApplication sharedApplication] keyWindow].rootViewController = mainMenuNavigationViewController;
                [[[UIApplication sharedApplication] keyWindow] makeKeyAndVisible];
            }
            else {
                NSLog(@"Logout error...");
            }
        }
    }
    
    //account
    if (alertView == _accountConfirmPassAlert) {
        if (index == 1) {
            [self performSegueWithIdentifier:@"QKShowAccountDetailSegue" sender:self];
        }
    }
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"QKEditProfileSegue"]) {
        QKCreatProfileViewController *creatProfileViewController = (QKCreatProfileViewController *)segue.destinationViewController;
        
        creatProfileViewController.mode = QKProfileModeEdit;
    }
    if ([segue.identifier isEqualToString:@"QKEditCVSegue"]) {
        QKJobHistoryViewController *jobHistoryViewController = (QKJobHistoryViewController *)segue.destinationViewController;
        jobHistoryViewController.mode = QKCVmodeModeEdit;
    }
    if ([segue.identifier isEqualToString:@"QKShowAccountDetailSegue"]) {
    }
    
    if ([segue.identifier isEqualToString:@"QKCSMypageWebViewSegue"]) {
        QKCSWebViewController *webViewController = (QKCSWebViewController *)segue.destinationViewController;
        if (self.webViewType == qkcsWebViewTypeTermOfService) {
            webViewController.title = NSLocalizedString(@"利用規約", nil);
            webViewController.stringURL = [NSString stringFromConst:qkCSUrlWebAgreement];
        }
        else if (self.webViewType == qkcsWebViewTypePolicy) {
            webViewController.title = NSLocalizedString(@"プライバシーポリシー", nil);
            webViewController.stringURL = [NSString stringFromConst:qkCSUrlWebCopyright];
        }
    }
}

@end

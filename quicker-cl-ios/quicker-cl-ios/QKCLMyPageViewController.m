//
//  MyPageViewController.m
//  quicker-cl-ios
//
//  Created by LongPD-PC on 4/15/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLMyPageViewController.h"
#import "QKCLChoosePaymentMethodViewController.h"
#import "QKCSNoInternetView.h"
#import "QKCLImageModel.h"
#import "QKCLLocalNotificationManager.h"
#import "AppDelegate.h"
#import "QKImageView.h"
#import "QKCLWebViewController.h"


@interface QKCLMyPageViewController () <CCAlertViewDelegate, UITableViewDelegate>
@property (strong, nonatomic) UILabel *unreadLabel;
@property (nonatomic) qkclWebViewType webType;
@end

@implementation QKCLMyPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"マイページ", nil);
    SWRevealViewController *revealViewController = self.revealViewController;
    if (revealViewController) {
        //create the button
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [button setBackgroundImage:[UIImage imageNamed:@"nav_btn_change"]
                          forState:UIControlStateNormal];
        
        [button    addTarget:self action:@selector(changeShop:)
            forControlEvents:UIControlEventTouchUpInside];
        
        [button sizeToFit];
        [button setUserInteractionEnabled:YES];
        _unreadLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(button.frame) - 14.0, CGRectGetMinY(button.frame), 14.0, 14.0)];
        _unreadLabel.font = [UIFont systemFontOfSize:10.0];
        _unreadLabel.textColor = kQKColorWhite;
        _unreadLabel.textAlignment = NSTextAlignmentCenter;
        _unreadLabel.backgroundColor = kQKColorError;
        [_unreadLabel setClipsToBounds:YES];
        _unreadLabel.layer.cornerRadius = 7.0f;
        [button addSubview:_unreadLabel];
        _unreadLabel.hidden = YES;
        UIBarButtonItem *customBarItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        
        self.navigationItem.leftBarButtonItem = customBarItem;
        [self.navigationController.navigationBar addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getShopDetail];
    [self getUnreadNotice];
}

- (void)getShopDetail {
    if ([self connected]) {
        NSMutableDictionary *params = [NSMutableDictionary initWithApiKeyAndToken];
        [params setObject:[QKCLAccessUserDefaults getUserId] forKey:@"userId"];
        [params setObject:[QKCLAccessUserDefaults getActiveShopId] forKey:@"shopId"];
        [[QKCLRequestManager sharedManager] asyncGET:[NSString stringFromConst:qkUrlShopDetail] parameters:params showLoading:YES showError:YES success: ^(AFHTTPRequestOperation *operation, id responseObject) {
            if ([responseObject[QK_API_STATUS_CODE] isEqualToString:[NSString stringFromConst:QK_STT_CODE_SUCCESS]]) {
                self.shopInfo = [[QKCLShopInfoModel alloc] initWithResponse:responseObject];
                [self.detailTableView reloadData];
            }
        } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Load fail...");
            NSLog(@"%@", error);
        }];
    }
    else {
        [self showNoInternetViewWithSelector:@selector(getShopDetail)];
    }
}

- (void)getUnreadNotice {
    __block NSInteger count = 0;
    if ([self connected]) {
        NSMutableDictionary *params = [NSMutableDictionary initWithApiKeyAndToken];
        [params setObject:[QKCLAccessUserDefaults getUserId] forKey:@"userId"];
        
        [[QKCLRequestManager sharedManager] asyncGET:[NSString stringFromConst:qkUrlShopList] parameters:params showLoading:YES showError:YES success: ^(AFHTTPRequestOperation *operation, id responseObject) {
            if ([responseObject[QK_API_STATUS_CODE] isEqualToString:[NSString stringFromConst:QK_STT_CODE_SUCCESS]]) {
                NSArray *listShop = [responseObject objectForKey:@"shopList"];
                for (NSDictionary *shopInfoDic in listShop) {
                    count += [shopInfoDic[@"unreadNoticeNum"] integerValue];
                }
                if (count > 0) {
                    _unreadLabel.text = [NSString stringWithFormat:@"%d", count];
                    _unreadLabel.hidden = NO;
                }
                else {
                    _unreadLabel.hidden = YES;
                    _unreadLabel.text = @"0";
                }
            }
        } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
        }];
    }
    else {
        [self showNoInternetViewWithSelector:@selector(getUnreadNotice)];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
    else if (section == kSection6) {
        return kRow6Count;
    }
    else if (section == kSection7) {
        return kRow7Count;
    }
    return 0;
}

- (CGFloat)       tableView:(UITableView *)tableView
    heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == kRow11 && indexPath.section == kSection1) {
        return 115.0;
    }
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section < kSection4 && section > 0) {
        return 50.0;
    }
    if (section == kSection4) {
        return 30.0;
    }
    
    return 30.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ProfileCellIdentifier = @"QKMyPagesCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ProfileCellIdentifier];
    cell.textLabel.textColor = [UIColor colorWithRed:68.0 / 255.0 green:68.0 / 255.0 blue:68.0 / 255.0 alpha:1.0];
    cell.textLabel.font = [UIFont systemFontOfSize:14.0];
    UIImageView *iconImageView = (UIImageView *)[cell.contentView viewWithTag:20];
    UILabel *titleLabel = (UILabel *)[cell.contentView viewWithTag:21];
    UILabel *subLabel = (UILabel *)[cell.contentView viewWithTag:22];
    
    switch (indexPath.section) {
        case kSection1:
            switch (indexPath.row) {
                case kRow11:
                    cell = [tableView dequeueReusableCellWithIdentifier:@"QKMypageShopCell"];
                    QKImageView *shopImageView = (QKImageView *)[cell.contentView viewWithTag:100];
                    UILabel *shopNameLabel = (UILabel *)[cell.contentView viewWithTag:101];
                    if ([self.shopInfo.imageFileList count] > 0) {
                        QKCLImageModel *imageModel = (QKCLImageModel *)[self.shopInfo.imageFileList firstObject];
                        [shopImageView setImageWithQKURL:imageModel.imageUrl withCache:YES];
                    }
                    
                    shopNameLabel.text = self.shopInfo.name;
                    break;
            }
            break;
            
        case kSection2:
            switch (indexPath.row) {
                case kRow21: {
                    iconImageView.image = [UIImage imageNamed:@"list_ic_past"];
                    titleLabel.text = NSLocalizedString(@"過去の勤務者", nil);
                    cell.textLabel.text = @"";
                    subLabel.text = @"";
                    break;
                }
                    
                case kRow22: {
                    iconImageView.image = [UIImage imageNamed:@"list_ic_fav"];
                    titleLabel.text = NSLocalizedString(@"お気に入りの勤務者", nil);
                    cell.textLabel.text = @"";
                    subLabel.text = [NSString stringWithFormat:@"%ld人", (long)self.shopInfo.favoriteNum];
                    break;
                }
            }
            break;
            
        case kSection3:
            switch (indexPath.row) {
                case kRow31:
                    iconImageView.image = [UIImage imageNamed:@"list_ic_payment"];
                    titleLabel.text = NSLocalizedString(@"支払い方法", nil);
                    //subLabel.text = [QKConst.PAYMENT_SYSTEM_MAP objectForKey:self.shopInfo.paymentSystemType];
                    subLabel.text = self.shopInfo.paymentSystemTypeName;
                    cell.textLabel.text = @"";
                    iconImageView.hidden = NO;
                    break;
                    
                case kRow32:
                    iconImageView.image = [UIImage imageNamed:@"list_ic_billing"];
                    titleLabel.text = NSLocalizedString(@"請求情報", nil);
                    cell.textLabel.text = @"";
                    subLabel.text = @"";
                    break;
            }
            break;
            
            
            
        case kSection5:
            switch (indexPath.row) {
                case kRow51: {
                    iconImageView.hidden = NO;
                    iconImageView.image = [UIImage imageNamed:@"list_ic_account"];
                    titleLabel.text = NSLocalizedString(@"アカウント情報", nil);
                    cell.textLabel.text = @"";
                    UISwitch *switchPushNotification = (UISwitch *)[cell.contentView viewWithTag:100];
                    switchPushNotification.hidden = YES;
                    break;
                }
                    
                case kRow52:
                    titleLabel.text = @"";
                    cell.textLabel.text = NSLocalizedString(@"プッシュ通知", nil);
                    cell.accessoryType = UITableViewCellAccessoryNone;
                    iconImageView.hidden = YES;
                    UISwitch *switchPushNotification = (UISwitch *)[cell.contentView viewWithTag:100];
                    [switchPushNotification addTarget:self action:@selector(onOffPushNotification:) forControlEvents:UIControlEventValueChanged];
                    switchPushNotification.hidden = NO;
                    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
                    if ([appDelegate checkNotificationSettings]) {
                        switchPushNotification.enabled = YES;
                        switchPushNotification.on = ([self.shopInfo.pushStatus isEqualToString:@"01"]);
                    }
                    else {
                        switchPushNotification.on = NO;
                        switchPushNotification.enabled = NO;
                    }
                    [cell.contentView addSubview:switchPushNotification];
                    break;
            }
            break;
            
        case kSection6:
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"QKNormalCell"];
            cell.textLabel.textColor = [UIColor colorWithRed:68.0 / 255.0 green:68.0 / 255.0 blue:68.0 / 255.0 alpha:1.0];
            cell.textLabel.font = [UIFont systemFontOfSize:14.0];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            switch (indexPath.row) {
                case kRow61:
                    cell.textLabel.text = NSLocalizedString(@"労働条件通知書", nil);
                    break;
                    
                case kRow62:
                    cell.textLabel.text = NSLocalizedString(@"ガイドライン", nil);
                    break;
                    
                case kRow63:
                    cell.textLabel.text = NSLocalizedString(@"利用規約", nil);
                    break;
                    
                case kRow64:
                    cell.textLabel.text = NSLocalizedString(@"プライバシーポリシー", nil);
                    break;
                    
                case kRow65:
                    cell.textLabel.text = NSLocalizedString(@"著作権情報", nil);
                    break;
                    
                case kRow66:
                    cell.textLabel.text = NSLocalizedString(@"このアプリについて", nil);
                    break;
                    
                case kRow67:
                    cell.textLabel.text = NSLocalizedString(@"お問い合わせ", nil);
                    break;
            }
            break;
            
        case kSection7:
            cell = [tableView dequeueReusableCellWithIdentifier:@"QKMypageLogoutCell"];
            break;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.section) {
        case kSection1:
            switch (indexPath.row) {
                case kRow11:
                    [self showShopInfo];
                    break;
            }
            break;
            
        case kSection2:
            switch (indexPath.row) {
                case kRow21: {
                    [self performSegueWithIdentifier:@"QKWorkersPastYearSegue" sender:self];
                    break;
                }
                    
                case kRow22:
                    [self performSegueWithIdentifier:@"QKWorkerFavoriteSegue" sender:self];
                    break;
            }
            break;
            
        case kSection3:
            switch (indexPath.row) {
                case kRow31:
                    [self showPaymentMethod];
                    break;
                    
                case kRow32:
                    
                    break;
            }
            break;
            
        case kSection5:
            switch (indexPath.row) {
                case kRow51:
                    [self performSegueWithIdentifier:@"QKAccountInfoSeque" sender:self];
                    break;
                    
                case kRow52:
                    
                    break;
            }
            break;
            
        case kSection6:
            switch (indexPath.row) {
                case kRow61:
                    [self showWorkCondition];
                    break;
                    
                case kRow62:
                    [self showUserGuide];
                    break;
                    
                case kRow63:
                    _webType = qkclWebViewTypeTermOfService;
                    [self performSegueWithIdentifier:@"QKCLShowWebviewSegue" sender:self];
                    break;
                    
                case kRow64:
                    _webType = qkclWebViewTypePolicy;
                    [self performSegueWithIdentifier:@"QKCLShowWebviewSegue" sender:self];
                    // [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.yahoo.com"]];
                    break;
                    
                case kRow65:
                    _webType = qkclWebViewTypeCopyright;
                    [self performSegueWithIdentifier:@"QKCLShowWebviewSegue" sender:self];
                    break;
                    
                case kRow66:
                    [self performSegueWithIdentifier:@"QKShowAboutAppSegue" sender:self];
                    break;
                    
                case kRow67:
                    [self showContactUs];
                    break;
            }
            break;
            
        case kSection7:
            [self logout];
            break;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case kSection3:
            return @"支払い履歴";
            break;
            
        case kSection2:
            return @"勤務履歴";
            break;
            
        case kSection5:
            return @"設定";
            break;
            
        default:
            return @"";
            break;
    }
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    UITableViewHeaderFooterView *v = (UITableViewHeaderFooterView *)view;
    v.backgroundView.backgroundColor = [UIColor colorWithRed:245.0 / 255.0 green:250.0 / 255.0 blue:250.0 / 255.0 alpha:1];
    [v.textLabel setFont:[UIFont systemFontOfSize:12.0]];
    v.textLabel.textColor = [UIColor colorWithHexString:@"#444"];
    UIView *removeView = [v viewWithTag:1000];
    [removeView removeFromSuperview];
    if (section == kSection4) {
        UILabel *invoiceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(v.frame), 30.0)];
        invoiceLabel.textAlignment = NSTextAlignmentCenter;
        invoiceLabel.tag = 1000;
        UIFont *smallFont = [UIFont systemFontOfSize:10.0];
        NSDictionary *smallDict = [NSDictionary dictionaryWithObject:smallFont forKey:NSFontAttributeName];
        NSMutableAttributedString *aAttrString = [[NSMutableAttributedString alloc] initWithString:@"現在の利用可龍残高  " attributes:smallDict];
        [aAttrString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#888"] range:(NSMakeRange(0, 11))];
        
        UIFont *largeFont = [UIFont systemFontOfSize:14.0];
        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
        [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
        NSString *numberAsString = [numberFormatter stringFromNumber:[NSNumber numberWithLong:self.shopInfo.availableAmount]];
        NSDictionary *largeFontDict = [NSDictionary dictionaryWithObject:largeFont forKey:NSFontAttributeName];
        NSMutableAttributedString *vAttrString = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@円", numberAsString] attributes:largeFontDict];
        [vAttrString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#444"] range:(NSMakeRange(0, vAttrString.string.length))];
        
        [aAttrString appendAttributedString:vAttrString];
        
        
        invoiceLabel.attributedText = aAttrString;
        invoiceLabel.center = CGPointMake(CGRectGetWidth(v.frame) / 2.0, CGRectGetHeight(v.frame) / 2.0);
        [v addSubview:invoiceLabel];
    }
}

#pragma mark - action
//Show shop info
- (void)showShopInfo {
    [self performSegueWithIdentifier:@"QKShowShopInfoSegue" sender:self];
}

- (void)showUserGuide {
    [self performSegueWithIdentifier:@"QKShowUserGuide" sender:self];
}

- (void)showPaymentMethod {
    //self.shopInfo.paymentSystemType = @"";
    
    if ([self.shopInfo.paymentSystemType isEqualToString:@""]) {
        if ([[QKCLAccessUserDefaults getPaymentShowDescription] isEqualToString:@""]) {
            [self performSegueWithIdentifier:@"QKDescriptionPaymentSegue" sender:self];
            [QKCLAccessUserDefaults setPaymentShowDescription:@"1"];
        }
        else {
            [self performSegueWithIdentifier:@"QKCLChoosePaymentMethodSegue" sender:self];
        }
    }
    else {
        [self performSegueWithIdentifier:@"QKShowPaymenMethodSegue" sender:self];
    }
}

- (void)showWebView {
    [self performSegueWithIdentifier:@"QKShowWebViewSegue" sender:self];
}

- (void)showContactUs {
    [self performSegueWithIdentifier:@"QKShowContactUsSegue" sender:self];
}

- (void)logout {
    CCAlertView *logoutAlertView = [[CCAlertView alloc] initWithTitle:@"ログアウトしますか?"
                                                              message:nil
                                                             delegate:self
                                                         buttonTitles:@[@"しない", @"ログアウト"]];
    [logoutAlertView showAlert];
}

- (void)onOffPushNotification:(UISwitch *)sender {
    UIApplication *application = [UIApplication sharedApplication];
    
    if ([sender isOn]) {
        if ([application respondsToSelector:@selector(registerUserNotificationSettings:)]) {
            UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert categories:nil];
            [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        }
        else {
            [application registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound];
        }
    }
    else {
        if ([application respondsToSelector:@selector(registerUserNotificationSettings:)]) {
            [application registerUserNotificationSettings:[UIUserNotificationSettings
                                                           settingsForTypes:
                                                           (UIUserNotificationType)
                                                           (UIUserNotificationTypeNone)
                                                           categories:nil]];
            
            [application unregisterForRemoteNotifications];
        }
        else {
            [application unregisterForRemoteNotifications];
        }
    }
}

- (void)changeShop:(id)sender {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"QKChangeShopNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeShop) name:@"QKChangeShopNotification" object:nil];
    [self.revealViewController revealToggleAnimated:YES];
}

- (void)changeShop {
    [self getShopDetail];
    //[self getUnreadNotice];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"QKChangeShopNotification" object:nil];
}

#pragma mark - CCAlertViewDelegate

- (void)alertView:(CCAlertView *)alertView selectedButtonIndex:(NSInteger)index {
    if (index == 1) {
        if ([self connected]) {
            NSMutableDictionary *params = [NSMutableDictionary initWithApiKeyAndToken];
            [params setObject:[QKCLAccessUserDefaults getUserId]  forKey:@"userId"];
            NSDictionary *response;
            NSError *error;
            BOOL result =  [[QKCLRequestManager sharedManager] syncPOST:[NSString stringFromConst:qkUrlAccountLogout] parameters:params response:&response error:&error showLoading:YES showError:YES];
            
            if (result) {
                [QKCLAccessUserDefaults clear];
                [CCAccessUserDefaults put:@"QKNeedShowLogoutAlert" withValue:@"1"];
                [QKCLLocalNotificationManager cancelAllLocalNotification];
                UIViewController *signinNavigationViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"QKNavigationSigninViewController"];
                [UIApplication sharedApplication].keyWindow.rootViewController = signinNavigationViewController;
                [[UIApplication sharedApplication].keyWindow makeKeyAndVisible];
            }
            else {
                NSLog(@"Logout fail...%@", response[@"statusCd"]);
            }
        }
        else {
            [self showNoInternetViewWithSelector:nil];
        }
    }
}

#pragma mark - Action to WorkConditionController
- (void)showWorkCondition {
    [self performSegueWithIdentifier:@"QKWorkConditionSegue" sender:self];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"QKShowPaymenMethodSegue"]) {
        QKCLPaymentMethodViewController *paymentMethodViewController = (QKCLPaymentMethodViewController *)[segue destinationViewController];
        paymentMethodViewController.paymentAddress = [self.shopInfo getFullAddressString];
        paymentMethodViewController.paymentSystemTypeCd = self.shopInfo.paymentSystemType;
        paymentMethodViewController.paymentSystemTypeName = self.shopInfo.paymentSystemTypeName;
    }
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    //copyright
    if ([segue.identifier isEqualToString:@"QKCLShowWebviewSegue"]) {
        QKCLWebViewController *webViewController = (QKCLWebViewController *)segue.destinationViewController;
        if (_webType == qkclWebViewTypeCopyright) {
            webViewController.title = NSLocalizedString(@"著作権情報", nil);
            webViewController.stringURL = [NSString stringFromConst:qkCLUrlWebCopyright];
        }
        else if (_webType == qkclWebViewTypePolicy) {
            webViewController.title = NSLocalizedString(@"プライバシーポリシー", nil);
            webViewController.stringURL = [NSString stringFromConst:qkCLUrlWebPrivacyPolicy];
        }
        else if (_webType == qkclWebViewTypeTermOfService) {
            webViewController.title = NSLocalizedString(@"利用規約", nil);
            webViewController.stringURL = [NSString stringFromConst:qkCLUrlWebAgreement];
        }
    }
}

@end

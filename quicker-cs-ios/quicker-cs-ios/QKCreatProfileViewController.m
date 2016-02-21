//
//  QKCreatProfileViewController.m
//  quicker-cs-ios
//
//  Created by LongPD-PC on 5/7/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCreatProfileViewController.h"
#import "QKGlobalDatePickerView.h"
#import "QKJobHistoryViewController.h"
#import "QKGlobalPickerView.h"
#import "QKTittleAndTextFieldTableViewCell.h"
#import "QKTableViewCell.h"
#import "QKGenderTableViewCell.h"
#import "QKConfirmKeyViewController.h"
#import "QKPhoneAuthenTableViewCell.h"
#import "QKCSWebViewController.h"

@interface QKCreatProfileViewController () <QKGlobalDatePickerViewDelegate, QKGlobalPickerViewDelegate, QKGenderTableViewCellDelegate>
@property (strong, nonatomic) QKGlobalDatePickerView *datePicker;
@property (strong, nonatomic) QKGlobalPickerView *qkPickerViewPaymentValue;
@property (strong, nonatomic) UITextField *currentTextField;

@property (strong, nonatomic) NSString *passWord;
@property (assign, nonatomic) BOOL editProfile;
@property (assign, nonatomic) BOOL allField;

@end

@implementation QKCreatProfileViewController

static NSString *ProfileCellIdentifier = @"QKProfileTableViewCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = NO;
    self.profileDetail = [QKProfileDetailModel new];
    self.profileDetail.gender = 2;
    [self.tableView setBackgroundColor:[UIColor clearColor]];
    [self setTitle:@"プロフィール"];
    [self setAngleLeftBarButton];
    [self.nextButton setEnabled:NO];
    [self.finishButton setEnabled:NO];
    self.timeLeftLabel.text = [self timeFormatted:_closingDate];
    if (self.mode == QKProfileModeEdit) {
        [self getprofile];
        self.tableViewContraintToBottom.constant = 50;
        self.tableViewContraintToTop.constant = -50;
        self.notificationView.hidden = YES;
        self.tableView.tableFooterView = nil;
        self.statusView.hidden = YES;
        self.centerLabel.text = @"応募先の担当者が";
        self.topLabel.text = @"あなたのことを教えてください";
        self.footerLabel.text = @"採用者を決める時に表示されます";
    }
    else if (self.mode == QKProfileModeRecruitment) {
        [self getprofile];
        [self setTitle:@"応募する"];
        self.templateView.hidden = NO;
        self.tableViewContraintToTop.constant = -50;
        self.topLabel.text = @"プロフィールを登録して応募";
        self.centerLabel.text = @"応募するにはプロフィールを登録ください";
        self.finishButton.hidden = NO;
        self.nextButton.hidden = YES;
        self.statusView.hidden = YES;
        [self setAngleLeftBarButton];
        self.tableViewContraintToBottom.constant = 50;
        self.notificationView.hidden = NO;
        self.footerLabel.hidden = YES;
    }
    else {
        self.headerTableView.height = 120;
        self.profileLabel.hidden = YES;
        self.navigationItem.leftBarButtonItem = nil;
        [self setRightBarButtonWithTitle:@"スキップ" target:@selector(skipAddProfile)];
        self.templateView.hidden = YES;
        self.notificationView.hidden = YES;
        self.finishButton.hidden = YES;
        self.nextButton.hidden = NO;
    }
    self.tableView.sectionFooterHeight = 0.0;
    self.tableView.sectionHeaderHeight = 0.0;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationItem.hidesBackButton = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillLayoutSubviews {
    _datePicker.width = self.view.width;
    _datePicker.height = self.view.height;
}

- (void)dealloc {
    [_tableView setDelegate:nil];
}

#pragma mark - pickerView
- (void)makeSortTypePickerView {
    if (!self.qkPickerViewPaymentValue) {
        self.qkPickerViewPaymentValue = [[QKGlobalPickerView alloc] init];
        self.qkPickerViewPaymentValue.delegate = self;
    }
    [self.qkPickerViewPaymentValue setPickerData:[[QKConst OCCUPATION_MAP] allValues]];
    //    if (_filter.sortCd != nil && ![_filter.sortCd isEqualToString:@""]) {
    //        [self.qkPickerViewPaymentValue setSelectedIndex:[[[QKConst SORT_TYPE_MAP] allKeys] indexOfObject:_filter.sortCd]];
    //    }
    
    [self.qkPickerViewPaymentValue show];
}

- (void)donePickerView:(QKGlobalPickerView *)pickerView selectedIndex:(NSInteger)selectedIndex {
    if (_profileDetail.occupation !=  [[[QKConst OCCUPATION_MAP] allKeys] objectAtIndex:selectedIndex]) {
        _profileDetail.occupation =  [[[QKConst OCCUPATION_MAP] allKeys] objectAtIndex:selectedIndex];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:5];
        [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    [self enableFinishbutton];
}

#pragma mark - date picker delegate

- (void)makeBirthDayDatePicker {
    if (!self.datePicker) {
        self.datePicker = [[QKGlobalDatePickerView alloc] init];
        self.datePicker.delegate = self;
        [self.datePicker.datePicker setDatePickerMode:UIDatePickerModeDate];
        
        NSCalendar *calendar = [NSCalendar currentCalendar];
        
        NSDateComponents *minComponents = [NSDateComponents new];
        minComponents.month = 1;
        minComponents.day = 1;
        minComponents.year = 1900;
        NSDate *dateMin = [calendar dateFromComponents:minComponents];
        [self.datePicker.datePicker setMinimumDate:dateMin];
        
        NSDateComponents *compareDateComponents = [calendar components:NSCalendarUnitYear
                                                              fromDate:[NSDate date]];
        compareDateComponents.month = 4;
        compareDateComponents.day = 1;
        
        NSDate *dateCompare = [calendar dateFromComponents:compareDateComponents];
        
        if ([dateCompare compare:[NSDate date]] == NSOrderedDescending) {
            NSDateComponents *descendingComponents = [NSDateComponents new];
            descendingComponents.year = compareDateComponents.year - 21;
            descendingComponents.month = 1;
            descendingComponents.day = 1;
            NSDate *dateInPut = [calendar dateFromComponents:descendingComponents];
            [_datePicker setDate:dateInPut];
            
            NSDateComponents *maxComponents = [NSDateComponents new];
            maxComponents.year = compareDateComponents.year - 16;
            maxComponents.month = 4;
            maxComponents.day = 1;
            NSDate *dateMax = [calendar dateFromComponents:maxComponents];
            [self.datePicker.datePicker setMaximumDate:dateMax];
        }
        else {
            NSDateComponents *ascendinComponents = [NSDateComponents new];
            ascendinComponents.year = compareDateComponents.year - 20;
            ascendinComponents.month = 1;
            ascendinComponents.day = 1;
            NSDate *dateInPut = [calendar dateFromComponents:ascendinComponents];
            [_datePicker setDate:dateInPut];
            
            NSDateComponents *maxComponents = [NSDateComponents new];
            maxComponents.year = compareDateComponents.year - 15;
            maxComponents.month = 12;
            maxComponents.day = 31;
            NSDate *dateMax = [calendar dateFromComponents:maxComponents];
            [self.datePicker.datePicker setMaximumDate:dateMax];
        }
    }
    else {
        [_datePicker setDate:_profileDetail.birthDay];
    }
    
    [self.datePicker show];
}

- (void)pickedDatePicker:(QKGlobalDatePickerView *)datePicker withDate:(NSDate *)date {
    if (_profileDetail.birthDay != date) {
        _profileDetail.birthDay = date;
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:3];
        [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    [self enableFinishbutton];
}

#pragma mark - call api

- (void)getprofile {
    if ([self connected]) {
        NSMutableDictionary *params = [NSMutableDictionary initWithApiKeyAndToken];
        [params setObject:[QKAccessUserDefaults getUserId] forKey:@"userId"];
        [[QKRequestManager sharedManager] asyncGET:[NSString stringFromConst:qkCSUrlProfileDetail] parameters:params showLoading:YES showError:YES success: ^(AFHTTPRequestOperation *operation, id responseObject) {
            if ([responseObject[QK_API_STATUS_CODE] isEqualToString:[NSString stringFromConst:QK_STT_CODE_SUCCESS]]) {
                if (self.mode == QKProfileModeEdit) {
                    _showPhoneNumAuthenCell = ![responseObject boolForKey:@"phoneNumAuthenticated"];
                }
                _profileDetail = [[QKProfileDetailModel alloc]initWithResponse:responseObject];
                [self.tableView reloadData];
            }
            else {
                NSLog(@"responseObject : %@ ", responseObject[@"msg"]);
            }
        } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
        }];
    }
    else {
        [self showNoInternetViewWithSelector:@selector(getprofile)];
    }
}

- (BOOL)callAPISaveProfile {
    if ([self connected]) {
        NSMutableDictionary *params = [NSMutableDictionary initWithApiKeyAndToken];
        [params setValue:[QKAccessUserDefaults getUserId] forKey:@"userId"];
        [params setValue:[QKAccessUserDefaults getPassword] forKey:@"password"];
        [params setValue:_profileDetail.firstName forKey:@"firstName"];
        [params setValue:_profileDetail.lastName forKey:@"lastName"];
        [params setValue:_profileDetail.firstNameKana forKey:@"firstNameKana"];
        [params setValue:_profileDetail.lastNameKana forKey:@"lastNameKana"];
        [params setValue:_profileDetail.phoneNumber forKey:@"phoneNum"];
        [params setValue:[NSString stringWithFormat:@"%ld", (long)_profileDetail.gender] forKey:@"sexFlg"];
        [params setValue:_profileDetail.occupation forKey:@"occupation"];
        [params setValue:[_profileDetail.birthDay stringValueFormattedBy:@"yyyy-MM-dd"] forKey:@"birthday"];
        
        NSDictionary *response;
        NSError *error;
        
        BOOL result =  [[QKRequestManager sharedManager] syncPOST:[NSString stringFromConst:qkCSUrlProfileRegist] parameters:params response:&response error:&error showLoading:YES showError:YES];
        if (result) {
            NSLog(@"Add profile success...");
            return result;
        }
        else {
            NSLog(@"Add profile fail...");
        }
    }
    else {
        [self showNoInternetViewWithSelector:nil];
    }
    return NO;
}

#pragma mark - action

- (NSString *)timeFormatted:(NSDate *)closingDt {
    NSTimeInterval timeInterval = [closingDt timeIntervalSinceDate:[NSDate date]];
    NSInteger totalSeconds = timeInterval;
    if (totalSeconds <= 0) {
        totalSeconds = 0;
    }
    int seconds = totalSeconds % 60;
    int minutes = (totalSeconds / 60) % 60;
    int hours = (totalSeconds / 3600) % 24;
    if (hours > 0) {
        return [NSString stringWithFormat:@"募集終了 まで :%02d時間%02d分%02d秒 ", hours, minutes, seconds];
    }
    else if (minutes > 0) {
        return [NSString stringWithFormat:@"募集終了 まで :%02d分%02d秒 ", minutes, seconds];
    }
    else {
        return [NSString stringWithFormat:@"募集終了 まで :%02d秒 ", seconds];
    }
}

- (void)confirmPassWordIfNeed {
    if (!_editProfile && self.mode == QKProfileModeEdit) {
        [self.view endEditing:YES];
        [self showAlertView];
    }
}

- (void)goBack:(id)sender {
    if (self.mode == QKProfileModeEdit) {
        [self callAPISaveProfile];
    }
    [super goBack:sender];
}

- (void)showAlertView {
    CCAlertView *confirmPassAlertView = [[CCAlertView alloc]initWithTitle:@"パスワードの確認" message:@"情報の閲覧、編集にはパスワードが必要です。" delegate:self buttonTitles:@[@"キャンセル", @"OK"] haveTextField:YES];
    confirmPassAlertView.tag = QKAlertViewModeConfirmPass;
    [confirmPassAlertView showAlert];
}

- (void)skipAddProfile {
    BOOL results = [self callAPISaveProfile];
    if (results) {
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        QKJobHistoryViewController *jobHistoryViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"QKJobHistoryViewController"];
        [self.navigationController pushViewController:jobHistoryViewController animated:YES];
    }
}

- (IBAction)creatProfileFinish:(id)sender {
    BOOL result = [self callAPISaveProfile];
    if (result) {
        [self getConfirmKey];
    }
}

- (void)genderChanged:(NSInteger)gender {
    if (!_editProfile && self.mode == QKProfileModeEdit) {
        self.currentField = QKProfileFieldGender;
        [self showAlertView];
        return;
    }
    _profileDetail.gender = gender;
}

- (void)textFieldChange:(UITextField *)textField {
    int index = (int)textField.tag;
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
            
        case 4:
            self.profileDetail.phoneNumber = textField.text;
            break;
            
        default:
            break;
    }
    [self enableFinishbutton];
}

- (void)textFieldBeginEdit:(UITextField *)textField {
    int index = (int)textField.tag;
    switch (index) {
        case 0:
            self.currentField = QKProfileFieldLastName;
            break;
            
        case 1:
            self.currentField = QKProfileFieldFistName;
            break;
            
        case 2:
            self.currentField = QKProfileFieldLastNameKana;
            break;
            
        case 3:
            self.currentField = QKProfileFieldFistNameKana;
            break;
            
        case 4:
            self.currentField = QKProfileFieldPhone;
            break;
            
        default:
            break;
    }
    self.currentTextField = textField;
    [self confirmPassWordIfNeed];
}

- (void)enableFinishbutton {
    if ([self checkAllField]) {
        [self.nextButton setEnabled:YES];
        [self.finishButton setEnabled:YES];
    }
    else {
        [self.nextButton setEnabled:NO];
        [self.finishButton setEnabled:NO];
    }
}

- (BOOL)checkAllField {
    BOOL result = NO;
    if (self.profileDetail.firstName.length > 0 &&
        self.profileDetail.lastName.length > 0 &&
        self.profileDetail.firstNameKana.length > 0 &&
        self.profileDetail.lastNameKana.length > 0 &&
        self.profileDetail.phoneNumber.length > 0 &&
        self.profileDetail.birthDay !=  nil &&
        self.profileDetail.occupation.length > 0
        ) {
        result = YES;
    }
    return result;
}

- (void)getConfirmKey {
    NSMutableDictionary *params = [NSMutableDictionary initWithApiKeyAndToken];
    [params setValue:[QKAccessUserDefaults getUserId] forKey:@"userId"];
    
    NSDictionary *response;
    NSError *error;
    BOOL result =  [[QKRequestManager sharedManager] syncPOST:[NSString stringFromConst:qkCSUrlSMSAuthSend] parameters:params response:&response error:&error showLoading:YES showError:YES];
    
    if (result) {
        NSLog(@" confirm key successful...");
        [self performSegueWithIdentifier:@"showConfirmKeySegue" sender:self];
    }
    else {
        NSLog(@" confirm key fail...");
    }
}

- (IBAction)policyClicked:(id)sender {
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    QKCSWebViewController *webViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"QKWebViewController"];
    webViewController.title = NSLocalizedString(@"プライバシーポリシー", nil);
    webViewController.stringURL = [NSString stringFromConst:qkCSUrlWebCopyright];
    [self.navigationController pushViewController:webViewController animated:YES];
}

- (IBAction)termOfUseClicked:(id)sender {
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    QKCSWebViewController *webViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"QKWebViewController"];
    webViewController.title = NSLocalizedString(@"利用規約", nil);
    webViewController.stringURL = [NSString stringFromConst:qkCSUrlWebAgreement];
    [self.navigationController pushViewController:webViewController animated:YES];
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showConfirmKeySegue"]) {
        QKConfirmKeyViewController *confirmViewController = (QKConfirmKeyViewController *)segue.destinationViewController;
        if (self.mode == QKProfileModeRecruitment) {
            confirmViewController.mode = QKConfirmKeyModeRecruitment;
            confirmViewController.timeLimitString = [self timeFormatted:_closingDate];
        }
        else if (self.mode == QKProfileModeEdit) {
            confirmViewController.mode = QKConfirmKeyModeEdit;
        }
        else {
            confirmViewController.mode = QKConfirmKeyModeNormal;
        }
    }
}

#pragma mark - tableview delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
    }
    else if (section == 1) {
        return 2;
    }
    else if (section == 2) {
        if (_showPhoneNumAuthenCell) {
            return 2;
        }
        else {
            return 1;
        }
    }
    else if (section == 3) {
        return 1;
    }
    else if (section == 4) {
        return 1;
    }
    else if (section == 5) {
        return 1;
    }
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 6;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 3 && indexPath.row == 0) {
        if (!_editProfile && self.mode == QKProfileModeEdit) {
            self.currentField = QKProfileFieldBirtday;
            [self showAlertView];
        }
        else {
            [self makeBirthDayDatePicker];
        }
    }
    if (indexPath.section == 5 && indexPath.row == 0) {
        if (!_editProfile && self.mode == QKProfileModeEdit) {
            self.currentField = QKProfileFieldOccupation;
            [self showAlertView];
        }
        else {
            [self makeSortTypePickerView];
        }
    }
    if (indexPath.section == 2 && indexPath.row == 1) {
        if (_profileDetail.phoneNumber.length > 0) {
            [self creatProfileFinish:nil];
        }
    }
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    UITableViewHeaderFooterView *v = (UITableViewHeaderFooterView *)view;
    v.backgroundView.backgroundColor = kQKGlobalBackgroundGrayBlueColor;
    [v.textLabel setFont:[UIFont systemFontOfSize:15.0]];
    if (section == 3) {
        UILabel *invoiceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(v.frame), 30.0)];
        invoiceLabel.textAlignment = NSTextAlignmentCenter;
        invoiceLabel.tag = 1000;
        invoiceLabel.text = NSLocalizedString(@"※あなたを採用した勤務先が連絡を取る際に利用します", nil);
        invoiceLabel.textColor = [UIColor darkGrayColor];
        invoiceLabel.font = [UIFont systemFontOfSize:10.0];
        [v addSubview:invoiceLabel];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    QKTittleAndTextFieldTableViewCell *titleAndTextFieldcell = (QKTittleAndTextFieldTableViewCell *)[tableView dequeueReusableCellWithIdentifier:ProfileCellIdentifier];
    if (!titleAndTextFieldcell) {
        titleAndTextFieldcell = [UIView loadFromNibNamed:@"QKTittleAndTextFieldTableViewCell"];
    }
    [titleAndTextFieldcell.textField addTarget:self action:@selector(textFieldChange:) forControlEvents:UIControlEventEditingChanged];
    [titleAndTextFieldcell.textField addTarget:self action:@selector(textFieldBeginEdit:) forControlEvents:UIControlEventEditingDidBegin];
    titleAndTextFieldcell.accessoryView = nil;
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            titleAndTextFieldcell.titleLabel.text = @"氏";
            titleAndTextFieldcell.textField.tag = 0;
            titleAndTextFieldcell.textField.placeholder = @"山田";
            
            if (_profileDetail.lastName != nil && _profileDetail.lastName.length > 0) {
                titleAndTextFieldcell.textField.text = _profileDetail.lastName;
            }
            cell = titleAndTextFieldcell;
        }
        else {
            titleAndTextFieldcell.titleLabel.text = @"名";
            titleAndTextFieldcell.textField.tag = 1;
            titleAndTextFieldcell.textField.placeholder = @"太郎";
            if (_profileDetail.firstName != nil && _profileDetail.firstName.length > 0) {
                titleAndTextFieldcell.textField.text = _profileDetail.firstName;
            }
            cell = titleAndTextFieldcell;
        }
    }
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            titleAndTextFieldcell.titleLabel.text = @"シ";
            titleAndTextFieldcell.textField.tag = 2;
            titleAndTextFieldcell.textField.placeholder = @"ヤマダ";
            if (_profileDetail.lastNameKana != nil && _profileDetail.lastNameKana.length > 0) {
                titleAndTextFieldcell.textField.text = _profileDetail.lastNameKana;
            }
            
            cell = titleAndTextFieldcell;
        }
        else {
            titleAndTextFieldcell.titleLabel.text = @"メイ";
            titleAndTextFieldcell.textField.tag = 3;
            titleAndTextFieldcell.textField.placeholder = @"タロウ";
            if (_profileDetail.firstNameKana != nil && _profileDetail.firstNameKana.length > 0) {
                titleAndTextFieldcell.textField.text = _profileDetail.firstNameKana;
            }
            cell = titleAndTextFieldcell;
        }
    }
    
    if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            titleAndTextFieldcell.titleLabel.text = @"携帯電話";
            titleAndTextFieldcell.textField.tag = 4;
            [titleAndTextFieldcell.textField setKeyboardType:UIKeyboardTypePhonePad];
            titleAndTextFieldcell.textField.placeholder = @"08012345678";
            if (_profileDetail.phoneNumber != nil && _profileDetail.phoneNumber.length > 0) {
                titleAndTextFieldcell.textField.text = _profileDetail.phoneNumber;
            }
            
            cell = titleAndTextFieldcell;
        }
        else {
            if (_showPhoneNumAuthenCell) {
                QKPhoneAuthenTableViewCell *phoneAuthenCell = (QKPhoneAuthenTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"QKPhoneAuthenTableViewCell"];
                if (!phoneAuthenCell) {
                    phoneAuthenCell = [UIView loadFromNibNamed:@"QKPhoneAuthenTableViewCell"];
                }
                cell = phoneAuthenCell;
            }
        }
    }
    if (indexPath.section == 3) {
        titleAndTextFieldcell.titleLabel.text = @"生年月日";
        titleAndTextFieldcell.textField.tag = 5;
        [titleAndTextFieldcell.textField setEnabled:NO];
        titleAndTextFieldcell.textField.placeholder = @"選択してください";
        NSString *dateString = [_profileDetail.birthDay stringValueFormattedBy:@"yyyy年MM月dd日"];
        
        if (_profileDetail.birthDay != nil) {
            titleAndTextFieldcell.textField.text = dateString;
        }
        cell = titleAndTextFieldcell;
    }
    if (indexPath.section == 4) {
        QKGenderTableViewCell *genderCell = (QKGenderTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"QKGenderTableViewCell"];
        if (!genderCell) {
            genderCell = [UIView loadFromNibNamed:@"QKGenderTableViewCell"];
            genderCell.delegate = self;
        }
        if (_profileDetail.gender == 0) {
            _profileDetail.gender = 2;
        }
        genderCell.gender = _profileDetail.gender;
        if (!_editProfile && self.mode == QKProfileModeEdit) {
            genderCell.disableGender = YES;
        }
        cell = genderCell;
    }
    if (indexPath.section == 5) {
        if (!titleAndTextFieldcell) {
            titleAndTextFieldcell = [UIView loadFromNibNamed:@"QKTittleAndTextFieldTableViewCell"];
        }
        
        titleAndTextFieldcell.titleLabel.text = @"現在の職業";
        titleAndTextFieldcell.textField.tag = 6;
        titleAndTextFieldcell.textField.enabled = NO;
        titleAndTextFieldcell.textField.placeholder = @"選択してください";
        
        if (_profileDetail.occupation != nil & _profileDetail.occupation.length > 0) {
            titleAndTextFieldcell.textField.text = [[QKConst OCCUPATION_MAP] objectForKey:_profileDetail.occupation];
        }
        
        cell = titleAndTextFieldcell;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 4 && indexPath.row == 0) {
        return 60;
    }
    else {
        return 50;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 40;
    }
    else if (section == 1) {
        return 60;
    }
    else if (section == 2) {
        return 30;
    }
    else if (section == 3) {
        return 50;
    }
    else {
        return 0;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return @"氏名(漢字)";
            
        case 1:
            return @"氏名(カナ）";
            
        case 2:
            return @"";
            
        case 3:
            return @"";
            
        default:
            break;
    }
    return nil;
}

#pragma mark - alert view

- (void)alertView:(CCAlertView *)alertView selectedButtonIndex:(NSInteger)index {
    if (alertView.tag == QKAlertViewModeConfirmPass) {
        if (index == 1) {
            self.passWord = alertView.textField.text;
            [self checkPassWord];
        }
    }
    if (alertView.tag == QKAlertViewModeWrongPass) {
        if (index == 1) {
            [self showAlertView];
        }
    }
}

- (void)checkPassWord {
    if ([self connected]) {
        NSMutableDictionary *params = [NSMutableDictionary initWithApiKeyAndToken];
        [params setObject:[QKAccessUserDefaults getUserId] forKey:@"userId"];
        [params setObject:[QKEncryptUtil encyptBlowfish:self.passWord] forKey:@"password"];
        NSDictionary *response;
        NSError *error;
        BOOL result =  [[QKRequestManager sharedManager] syncPOST:[NSString stringFromConst:qkCSUrlAccountDelete] parameters:params response:&response error:&error showLoading:YES showError:NO];
        
        if (result) {
            [self confirmPassWordSuccess];
        }
        else {
            CCAlertView *wrongPassAlert = [[CCAlertView alloc]initWithTitle:@"パスワードが違います" message:nil delegate:self buttonTitles:@[@"キャンセル", @"再施行"]];
            wrongPassAlert.tag = QKAlertViewModeWrongPass;
            [wrongPassAlert showAlert];
        }
    }
    else {
        [self showNoInternetViewWithSelector:nil];
    }
}

- (void)confirmPassWordSuccess {
    _editProfile = YES;
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:4] withRowAnimation:UITableViewRowAnimationNone];
    switch (self.currentField) {
        case QKProfileFieldFistName:
            [_currentTextField becomeFirstResponder];
            break;
            
        case QKProfileFieldLastName:
            [_currentTextField becomeFirstResponder];
            break;
            
        case QKProfileFieldFistNameKana:
            [_currentTextField becomeFirstResponder];
            break;
            
        case QKProfileFieldLastNameKana:
            [_currentTextField becomeFirstResponder];
            break;
            
        case QKProfileFieldPhone:
            [_currentTextField becomeFirstResponder];
            break;
            
        case QKProfileFieldBirtday:
            [self makeBirthDayDatePicker];
            break;
            
        case QKProfileFieldGender: {
            QKGenderTableViewCell *cell = (QKGenderTableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:4]];
            cell.disableGender = NO;
            [cell changeGender];
            break;
        }
            
        case QKProfileFieldOccupation:
            [self makeSortTypePickerView];
            break;
            
        default:
            break;
    }
}

@end

//
//  QKRecruitmentDetailViewController.m
//  quicker-cs-ios
//
//  Created by LongPD-PC on 5/12/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKRecruitmentDetailViewController.h"
#import "QKCreatProfileViewController.h"
#import "QKJobHistoryModel.h"
#import "QKJobHistoryViewController.h"
#import "QKRecruitmentQuestionNewViewController.h"
#import "QKCSMessageViewController.h"
#import "QKCSWebViewController.h"
#import "QKCSPastRecuitmentViewController.h"

@interface QKRecruitmentDetailViewController () <UITableViewDelegate>
@property (strong, nonatomic) CCAlertView *duplicateAlv;
@property (strong, nonatomic) CCAlertView *accessRecAlv;
@property (strong, nonatomic) CCAlertView *callEmergencyAlv;
@property (strong, nonatomic) CCAlertView *cancelApplicantConfirmAlv;
@property (weak, nonatomic) IBOutlet QKF51Label *countDownLabel;

@property (weak, nonatomic) IBOutlet UIView *footerView;
@property (weak, nonatomic) IBOutlet QKGlobalPrimaryButton *smallMessageButton;
@property (weak, nonatomic) IBOutlet QKGlobalSecondaryButton *bigMessageButton;
@property (strong, nonatomic) UILabel *timeLabel;
@property (nonatomic) BOOL isMultiApplication;
@property (strong, nonatomic) NSTimer *countDownTimer;
@property (nonatomic) qkcsWebViewType webviewType;
@end

@implementation QKRecruitmentDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = self.recruitment.shopInfo.name;
    [self setAngleLeftBarButton];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didConfirmKey)
                                                 name:@"confirmKey"
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateCVCompleted)
                                                 name:@"updateEditCV"
                                               object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getRecruitmentModel];
}

- (void)updateCVCompleted {
    [self setTableViewHeader];
}

- (void)setKeepButton {
    if (self.recruitmentState == QKRecruitmentStateActiveNoOffer) {
        NSString *nameImage;
        if (self.recruitment.isKept) {
            nameImage = @"nav_keep_active";
            [self setRightBarButtonWithImage:[UIImage imageNamed:nameImage] target:@selector(unKeepRec)];
        }
        else {
            nameImage = @"nav_keep_inactive";
            [self setRightBarButtonWithImage:[UIImage imageNamed:nameImage] target:@selector(keepRec)];
        }
    }
    else {
        [self.navigationItem setRightBarButtonItem:nil];
    }
}

- (void)didConfirmKey {
    [self checkMultiApplication:self.isMultiApplication];
}

- (void)getRecruitmentModel {
    if ([self connected]) {
        NSMutableDictionary *params = [NSMutableDictionary initWithApiKeyAndToken];
        [params setObject:[QKAccessUserDefaults getUserId] forKey:@"userId"];
        [params setObject:self.recruitment.recruitmentId forKey:@"recruitmentId"];
        
        [[QKRequestManager sharedManager] asyncGET:[NSString stringFromConst:qkCSUrlRecruitmentDetail] parameters:params showLoading:YES showError:YES success: ^(AFHTTPRequestOperation *operation, id responseObject) {
            if ([responseObject[QK_API_STATUS_CODE] isEqualToString:[NSString stringFromConst:QK_STT_CODE_SUCCESS]]) {
                self.recruitment = [[QKRecruitmentModel alloc] initWithResponse:responseObject];
                [self refreshView];
            }
        } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
        }];
    }
    else {
        [self showNoInternetViewWithSelector:@selector(getRecruitmentModel)];
    }
}

- (void)setTableViewHeader {
    UITableViewCell *cell;
    float height;
    self.footerView.hidden = YES;
    switch (self.recruitmentState) {
        case QKRecruitmentStateActiveNoOffer:
        {
            // C-01-1
            break;
        }
            
        case QKRecruitmentStateDoneNoOffer: {
            // C-01-2
            cell = [self.tableView dequeueReusableCellWithIdentifier:@"QKRecruitmentStateDoneNoOffer"];
            height = 120.0;
            UIButton *button = (UIButton *)[cell.contentView viewWithTag:100];
            [button addTarget:self action:@selector(registerToShop) forControlEvents:UIControlEventTouchUpInside];
            break;
        }
            
        case QKRecruitmentStateActiveOfferDone: {
            // C-01-3
            cell = [self.tableView dequeueReusableCellWithIdentifier:@"QKRecruitmentStateActiveOfferDone"];
            height =  190.0;
            UIButton *button = (UIButton *)[cell.contentView viewWithTag:100];
            [button addTarget:self action:@selector(cancelRegist) forControlEvents:UIControlEventTouchUpInside];
            self.timeLabel = (UILabel *)[cell.contentView viewWithTag:101];
            [self countDownLabelUpdate];
            break;
        }
            
        case QKRecruitmentStateDoneOfferDone: {
            // C-01-4
            cell = [self.tableView dequeueReusableCellWithIdentifier:@"QKRecruitmentStateActiveOfferDone"];
            height = 190.0;
            break;
        }
            
        case QKRecruitmentStateOfferDoneNG: {
            // C-01-5
            cell = [self.tableView dequeueReusableCellWithIdentifier:@"QKRecruitmentStateOfferDoneNG"];
            height = 75.0;
            break;
        }
            
        case QKRecruitmentStateOfferDoneOKBefore: {
            //C-01-6
            cell = [self.tableView dequeueReusableCellWithIdentifier:@"QKRecruitmentStateOfferDoneOKBefore"];
            height = 167.0;
            self.footerView.hidden = NO;
            NSString *title = [NSString stringWithFormat:@"%@(%d)",NSLocalizedString(@"メッセージ", nil),self.recruitment.unreadMessageCount];
            [self.smallMessageButton setTitle:title forState:UIControlStateNormal];
            [self.smallMessageButton setTitle:title forState:UIControlStateSelected];
            self.bigMessageButton.hidden = YES;
            break;
        }
            
        case QKRecruitmentStateOfferDoneOKSalary: {
            //C-01-7
            cell = [self.tableView dequeueReusableCellWithIdentifier:@"QKRecruitmentStateOfferDoneOKSalary"];
            height = 127.0;
            self.footerView.hidden = NO;
            self.bigMessageButton.hidden = NO;
            self.smallMessageButton.hidden = YES;
            NSString *title = [NSString stringWithFormat:@"%@(%d)",NSLocalizedString(@"メッセージ", nil),self.recruitment.unreadMessageCount];
            [self.bigMessageButton setTitle:title forState:UIControlStateNormal];
            [self.bigMessageButton setTitle:title forState:UIControlStateSelected];
            break;
        }
            
        case QKRecruitmentStateOfferDoneOKAfter: {
            //C-01-8
            cell = [self.tableView dequeueReusableCellWithIdentifier:@"QKRecruitmentStateOfferDoneOKAfter"];
            height = 75.0;
            break;
        }
            
        default:
            break;
    }
    UIView *headerView = cell.contentView;
    CGRect frame = cell.contentView.frame;
    frame.size.height = height;
    headerView.frame = frame;
    self.tableView.tableHeaderView = headerView;
}

- (void)setTableFooterView {
    if (self.recruitmentState != QKRecruitmentStateActiveNoOffer) {
        self.tableView.tableFooterView = nil;
    }
    else {
        self.tableView.tableFooterView = _applyView;
    }
}

- (void)refreshView {
    [self updateCountDownLabel];
    self.navigationItem.title = self.recruitment.shopInfo.name;
    [self getRecruitmentState];
    [self setTableViewHeader];
    [self setTableFooterView];
    [self.tableView reloadData];
    if (!_isWorkHistorycontroller) {
        [self setKeepButton];
    }
}

- (void)getRecruitmentState {
    if ([_recruitment.recruitmentStatus isEqualToString:@"05"]) {
        if ([_recruitment.applicantStatus isEqualToString:@"00"]) {
            //C-01-3
            self.recruitmentState = QKRecruitmentStateActiveOfferDone;
        }
        else if (![self checkHasValue:_recruitment.applicantStatus]) {
            //C-01-1
            self.recruitmentState = QKRecruitmentStateActiveNoOffer;
        }
        else if ([_recruitment.applicantStatus isEqualToString:@"20"] ||
                 [_recruitment.applicantStatus isEqualToString:@"30"] ||
                 [_recruitment.applicantStatus isEqualToString:@"35"] ||
                 [_recruitment.applicantStatus isEqualToString:@"40"]) {
            //C-01-5
            self.recruitmentState = QKRecruitmentStateOfferDoneNG;
        }
        else if ([_recruitment.applicantStatus isEqualToString:@"10"]) {
            // C01-6
            self.recruitmentState = QKRecruitmentStateOfferDoneOKBefore;
        }
    }
    else if ([_recruitment.recruitmentStatus isEqualToString:@"10"]) {
        // C01-2
        self.recruitmentState = QKRecruitmentStateDoneNoOffer;
    }
    else if ([_recruitment.recruitmentStatus isEqualToString:@"30"] ||
             [_recruitment.recruitmentStatus isEqualToString:@"40"] ||
             [_recruitment.recruitmentStatus isEqualToString:@"50"]) {
        if (![self checkHasValue:_recruitment.applicantStatus]) {
            // C01-2
            self.recruitmentState = QKRecruitmentStateDoneNoOffer;
        }
        else if ([_recruitment.applicantStatus isEqualToString:@"20"] ||
                 [_recruitment.applicantStatus isEqualToString:@"30"] ||
                 [_recruitment.applicantStatus isEqualToString:@"35"] ||
                 [_recruitment.applicantStatus isEqualToString:@"40"]) {
            //C-01-5
            self.recruitmentState = QKRecruitmentStateOfferDoneNG;
        }
        else if ([_recruitment.applicantStatus isEqualToString:@"10"]) {
            if ([_recruitment.employmentStatus isEqualToString:@"00"]) {
                if (![self checkHasValue:_recruitment.workActualStatus]) {
                    //C01-6
                    self.recruitmentState = QKRecruitmentStateOfferDoneOKBefore;
                }
                else if ([_recruitment.workActualStatus isEqualToString:@"10"] ||
                         [_recruitment.workActualStatus isEqualToString:@"25"]) {
                    //C01-8
                    self.recruitmentState = QKRecruitmentStateOfferDoneNG;
                }
                else if ([_recruitment.workActualStatus isEqualToString:@"00"] ||
                         [_recruitment.workActualStatus isEqualToString:@"20"]) {
                    //C01-7
                    self.recruitmentState = QKRecruitmentStateOfferDoneOKSalary;
                }
            }
            else if ([_recruitment.employmentStatus isEqualToString:@"10"] ||
                     [_recruitment.employmentStatus isEqualToString:@"20"] ||
                     [_recruitment.employmentStatus isEqualToString:@"30"]) {
                // new screen
            }
        }
    }
    
    //    // C-01-1
    //    if ([_recruitment.recruitmentStatus isEqualToString:@"05"] &&
    //        (![self checkHasValue:_recruitment.applicantStatus])) {
    //        self.recruitmentState = QKRecruitmentStateActiveNoOffer;
    //        return;
    //    }
    //
    //    // C-01-2
    //    if ([_recruitment.recruitmentStatus isEqualToString:@"10"] ||
    //        (([_recruitment.recruitmentStatus isEqualToString:@"30"] ||
    //         [_recruitment.recruitmentStatus isEqualToString:@"40"] ||
    //          [_recruitment.recruitmentStatus isEqualToString:@"50"] ))) {
    //        self.recruitmentState = QKRecruitmentStateDoneNoOffer;
    //        return;
    //    }
    //
    //    // C-01-3
    //    if ([_recruitment.recruitmentStatus isEqualToString:@"05"] &&
    //        [_recruitment.applicantStatus isEqualToString:@"00"] &&
    //        ![self checkHasValue:_recruitment.transferStatus]) {
    //        self.recruitmentState = QKRecruitmentStateActiveOfferDone;
    //        return;
    //    }
    //
    //    // C-01-4
    //    if (([_recruitment.recruitmentStatus isEqualToString:@"30"] || [_recruitment.recruitmentStatus isEqualToString:@"40"])&&
    //        [_recruitment.applicantStatus isEqualToString:@"00"] &&
    //        ![self checkHasValue:_recruitment.transferStatus]) {
    //        self.recruitmentState = QKRecruitmentStateDoneOfferDone;
    //        return;
    //    }
    //
    //    // C-01-5
    //    if (([_recruitment.recruitmentStatus isEqualToString:@"30"] || [_recruitment.recruitmentStatus isEqualToString:@"40"]|| [_recruitment.recruitmentStatus isEqualToString:@"05"])&&
    //        [_recruitment.applicantStatus isEqualToString:@"20"] &&
    //        ![self checkHasValue:_recruitment.transferStatus]) {
    //        self.recruitmentState = QKRecruitmentStateOfferDoneNG;
    //        return;
    //    }
    //
    //    // C-01-6
    //    if (([_recruitment.recruitmentStatus isEqualToString:@"30"] || [_recruitment.recruitmentStatus isEqualToString:@"40"]|| [_recruitment.recruitmentStatus isEqualToString:@"05"])&&
    //        [_recruitment.applicantStatus isEqualToString:@"10"] &&
    //        ![self checkHasValue:_recruitment.transferStatus]) {
    //        self.recruitmentState = QKRecruitmentStateOfferDoneOKBefore;
    //        return;
    //    }
    //
    //    // C-01-7
    //    if (([_recruitment.recruitmentStatus isEqualToString:@"30"] || [_recruitment.recruitmentStatus isEqualToString:@"40"])&&
    //        [_recruitment.applicantStatus isEqualToString:@"10"] &&
    //        ![_recruitment.transferStatus isEqualToString:@"40"]) {
    //        self.recruitmentState = QKRecruitmentStateOfferDoneOKSalary;
    //        return;
    //    }
    //    // C-01-8
    //    if (([_recruitment.recruitmentStatus isEqualToString:@"30"] || [_recruitment.recruitmentStatus isEqualToString:@"40"])&&
    //        [_recruitment.applicantStatus isEqualToString:@"20"] &&
    //        [_recruitment.transferStatus isEqualToString:@"40"]) {
    //        self.recruitmentState = QKRecruitmentStateOfferDoneNG;
    //        return;
    //    }
}

- (BOOL)checkHasValue:(NSString *)string {
    if (!string) {
        return NO;
    }
    if ([string isEqualToString:@""]) {
        return NO;
    }
    return YES;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

#pragma TableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    if (indexPath.row == 0) {
        QKScrollImageCell *cell = (QKScrollImageCell *)[tableView dequeueReusableCellWithIdentifier:@"QKScrollImageViewCell"];
        cell.listImages = self.recruitment.imageList;
        return cell;
    }
    else if (indexPath.row == 1) {
        QKAboutJobTableViewCell *cell = (QKAboutJobTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"QKAboutJobTableViewCell"];
        if (cell == nil) {
            cell = [[QKAboutJobTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"QKAboutJobTableViewCell"];
        }
        cell.jobEntity = self.recruitment;
        return cell;
    }
    else if (indexPath.row == 2) {
        QKJobDescriptionTableViewCell *cell = (QKJobDescriptionTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"QKJobDescriptionTableViewCell"];
        if (cell == nil) {
            cell = [[QKJobDescriptionTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"QKJobDescriptionTableViewCell"];
        }
        cell.jobEntity = self.recruitment;
        return cell;
    }
    else if (indexPath.row == 3) {
        QKListQACell *cell = (QKListQACell *)[tableView dequeueReusableCellWithIdentifier:@"QKListQACell"];
        if (cell == nil) {
            cell = [[QKListQACell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"QKListQACell"];
        }
        NSMutableArray *listQA = [[NSMutableArray alloc] initWithArray:self.recruitment.unansweredQaList];
        [listQA addObjectsFromArray:self.recruitment.answeredQaList];
        cell.listQA = listQA;
        return cell;
    }
    else if (indexPath.row == 4) {
        QKjobOptionRecordTableViewCell *cell = (QKjobOptionRecordTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"QKjobOptionRecordTableViewCell"];
        if (cell == nil) {
            cell = [[QKjobOptionRecordTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"QKjobOptionRecordTableViewCell"];
        }
        cell.jobEntity = self.recruitment;
        return cell;
    }
    else if (indexPath.row == 5) {
        QKShopDescriptionTableViewCell *cell = (QKShopDescriptionTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"QKShopDescriptionTableViewCell"];
        if (cell == nil) {
            cell = [[QKShopDescriptionTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"QKShopDescriptionTableViewCell"];
        }
        cell.jobEntity = self.recruitment;
        return cell;
    }
    else if (indexPath.row == 6) {
        QKJobLocationTableViewCell *cell = (QKJobLocationTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"QKJobLocationTableViewCell"];
        if (cell == nil) {
            cell = [[QKJobLocationTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"QKJobLocationTableViewCell"];
        }
        cell.jobEntity = self.recruitment;
        return cell;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 4:
            // E 1-1
            [self performSegueWithIdentifier:@"QKCSPastRecuitmentSegue" sender:self];
            break;
        default:
            break;
    }
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 4) {
        return indexPath;
    }
    else return nil;
}

- (NSIndexPath *)tableView:(UITableView *)tableView willDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 4) {
        return nil;
    }
    return indexPath;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.0;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    float witdh = [UIApplication sharedApplication].keyWindow.frame.size.width;
    if (indexPath.row == 0) {
        return witdh * 2 / 3;
    }
    else if (indexPath.row == 1) {
        QKAboutJobTableViewCell *cell = (QKAboutJobTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"QKAboutJobTableViewCell"];
        if (cell == nil) {
            cell = [[QKAboutJobTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"QKAboutJobTableViewCell"];
        }
        cell.jobEntity = self.recruitment;
        return [self calculateHeightForConfiguredSizingCell:cell];
    }
    else if (indexPath.row == 2) {
        QKJobDescriptionTableViewCell *cell = (QKJobDescriptionTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"QKJobDescriptionTableViewCell"];
        if (cell == nil) {
            cell = [[QKJobDescriptionTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"QKJobDescriptionTableViewCell"];
        }
        cell.jobEntity = self.recruitment;
        return [self calculateHeightForConfiguredSizingCell:cell];
    }
    else if (indexPath.row == 3) {
        QKListQACell *cell = (QKListQACell *)[tableView dequeueReusableCellWithIdentifier:@"QKListQACell"];
        if (cell == nil) {
            cell = [[QKListQACell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"QKListQACell"];
        }
        NSMutableArray *listQA = [[NSMutableArray alloc] initWithArray:self.recruitment.unansweredQaList];
        [listQA addObjectsFromArray:self.recruitment.answeredQaList];
        cell.listQA = listQA;
        if (self.recruitmentState == QKRecruitmentStateOfferDoneOKSalary ||
            self.recruitmentState == QKRecruitmentStateOfferDoneOKAfter) {
            return ([self calculateHeightForConfiguredSizingCell:cell] - 65);
        }
        else
            return [self calculateHeightForConfiguredSizingCell:cell];
    }
    else if (indexPath.row == 4) {
        return 81;
    }
    else if (indexPath.row == 5) {
        QKShopDescriptionTableViewCell *cell = (QKShopDescriptionTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"QKShopDescriptionTableViewCell"];
        if (cell == nil) {
            cell = [[QKShopDescriptionTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"QKShopDescriptionTableViewCell"];
        }
        cell.jobEntity = self.recruitment;
        
        return [self calculateHeightForConfiguredSizingCell:cell];
    }
    else if (indexPath.row == 6) {
        QKJobLocationTableViewCell *cell = (QKJobLocationTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"QKJobLocationTableViewCell"];
        if (cell == nil) {
            cell = [[QKJobLocationTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"QKJobLocationTableViewCell"];
        }
        cell.jobEntity = self.recruitment;
        return [self calculateHeightForConfiguredSizingCell:cell];
    }
    return 0.0;
}

#pragma mark - action
- (IBAction)recruitmentSelected:(id)sender {
    [self checkAppliAble];
}

- (IBAction)gotoMesageViewController:(id)sender {
    [self setHidesBottomBarWhenPushed:YES];
    [self performSegueWithIdentifier:@"ShowMessageSegue" sender:nil];
    [self setHidesBottomBarWhenPushed:NO];
}

- (IBAction)makeAEmergencyPhone:(id)sender {
    self.callEmergencyAlv = [[CCAlertView alloc] initWithTitle:@"このお店へ電話をかけます\n03-1234-5678" message:@"(※緊急時のみ使用してください）" delegate:self buttonTitles:@[@"やめる", @"発信"]];
    [self.callEmergencyAlv showAlert];
}

- (IBAction)cancelApplicant:(id)sender {
    self.cancelApplicantConfirmAlv = [[CCAlertView alloc] initWithTitle:@"応募をキャンセルしますか？" message:nil delegate:self buttonTitles:@[@"やめる", @"キャンセルする"]];
    [self.cancelApplicantConfirmAlv showAlert];
}

#pragma mark - Action getProfile
- (void)checkAppliAble {
    if ([self connected]) {
        NSMutableDictionary *params = [NSMutableDictionary initWithApiKeyAndToken];
        [params setObject:[QKAccessUserDefaults getUserId] forKey:@"userId"];
        [params setObject:self.recruitment.recruitmentId forKey:@"recruitmentId"];
        [[QKRequestManager sharedManager] asyncGET:[NSString stringFromConst:qkCSUrlAppliAble] parameters:params showLoading:YES showError:YES success: ^(AFHTTPRequestOperation *operation, id responseObject) {
            if ([responseObject[QK_API_STATUS_CODE] isEqualToString:[NSString stringFromConst:QK_STT_CODE_SUCCESS]]) {
                self.isMultiApplication = [responseObject boolForKey:@"isMultiApplication"];
                
                if (![responseObject boolForKey:@"isProfileFilled"]) {
                    [self showCreateProfile];
                }
                else {
                    [self checkMultiApplication:self.isMultiApplication];
                }
            }
        } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"responseObject : %@ ", error);
        }];
    }
    else {
        [self showNoInternetViewWithSelector:@selector(checkAppliAble)];
    }
}

#pragma mark -

- (void)showCreateProfile {
    [self performSegueWithIdentifier:@"QKRecruitmentSelectedSegue" sender:self];
}

- (void)checkMultiApplication:(BOOL)isMultiApplication {
    if (isMultiApplication) {
        _duplicateAlv = [[CCAlertView alloc] initWithTitle:@"勤務時間が重複しています" message:@"同日時に重複して応募する場合、採用が\n先に決まったバイトが優先されます。" delegate:self buttonTitles:@[@"やめる", @"OK"]];
        [_duplicateAlv showAlert];
    }
    else {
        QKConfirmApplyRecAlertView *confirmRecAlv = [[QKConfirmApplyRecAlertView alloc] initConfirmApplyRecAlertView];
        confirmRecAlv.closingDate = self.recruitment.closingDt;
        [confirmRecAlv.termsOfServiceButton addTarget:self action:@selector(showTermsOfServiece) forControlEvents:UIControlEventTouchUpInside];
        [confirmRecAlv.privacyPolicyButton addTarget:self action:@selector(showPrivacyPolicy) forControlEvents:UIControlEventTouchUpInside];
        [confirmRecAlv.applicantsAcceptButton addTarget:self action:@selector(acceptApplicants) forControlEvents:UIControlEventTouchUpInside];
        [confirmRecAlv showAlert];
    }
}

#pragma mark - Caculate Cell Height


- (CGFloat)calculateHeightForConfiguredSizingCell:(UITableViewCell *)sizingCell {
    sizingCell.bounds = CGRectMake(0.0f, 0.0f, CGRectGetWidth(self.tableView.frame), CGRectGetHeight(sizingCell.bounds));
    
    [sizingCell setNeedsLayout];
    [sizingCell layoutIfNeeded];
    
    CGSize size = [sizingCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return size.height + 1.0f; // Add 1.0f for the cell separator height
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"QKRecruitmentSelectedSegue"]) {
        QKCreatProfileViewController *creatProfileViewController = (QKCreatProfileViewController *)segue.destinationViewController;
        creatProfileViewController.mode = QKCVModeRecruitment;
        creatProfileViewController.closingDate = _recruitment.closingDt;
    }
    else if ([segue.identifier isEqualToString:@"QKRecruitmentHavedCVSegue"]) {
        QKJobHistoryViewController *jobHistoryViewController = (QKJobHistoryViewController *)segue.destinationViewController;
        jobHistoryViewController.recruitmentModel = self.recruitment;
        jobHistoryViewController.mode = QKCVModeRecruitment;
    }
    else if ([segue.identifier isEqualToString:@"QKQuestionModalSegue"]) {
        UINavigationController *nav = [segue destinationViewController];
        QKRecruitmentQuestionNewViewController *questionViewController = (QKRecruitmentQuestionNewViewController *)nav.viewControllers[0];
        questionViewController.recruimentId = self.recruitment.recruitmentId;
    }
    else if ([segue.identifier isEqualToString:@"ShowMessageSegue"]) {
        QKCSMessageViewController *mesVC = (QKCSMessageViewController *)[segue destinationViewController];
        mesVC.recruimentId = self.recruitment.recruitmentId;
    }
    else if ([segue.identifier isEqualToString:@"QKShowWebViewSegue"]) {
        QKCSWebViewController *webviewController = (QKCSWebViewController *)[segue destinationViewController];
        if (self.webviewType == qkcsWebViewTypeTermOfService) {
            webviewController.title = NSLocalizedString(@"利用規約", nil);
            webviewController.stringURL = [NSString stringFromConst:qkCSUrlWebAgreement];
        }
        else if (self.webviewType == qkcsWebViewTypePolicy) {
            webviewController.title = NSLocalizedString(@"プライバシーポリシー", nil);
            webviewController.stringURL = [NSString stringFromConst:qkCSUrlWebCopyright];
        }
    }
    else if ([segue.identifier isEqualToString:@"QKCSPastRecuitmentSegue"]) {
        QKCSPastRecuitmentViewController *pastRecruitmentController = (QKCSPastRecuitmentViewController *)[segue destinationViewController];
        pastRecruitmentController.recruitmentModel = _recruitment;
    }
}

#pragma mark - Event in table headerView

- (void)registerToShop {
}

- (void)cancelRegist {
}

#pragma mark - IBAction

- (void)showTermsOfServiece {
    self.webviewType = qkcsWebViewTypeTermOfService;
    [self performSegueWithIdentifier:@"QKShowWebViewSegue" sender:nil];
}

- (void)showPrivacyPolicy {
    self.webviewType = qkcsWebViewTypePolicy;
    [self performSegueWithIdentifier:@"QKShowWebViewSegue" sender:nil];
}

- (void)acceptApplicants {
    if ([self connected]) {
        NSMutableDictionary *params = [NSMutableDictionary initWithApiKeyAndToken];
        [params setObject:[QKAccessUserDefaults getUserId] forKey:@"userId"];
        [params setObject:self.recruitment.recruitmentId forKey:@"recruitmentId"];
        
        [[QKRequestManager sharedManager] asyncGET:[NSString stringFromConst:qkCSUrlApplicationRegist] parameters:params showLoading:YES showError:YES success: ^(AFHTTPRequestOperation *operation, id responseObject) {
            if ([responseObject[QK_API_STATUS_CODE] isEqualToString:[NSString stringFromConst:QK_STT_CODE_SUCCESS]]) {
                NSMutableDictionary *params = [NSMutableDictionary initWithApiKeyAndToken];
                [params setObject:[QKAccessUserDefaults getUserId] forKey:@"userId"];
                [[QKRequestManager sharedManager] asyncGET:[NSString stringFromConst:qkCSUrlProfileDetail] parameters:params showLoading:YES showError:YES success: ^(AFHTTPRequestOperation *operation, id responseObject) {
                    if ([responseObject[QK_API_STATUS_CODE] isEqualToString:[NSString stringFromConst:QK_STT_CODE_SUCCESS]]) {
                        NSMutableDictionary *params = [NSMutableDictionary initWithApiKeyAndToken];
                        [params setObject:[QKAccessUserDefaults getUserId] forKey:@"userId"];
                        [[QKRequestManager sharedManager] asyncGET:[NSString stringFromConst:qkCSUrlProfileList] parameters:params showLoading:YES showError:YES success: ^(AFHTTPRequestOperation *operation, id responseObject) {
                            if ([responseObject[QK_API_STATUS_CODE] isEqualToString:[NSString stringFromConst:QK_STT_CODE_SUCCESS]]) {
                                [self showJobHistory];
                            }
                        } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
                            NSLog(@"Error: %@", error);
                        }];
                    }
                } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
                    NSLog(@"Error: %@", error);
                }];
            }
        } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
        }];
    }
    else {
        [self showNoInternetViewWithSelector:@selector(acceptApplicants)];
    }
}

- (void)showJobHistory {
    [self performSegueWithIdentifier:@"QKRecruitmentHavedCVSegue" sender:nil];
}

- (void)updateCountDownLabel {
    [self.countDownTimer invalidate];
    self.countDownTimer = [NSTimer scheduledTimerWithTimeInterval:60 target:self selector:@selector(countDownLabelUpdate) userInfo:nil repeats:YES];
    [self.countDownTimer fire];
}

- (void)countDownLabelUpdate {
    NSTimeInterval diff = [self.recruitment.closingDt timeIntervalSinceDate:[NSDate date]];
    if (diff < 0) {
        diff = 0;
    }
    int hours = lround(floor(diff / 3600.)) % 100;
    int minutes = lround(floor(diff / 60.)) % 60;
    self.countDownLabel.text = [NSString stringWithFormat:@"募集終了まで: %d時間%d分", hours, minutes];
    self.timeLabel.text = [NSString stringWithFormat:@"応募終了まで: %d時間%d分", hours, minutes];
    if (self.accessRecAlv) {
        self.accessRecAlv.messageLabel.text = [NSString stringWithFormat:@"今応募すると、%d時間%d分以内に\n採用/不採用が決まります。\n結果発表前ならキャンセルが可能です。", hours, minutes];
    }
}

- (void)cancelApplicant {
    if ([self connected]) {
        NSMutableDictionary *params = [NSMutableDictionary initWithApiKeyAndToken];
        [params setObject:[QKAccessUserDefaults getUserId] forKey:@"userId"];
        [params setObject:self.recruitment.recruitmentId forKey:@"recruitmentId"];
        
        [[QKRequestManager sharedManager] asyncGET:[NSString stringFromConst:qkCSUrlAppliCancel] parameters:params showLoading:YES showError:YES success: ^(AFHTTPRequestOperation *operation, id responseObject) {
            if ([responseObject[QK_API_STATUS_CODE] isEqualToString:[NSString stringFromConst:QK_STT_CODE_SUCCESS]]) {
                NSMutableDictionary *params = [NSMutableDictionary initWithApiKeyAndToken];
                [params setObject:[QKAccessUserDefaults getUserId] forKey:@"userId"];
                [[QKRequestManager sharedManager] asyncGET:[NSString stringFromConst:qkCSUrlProfileDetail] parameters:params showLoading:YES showError:YES success: ^(AFHTTPRequestOperation *operation, id responseObject) {
                    if ([responseObject[QK_API_STATUS_CODE] isEqualToString:[NSString stringFromConst:QK_STT_CODE_SUCCESS]]) {
                        CCAlertView *completeAlv = [[CCAlertView alloc] initWithImage:[UIImage imageNamed:@"dialog_pic_delete"] title:@"応募をキャンセルしました" andMessage:nil style:QKAlertViewStyleWhite];
                        completeAlv.delegate = self;
                        [completeAlv showAlert];
                    }
                } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
                    NSLog(@"Error: %@", error);
                }];
            }
        } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
        }];
    }
    else {
        [self showNoInternetViewWithSelector:@selector(cancelApplicant)];
    }
}

#pragma mark - CCAlertViewDelegate

- (void)alertView:(CCAlertView *)alertView selectedButtonIndex:(NSInteger)index {
    if (alertView == self.duplicateAlv) {
        if (index == 1) {
            self.accessRecAlv = [[CCAlertView alloc] initWithTitle:@"このバイトに応募します" message:@"今応募すると、1時間34分以内に\n採用/不採用が決まります。\n結果発表前ならキャンセルが可能です。" delegate:self buttonTitles:@[@"やめる", @"応募する"]];
            [self countDownLabelUpdate];
            [self.accessRecAlv showAlert];
        }
        return;
    }
    if (alertView == self.accessRecAlv) {
        if (index == 1) {
            [self acceptApplicants];
        }
        return;
    }
    if (alertView == self.callEmergencyAlv) {
        if (index == 1) {
            [self callCenter];
        }
        return;
    }
    if (alertView == self.cancelApplicantConfirmAlv) {
        if (index == 1) {
            [self cancelApplicant];
        }
    }
}

- (void)clickOnAlertView:(CCAlertView *)alertView {
    [self getRecruitmentModel];
}

#pragma mark - Keep, unkeep Recruitment

- (void)unKeepRec {
    [self performSegueWithIdentifier:@"QKShowListKeepedJobSegue" sender:self];
}

- (void)keepRec {
    if ([self connected]) {
        NSMutableDictionary *params = [NSMutableDictionary initWithApiKeyAndToken];
        [params setObject:[QKAccessUserDefaults getUserId] forKey:@"userId"];
        [params setObject:self.recruitment.recruitmentId forKey:@"recruitmentId"];
        NSString *stringToBreakLine = [NSString stringWithFormat:@"%@\n%@",
                                       @"バイト一覧の「キープ中のバイト」から", @"確認できす"];
        
        [[QKRequestManager sharedManager] asyncGET:[NSString stringFromConst:qkCSUrlKeepRegist] parameters:params showLoading:YES showError:YES success: ^(AFHTTPRequestOperation *operation, id responseObject) {
            if ([responseObject[QK_API_STATUS_CODE] isEqualToString:[NSString stringFromConst:QK_STT_CODE_SUCCESS]]) {
                CCAlertView *keepSuccess = [[CCAlertView alloc] initWithImage:[UIImage imageNamed:@"dialog_pic_done"] title:@"このバイトをキープしました" message:stringToBreakLine delegate:nil buttonTitles:@[@"OK"]];
                [keepSuccess showAlert];
                self.recruitment.isKept = YES;
                [self setKeepButton];
                
                //set Local notification
                NSTimeInterval timeLimit = self.recruitment.timeLimit;
                NSDate *localDate = [self.recruitment.startDate earlierDateWithTimeInterval:timeLimit];
                
                QKNotificationItem *item = [[QKNotificationItem alloc]init];
                item.fireDate = localDate;
                item.alertBody = [NSString stringWithFormat:@"A recruitment will be expired after %ld s", (long)timeLimit];
                [QKLocalNotificationManager scheduleNotificationWithItem:item isNeedRepeat:NO];
            }
            else {
                NSLog(@"responseObject : %@ ", responseObject[@"msg"]);
            }
        } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
        }];
    }
    else {
        [self showNoInternetViewWithSelector:@selector(keepRec)];
    }
}

@end

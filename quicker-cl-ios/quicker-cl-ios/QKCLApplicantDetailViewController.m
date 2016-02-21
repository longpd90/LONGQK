//
//  QKApplicantViewController.m
//  quicker-cl-ios
//
//  Created by Nguyen Huu Anh on 7/22/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLApplicantDetailViewController.h"
#import "QKCLCustomerUserModel.h"
#import "QKCLEncryptUtil.h"
#import "QKApplicantInfoCell.h"
#import "QKSHKCareerCell.h"
#import "QKCareerCell.h"
#import "QKCLFreeQAModel.h"
#import "QKCLSalaryModel.h"
#import "QKTableViewCell.h"
#import "NSNumber+QKCLConvertToCurrency.h"
#import "QKApplicantWorkingHourCell.h"
#import "QKApplicantAmountPaidCell.h"
#import "QKApplicantPaymentCell.h"
#import "QKCLMessageViewController.h"
#import  "QKCLWorkerDeleteReasonViewController.h"
#import "QKClWorkerPaymentCalculateSalaryViewController.h"
#import "QKCLCustomerSalaryModel.h"

@interface QKCLApplicantDetailViewController () <UITableViewDelegate, CCAlertViewDelegate>

//check mode to display screen
@property (strong, nonatomic) QKCLCustomerUserModel *customerUserModel;
@property (strong, nonatomic) QKCLCustomerSalaryModel *salaryBasicModel;
@property (strong, nonatomic) QKCLSalaryModel *salaryModel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet QKF2Label *topLabelHeaderView;
@property (weak, nonatomic) IBOutlet QKF40Label *bottomLabelHeaderView;
@property (strong, nonatomic) NSMutableDictionary *shkCellExpanded;
@property (strong, nonatomic) NSMutableDictionary *careersCellExpanded;
@property (strong, nonatomic) CCAlertView *notAdoptedAlv;
@property (strong, nonatomic) CCAlertView *adoptedAlv;
@property (strong, nonatomic) CCAlertView *doneAlv;
@property (strong, nonatomic) UIButton *messageButton;
@property (strong, nonatomic) QKCLCustomerSalaryModel *adoptSalaryModel;

@end

@implementation QKCLApplicantDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setAngleLeftBarButton];
    self.navigationItem.title = NSLocalizedString(@"応募者の詳細", nil);
    self.shkCellExpanded = [[NSMutableDictionary alloc] init];
    self.careersCellExpanded = [[NSMutableDictionary alloc] init];
    
    [self loadHeaderTableView];
    [self loadFooterView];
    [self loadCustomerUserInfo];
    
    // Do any additional setup after loading the view.
    
}

#pragma mark - Load Data

- (void)loadCustomerUserInfo {
    if ([self connected]) {
        NSMutableDictionary *params = [NSMutableDictionary initWithApiKeyAndToken];
        [params setObject:[QKCLAccessUserDefaults getUserId] forKey:@"userId"];
        [params setObject:[QKCLEncryptUtil encyptBlowfish:self.customerUserId] forKey:@"customerUserId"];
        [params setObject:self.recruitmentModel.recruitmentId forKey:@"recruitmentId"];
        
        [[QKCLRequestManager sharedManager] asyncGET:[NSString stringFromConst:qkUrlApplicantDetail] parameters:params showLoading:YES showError:YES success: ^(AFHTTPRequestOperation *operation, id responseObject) {
            if ([responseObject[QK_API_STATUS_CODE] isEqualToString:[NSString stringFromConst:QK_STT_CODE_SUCCESS]]) {
                self.customerUserModel = [[QKCLCustomerUserModel alloc] initWithData:responseObject];
                
                [self reloadInterface];
            }
        } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
        }];
    }
    else {
        [self showNoInternetViewWithSelector:@selector(loadCustomerUserInfo)];
    }
}

- (void)loadSalary {
    if ([self connected]) {
        NSMutableDictionary *params = [NSMutableDictionary initWithApiKeyAndToken];
        [params setObject:[QKCLAccessUserDefaults getUserId] forKey:@"userId"];
        NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:self.recruitmentModel.startDt];
        NSInteger month = [components month];
        NSInteger year = [components year];
        [params setObject:[NSString stringWithFormat:@"%d", month] forKey:@
         "month"];
        [params setObject:[NSString stringWithFormat:@"%d", year] forKey:@
         "year"];
        [params setObject:[QKCLAccessUserDefaults getActiveShopId] forKey:@"shopId"];
        
        [[QKCLRequestManager sharedManager] asyncGET:[NSString stringFromConst:qkUrlSalaryFixedMonth] parameters:params showLoading:YES showError:YES success: ^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"statuscd succes %@", responseObject[QK_STT_CODE_SUCCESS]);
            if ([responseObject[QK_API_STATUS_CODE] isEqualToString:[NSString stringFromConst:QK_STT_CODE_SUCCESS]]) {
                self.salaryModel = [[QKCLSalaryModel alloc] initWithResponse:responseObject];
                for (NSDictionary *dic in responseObject[@"dayList"]) {
                    BOOL isBreak = NO;
                    for (NSDictionary *rec in dic[@"recruitmentList"]) {
                        if ([rec[@"recruitmentId"] isEqualToString:_recruitmentModel.recruitmentId]) {
                            for (NSDictionary *adopt in  rec[@"adoptionList"]) {
                                if ([adopt[@"adoptionUserId"] isEqualToString:_userInfoModel.adoptionUserId]) {
                                    _adoptSalaryModel= [[QKCLCustomerSalaryModel alloc]initWithResponse:adopt];
                                    isBreak = YES;
                                    break;
                                }
                            }
                            break;
                        }
                    }
                    if (isBreak) {
                        break;
                    }
                }
                [self reloadInterface];
            }
            else {
                NSLog(@"responseObject : %@ ", responseObject[@"msg"]);
            }
        } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
        }];
    }
    else {
        [self showNoInternetViewWithSelector:@selector(loadSalary)];
    }
}

- (void)reloadInterface {
    [self.messageButton setTitle:[NSString stringWithFormat:@"メッセージ(%d)", self.customerUserModel.notReadMessageCount] forState:UIControlStateNormal];
    [self.messageButton setTitle:[NSString stringWithFormat:@"メッセージ(%d)", self.customerUserModel.notReadMessageCount] forState:UIControlStateSelected];
    [self.tableView reloadData];
}

- (void)loadHeaderTableView {
    switch (self.mode) {
        case QKApplicantDetailModeBeforeWorking:
        {
            self.topLabelHeaderView.text = @"勤務開始前です";
            self.bottomLabelHeaderView.text = @"勤務に関する確認や質問はメッセージをご利用ください";
            break;
        }
            
        case QKApplicantDetailModeWorkActualStatusInputBefore:
        {
            UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"QKApplicantDetailModeBeforeWorking"];
            UIView *headerView = cell.contentView;
            CGRect frame = cell.contentView.frame;
            frame.size.height = 160;
            headerView.frame = frame;
            self.tableView.tableHeaderView = headerView;
            break;
        }
            
        case QKApplicantDetailModeWorkActualStatusInputAlready:
        {
            [self loadSalary];
            self.topLabelHeaderView.text = @"給与の送金待ちです";
            self.bottomLabelHeaderView.text = @"4月6日10：00に送金が予定されています";
            break;
        }
            
        case QKApplicantDetailModeWorkActualStatusPending:
        {
            [self loadSalary];
            UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"QKApplicantDetailModeWorkActualStatusPending"];
            UIView *headerView = cell.contentView;
            CGRect frame = cell.contentView.frame;
            frame.size.height = 160;
            headerView.frame = frame;
            self.tableView.tableHeaderView = headerView;
            break;
        }
            
        case QKApplicantDetailModeWorkActualStatusApproval:
            [self loadSalary];
            self.topLabelHeaderView.text = @"給与支払い済です";
            self.bottomLabelHeaderView.text = @"4月6日　10：00に送金が完了しています";
            break;
            
        case QKApplicantDetailModeNonEmployment:
            self.topLabelHeaderView.text = @"勤務が取り消されました";
            self.bottomLabelHeaderView.text = @"〇〇（取り消しの仕様が不明確なため、一旦保留）〇〇\n〇〇〇〇〇〇〇〇〇〇〇〇〇〇〇〇〇〇〇〇〇〇〇〇〇〇";
            break;
            
        default:
            break;
    }
}

- (void)loadFooterView {
    switch (self.mode) {
        case QKApplicantDetailModeBeforeWorking:
        {
            UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"QKApplicantDetailModeBeforeWorkingFooter"];
            UIView *footer = cell.contentView;
            CGRect frame = cell.contentView.frame;
            frame.size.height = 60;
            footer.frame = frame;
            self.messageButton = (UIButton *)[footer viewWithTag:200];
            self.tableView.tableFooterView = footer;
            break;
        }
            
        case QKApplicantDetailModeWorkActualStatusInputBefore:
        {
            UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"QKApplicantDetailModeWorkActualStatusInputBeforeFooter"];
            UIView *footer = cell.contentView;
            CGRect frame = cell.contentView.frame;
            frame.size.height = 60;
            footer.frame = frame;
            self.messageButton = (UIButton *)[footer viewWithTag:200];
            self.tableView.tableFooterView = footer;
            break;
        }
            
        case QKApplicantDetailModeWorkActualStatusInputAlready:
        {
            self.tableView.tableFooterView = nil;
            break;
        }
            
        case QKApplicantDetailModeWorkActualStatusPending:
        {
            
            UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"QKApplicantDetailModeWorkActualStatusPendingFooter"];
            UIView *footer = cell.contentView;
            CGRect frame = cell.contentView.frame;
            frame.size.height = 60;
            footer.frame = frame;
            self.messageButton = (UIButton *)[footer viewWithTag:200];
            self.tableView.tableFooterView = footer;
            break;
        }
            
        case QKApplicantDetailModeWorkActualStatusApproval:
            self.tableView.tableFooterView = nil;
            break;
            
        case QKApplicantDetailModeNonEmployment:
            self.tableView.tableFooterView = nil;
            break;
            
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma TableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    if (self.mode == QKApplicantDetailModeFullInfo) {
        return 8;
    }
    else if (self.mode == QKApplicantDetailModeWorkActualStatusInputAlready ||
             self.mode == QKApplicantDetailModeWorkActualStatusPending ||
             self.mode == QKApplicantDetailModeWorkActualStatusApproval) {
        return 3;
    }
    else {
        return 5;
    }
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    
    if (self.mode == QKApplicantDetailModeFullInfo) {
        if (section == 1) {
            return self.customerUserModel.shkCareerSummary.ctgry.count;
        }
        if (section == 2) {
            return self.customerUserModel.careerList.count;
        }
        
        if (section == 4) {
            if (self.freeQAList.count == 0) {
                return 1;
            }
            else
                return self.freeQAList.count * 2;
        }
        
        if (section == 3 || (section > 4 && section < 8)) {
            return 1;
        }
    }
    else if (self.mode == QKApplicantDetailModeWorkActualStatusInputAlready ||
             self.mode == QKApplicantDetailModeWorkActualStatusPending ||
             self.mode == QKApplicantDetailModeWorkActualStatusApproval) {
        if (section == 1) {
            return 3;
        }
        
        if (section == 2) {
            return 2;
        }
    }
    else {
        if (section == 1) {
            return self.customerUserModel.shkCareerSummary.ctgry.count;
        }
        if (section == 2) {
            return self.customerUserModel.careerList.count;
        }
        
        return 1;
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        QKApplicantInfoCell *applicantCell = [tableView dequeueReusableCellWithIdentifier:@"QKApplicantInfoCell"];
        [applicantCell.applicantImageView setImageWithQKURL:self.customerUserModel.imageUrl placeholderImage:[UIImage imageNamed:@"account_pic_blankprofile"] withCache:YES];
        if (self.customerUserModel.customeLastName) {
            applicantCell.nameApplicant.text = [NSString stringWithFormat:@"%@ %@", self.customerUserModel.customeLastName, self.customerUserModel.customeFirstName];
        }
        
        NSString *genderString = @"男性";
        if ([self.customerUserModel.sexFlg isEqualToString:[NSString stringFromConst:SEX_FLG_FEMALE]]) {
            genderString = @"女性";
        }
        applicantCell.ageAndGenderLabel.text = [NSString stringWithFormat:@"(%d歳・%@)", [self getAgeFromBirthDay:self.customerUserModel.birthday], genderString];
        
        applicantCell.favoriteImageView.hidden = !self.customerUserModel.favoriteCustomerF;
        
        return applicantCell;
    }
    if (self.mode == QKApplicantDetailModeWorkActualStatusInputAlready ||
        self.mode == QKApplicantDetailModeWorkActualStatusPending ||
        self.mode == QKApplicantDetailModeWorkActualStatusApproval) {
        if (indexPath.section == 1) {
            if (indexPath.row == 0) {
                UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"QKTableViewCell"];
                cell.textLabel.text = @"職種";
                cell.detailTextLabel.text = @"ホールスタッフ";
                return cell;
            }
            
            if (indexPath.row == 1) {
                UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"QKTableViewCell"];
                cell.textLabel.text = @"時給";
                NSNumber *salary = [NSDecimalNumber numberWithInteger:self.customerUserModel.actualSalaryPerUnit];
                cell.detailTextLabel.text = [NSString stringWithFormat:@"%@円", [salary convertToCurrency]];
                return cell;
            }
            if (indexPath.row == 2) {
                QKApplicantWorkingHourCell *cell = (QKApplicantWorkingHourCell *)[tableView dequeueReusableCellWithIdentifier:@"QKApplicantWorkingHoursCell"];
                cell.customerSalaryModel = self.adoptSalaryModel;
                return cell;
            }
        }
        else if (indexPath.section == 2) {
            if (indexPath.row == 0) {
                QKApplicantAmountPaidCell *cell = (QKApplicantAmountPaidCell *)[tableView dequeueReusableCellWithIdentifier:@"QKApplicantAmountPaidCell"];
                cell.customerSalaryModel = self.adoptSalaryModel;
                return cell;
            }
            else if (indexPath.row == 1) {
                QKApplicantPaymentCell *cell = (QKApplicantPaymentCell *)[tableView dequeueReusableCellWithIdentifier:@"QKApplicantPaymentCell"];
                cell.customerSalaryModel = self.adoptSalaryModel;
                return cell;
            }
        }
    }
    else {
        if (indexPath.section == 1) {
            QKSHKCareerCell *shkCareerCell = [tableView dequeueReusableCellWithIdentifier:@"QKSHKCareerCell"];
            QKCLShkCareerCategoryModel *categoryModel = [self.customerUserModel.shkCareerSummary.ctgry objectAtIndex:indexPath.row];
            [shkCareerCell setupInterfaceWith:categoryModel andCareerList:self.customerUserModel.shkCareerList];
            if ([self checkShkCellExpanded:indexPath.row]) {
                [shkCareerCell.iconAccordionImv setImage:[UIImage imageNamed:@"list_ic_accordion_active"]];
                shkCareerCell.shkCareerListView.hidden = NO;
            }
            else {
                [shkCareerCell.iconAccordionImv setImage:[UIImage imageNamed:@"list_ic_accordion_inactive"]];
                shkCareerCell.shkCareerListView.hidden = YES;
            }
            return shkCareerCell;
        }
        
        if (indexPath.section == 2) {
            QKCareerCell *careerCell = [tableView dequeueReusableCellWithIdentifier:@"QKCareerCell"];
            QKCLCareerModel *careerModel = [self.customerUserModel.careerList objectAtIndex:indexPath.row];
            careerCell.careerModel = careerModel;
            if ([self checkCareerCellExpanded:indexPath.row]) {
                [careerCell.iconAccordionImv setImage:[UIImage imageNamed:@"list_ic_accordion_active"]];
                careerCell.shkCareerListView.hidden = NO;
            }
            else {
                [careerCell.iconAccordionImv setImage:[UIImage imageNamed:@"list_ic_accordion_inactive"]];
                careerCell.shkCareerListView.hidden = YES;
            }
            return careerCell;
        }
        if (self.mode == QKApplicantDetailModeFullInfo) {
            if (indexPath.section == 3) {
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"QKBasicCell"];
                UILabel *label = (UILabel *)[cell viewWithTag:11];
                label.text = self.customerUserModel.selfPromotionInApplication;
                return cell;
            }
            
            if (indexPath.section == 4) {
                if (self.freeQAList.count == 0) {
                    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DefaultCell"];
                    return cell;
                }
                else {
                    QKCLFreeQAModel *freeQAModel = (QKCLFreeQAModel *)[self.freeQAList objectAtIndex:(int)(indexPath.row / 2)];
                    UITableViewCell *cell;
                    if (indexPath.row % 2 == 0) {
                        cell = [tableView dequeueReusableCellWithIdentifier:@"QKQuestionCell"];
                        UILabel *label = (UILabel *)[cell viewWithTag:100];
                        label.text = freeQAModel.question;
                    }
                    else {
                        cell = [tableView dequeueReusableCellWithIdentifier:@"QKAnswerCell"];
                        UILabel *label = (UILabel *)[cell viewWithTag:100];
                        label.text = freeQAModel.answer;
                    }
                    return cell;
                }
            }
            
            if (indexPath.section == 5) {
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"QKMapCell"];
                return cell;
            }
            
            if (indexPath.section == 6) {
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"QKBasicCell"];
                UILabel *label = (UILabel *)[cell viewWithTag:11];
                label.text = self.customerUserModel.selfPromotion;
                return cell;
            }
            if (indexPath.section == 7) {
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"QKBasicCell"];
                UILabel *label = (UILabel *)[cell viewWithTag:11];
                label.text = self.customerUserModel.education;
                return cell;
            }
        }
        else {
            if (indexPath.section == 3) {
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"QKBasicCell"];
                UILabel *label = (UILabel *)[cell viewWithTag:11];
                label.text = self.customerUserModel.selfPromotion;
                return cell;
            }
            if (indexPath.section == 4) {
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"QKBasicCell"];
                UILabel *label = (UILabel *)[cell viewWithTag:11];
                label.text = self.customerUserModel.education;
                return cell;
            }
        }
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 110.0;
    }
    if (self.mode == QKApplicantDetailModeWorkActualStatusInputAlready ||
        self.mode == QKApplicantDetailModeWorkActualStatusPending ||
        self.mode == QKApplicantDetailModeWorkActualStatusApproval) {
        if (indexPath.section == 1) {
            if (indexPath.row == 0) {
                return 44.0;
            }
            
            if (indexPath.row == 1) {
                return 44.0;
            }
            if (indexPath.row == 2) {
                return 140.0;
            }
        }
        else if (indexPath.section == 2) {
            if (indexPath.row == 0) {
                return 141.0;
            }
            else if (indexPath.row == 1) {
                QKApplicantPaymentCell *cell = (QKApplicantPaymentCell *)[tableView dequeueReusableCellWithIdentifier:@"QKApplicantPaymentCell"];
                cell.customerSalaryModel = self.adoptSalaryModel;
                return [self calculateHeightForConfiguredSizingCell:cell inTableView:tableView];
            }
        }
    }
    else {
        if (indexPath.section == 1) {
            if (![self checkShkCellExpanded:indexPath.row]) {
                return 110.0;
            }
            else {
                QKSHKCareerCell *shkCareerCell = [tableView dequeueReusableCellWithIdentifier:@"QKSHKCareerCell"];
                QKCLShkCareerCategoryModel *categoryModel = [self.customerUserModel.shkCareerSummary.ctgry objectAtIndex:indexPath.row];
                [shkCareerCell setupInterfaceWith:categoryModel andCareerList:self.customerUserModel.shkCareerList];
                return [self calculateHeightForConfiguredSizingCell:shkCareerCell inTableView:tableView];
            }
        }
        
        if (indexPath.section == 2) {
            if (![self checkCareerCellExpanded:indexPath.row]) {
                return 110.0;
            }
            else {
                QKCareerCell *careerCell = [tableView dequeueReusableCellWithIdentifier:@"QKCareerCell"];
                QKCLCareerModel *careerModel = [self.customerUserModel.careerList objectAtIndex:indexPath.row];
                careerCell.careerModel = careerModel;
                return [self calculateHeightForConfiguredSizingCell:careerCell inTableView:tableView];
            }
        }
        
        if (self.mode == QKApplicantDetailModeFullInfo) {
            if (indexPath.section == 3) {
                if ([self.customerUserModel.selfPromotionInApplication isEqualToString:@""]) {
                    return 40.0;
                }
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"QKBasicCell"];
                UILabel *label = (UILabel *)[cell viewWithTag:11];
                label.text = self.customerUserModel.selfPromotionInApplication;
                [label sizeToFit];
                return [self calculateHeightForConfiguredSizingCell:cell inTableView:tableView];
            }
            if (indexPath.section == 4) {
                if (self.freeQAList.count == 0) {
                    return 40.0;
                }
                QKCLFreeQAModel *freeQAModel = (QKCLFreeQAModel *)[self.freeQAList objectAtIndex:(int)(indexPath.row / 2)];
                UITableViewCell *cell;
                if (indexPath.row % 2 == 0) {
                    cell = [tableView dequeueReusableCellWithIdentifier:@"QKQuestionCell"];
                    UILabel *label = (UILabel *)[cell viewWithTag:100];
                    label.text = freeQAModel.question;
                }
                else {
                    cell = [tableView dequeueReusableCellWithIdentifier:@"QKAnswerCell"];
                    UILabel *label = (UILabel *)[cell viewWithTag:100];
                    label.text = freeQAModel.answer;
                }
                return [self calculateHeightForConfiguredSizingCell:cell inTableView:tableView];
            }
            
            if (indexPath.section == 5) {
                return 255;
            }
            
            if (indexPath.section == 6) {
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"QKBasicCell"];
                UILabel *label = (UILabel *)[cell viewWithTag:11];
                label.text = self.customerUserModel.selfPromotion;
                [label sizeToFit];
                return [self calculateHeightForConfiguredSizingCell:cell inTableView:tableView];
            }
            if (indexPath.section == 7) {
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"QKBasicCell"];
                UILabel *label = (UILabel *)[cell viewWithTag:11];
                label.text = self.customerUserModel.education;
                [label sizeToFit];
                return [self calculateHeightForConfiguredSizingCell:cell inTableView:tableView];
            }
        }
        else {
            if (indexPath.section == 3) {
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"QKBasicCell"];
                UILabel *label = (UILabel *)[cell viewWithTag:11];
                label.text = self.customerUserModel.selfPromotion;
                [label sizeToFit];
                return [self calculateHeightForConfiguredSizingCell:cell inTableView:tableView];
            }
            if (indexPath.section == 4) {
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"QKBasicCell"];
                UILabel *label = (UILabel *)[cell viewWithTag:11];
                label.text = self.customerUserModel.education;
                [label sizeToFit];
                return [self calculateHeightForConfiguredSizingCell:cell inTableView:tableView];
            }
        }
        
        return 110.0;
    }
    return 0.0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (self.mode == QKApplicantDetailModeFullInfo) {
        switch (section) {
            case 1:
                return @"Job Quickerでの勤務実績";
                break;
                
            case 2:
                return @"過去の職歴";
                break;
                
            case 3:
                return @"応募アピール";
                break;
                
            case 4:
                return @"応募者への質問";
                break;
                
            case 5:
                return @"応募者の位置情報";
                break;
                
            case 6:
                return @"自己アピール";
                break;
                
            case 7:
                return @"学歴";
                break;
                
            default:
                return @"";
                break;
        }
    }
    else if (self.mode == QKApplicantDetailModeWorkActualStatusInputAlready ||
             self.mode == QKApplicantDetailModeWorkActualStatusPending ||
             self.mode == QKApplicantDetailModeWorkActualStatusApproval) {
        switch (section) {
            case 1:
                return @"勤務内容";
                break;
                
            case 2:
                return @"支給額内訳";
                break;
        }
    }
    else {
        switch (section) {
            case 1:
                return @"Job Quickerでの勤務実績";
                break;
                
            case 2:
                return @"過去の職歴";
                break;
                
            case 3:
                return @"自己アピール";
                break;
                
            case 4:
                return @"学歴";
                break;
                
            default:
                return @"";
                break;
        }
    }
    return @"";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 1) {
        if ([self checkShkCellExpanded:indexPath.row]) {
            [self.shkCellExpanded setObject:@"" forKey:[NSString stringWithFormat:@"%d", indexPath.row]];
        }
        else {
            [self.shkCellExpanded setObject:@"1" forKey:[NSString stringWithFormat:@"%d", indexPath.row]];
        }
        [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    else if (indexPath.section == 2) {
        if ([self checkCareerCellExpanded:indexPath.row]) {
            [self.careersCellExpanded setObject:@"" forKey:[NSString stringWithFormat:@"%d", indexPath.row]];
        }
        else {
            [self.careersCellExpanded setObject:@"1" forKey:[NSString stringWithFormat:@"%d", indexPath.row]];
        }
        [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    if ([view isKindOfClass:[UITableViewHeaderFooterView class]]) {
        UITableViewHeaderFooterView *tableViewHeaderFooterView = (UITableViewHeaderFooterView *)view;
        tableViewHeaderFooterView.textLabel.text = [tableViewHeaderFooterView.textLabel.text capitalizedString];
    }
}

#pragma mark - Ultilities

- (NSInteger)getAgeFromBirthDay:(NSDate *)birthday {
    if (birthday) {
        NSDate *now = [NSDate date];
        NSDateComponents *ageComponents = [[NSCalendar currentCalendar]
                                           components:NSCalendarUnitYear
                                           fromDate:birthday
                                           toDate:now
                                           options:0];
        return [ageComponents year];
    }else{
        return 0;
    }
}

- (BOOL)checkShkCellExpanded:(NSInteger)index {
    NSString *string = [self.shkCellExpanded objectForKey:[NSString stringWithFormat:@"%d", index]];
    if (!string || [string isEqualToString:@""]) {
        return NO;
    }
    else
        return YES;
}

- (BOOL)checkCareerCellExpanded:(NSInteger)index {
    NSString *string = [self.careersCellExpanded objectForKey:[NSString stringWithFormat:@"%d", index]];
    if (!string || [string isEqualToString:@""]) {
        return NO;
    }
    else
        return YES;
}

#pragma mark - IBAction

- (IBAction)notAdoptedApplicant:(id)sender {
    self.notAdoptedAlv = [[CCAlertView alloc] initWithTitle:@"不採用にしますか？" message:@"一度不採用にしてしまうと\n取り消しすることはできません" delegate:self buttonTitles:@[@"しない", @"不採用にする"]];
    [self.notAdoptedAlv showAlert];
}

- (IBAction)adoptedApplicant:(id)sender {
    self.adoptedAlv = [[CCAlertView alloc] initWithTitle:@"採用しますか？" message:@"さいようした応募者とのやりとりは\n「勤務管理」からおこなえます" delegate:self buttonTitles:@[@"しない", @"採用する"]];
    [self.adoptedAlv showAlert];
}

- (IBAction)cancelService:(id)sender {
    [self performSegueWithIdentifier:@"QKCLWorkerDetailSegue" sender:self];
}

- (IBAction)payTheWork:(id)sender {
    [self callApiPaymentSalary];
}

- (void)callApiPaymentSalary {
    if ([self connected]) {
        NSMutableDictionary *params = [NSMutableDictionary initWithApiKeyAndToken];
        [params setObject:[QKCLAccessUserDefaults getUserId] forKey:@"userId"];
        [params setObject:[NSString stringWithFormat:@"%d", self.recruitmentModel.salaryPerUnit] forKey:@"salaryPerUnit"];
        [params setObject:self.recruitmentModel.salaryUnit forKey:@"salaryUnit"];
        [params setObject:[self.recruitmentModel.startDt longDateString] forKey:@"startDt"];
        [params setObject:[self.recruitmentModel.endDt longDateString] forKey:@"endDt"];
        
        [params setObject:self.recruitmentModel.recess forKey:@"recess"];
        [[QKCLRequestManager sharedManager] asyncPOST:[NSString stringFromConst:qkClUrlWorkerSalaryCalculate] parameters:params showLoading:YES showError:YES success: ^(AFHTTPRequestOperation *operation, id responseObject) {
            if ([responseObject[QK_API_STATUS_CODE] isEqualToString:[NSString stringFromConst:QK_STT_CODE_SUCCESS]]) {
                _salaryBasicModel = [[QKCLCustomerSalaryModel alloc]initWithResponse:responseObject];
                [self performSegueWithIdentifier:@"QKWorkerPaymentSalaryCalculateSegue" sender:self];
            }
        }
                                              failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
                                                  NSLog(@"fail...%@", error);
                                              }];
    }
    else {
        [self showNoInternetViewWithSelector:@selector(callApiPaymentSalary)];
    }
}

- (IBAction)modifyAmountPaid:(id)sender {
    [self performSegueWithIdentifier:@"QKWorkerPaymentSalaryCalculateSegue" sender:self];
}

- (IBAction)goToMessage:(id)sender {
    self.hidesBottomBarWhenPushed = YES;
    [self performSegueWithIdentifier:@"QKGotoMessageSegue" sender:nil];
    self.hidesBottomBarWhenPushed = NO;
}

- (IBAction)emergencyPhone:(id)sender {
    [self callCenter];
}

#pragma mark - CCAlertViewDelegate

- (void)alertView:(CCAlertView *)alertView selectedButtonIndex:(NSInteger)index {
    if (alertView == self.notAdoptedAlv && index == 1) {
        if ([self connected]) {
            NSMutableDictionary *params = [NSMutableDictionary initWithApiKeyAndToken];
            [params setObject:[QKCLAccessUserDefaults getUserId] forKey:@"userId"];
            [params setObject:[QKCLEncryptUtil encyptBlowfish:self.customerUserId] forKey:@"customerUserId"];
            [params setObject:self.recruitmentModel.recruitmentId forKey:@"recruitmentId"];
            [params setObject:QK_APPLICANT_STATUS_NG forKey:@"status"];
            [[QKCLRequestManager sharedManager] asyncPOST:[NSString stringFromConst:qkUrlApplicantAdoptionStatusUpdate] parameters:params showLoading:YES showError:YES success: ^(AFHTTPRequestOperation *operation, id responseObject) {
                NSLog(@"statuscd succes %@", responseObject[QK_STT_CODE_SUCCESS]);
                if ([responseObject[QK_API_STATUS_CODE] isEqualToString:[NSString stringFromConst:QK_STT_CODE_SUCCESS]]) {
			                 self.doneAlv = [[CCAlertView alloc] initWithImage:[UIImage imageNamed:@"dialog_pic_delete"] title:@"不採用にしました" message:nil delegate:self buttonTitles:@[@"OK"]];
			                 [self.doneAlv showAlert];
                }
                else {
			                 NSLog(@"responseObject : %@ ", responseObject[@"msg"]);
                }
            } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
                NSLog(@"Error: %@", error);
            }];
        }
        else {
            [self showNoInternetViewWithSelector:nil];
        }
        return;
    }
    if (alertView == self.adoptedAlv && index == 1) {
        if ([self connected]) {
            NSMutableDictionary *params = [NSMutableDictionary initWithApiKeyAndToken];
            [params setObject:[QKCLAccessUserDefaults getUserId] forKey:@"userId"];
            [params setObject:[QKCLEncryptUtil encyptBlowfish:self.customerUserId] forKey:@"customerUserId"];
            [params setObject:self.recruitmentModel.recruitmentId forKey:@"recruitmentId"];
            [params setObject:QK_APPLICANT_STATUS_OK forKey:@"status"];
            [[QKCLRequestManager sharedManager] asyncPOST:[NSString stringFromConst:qkUrlApplicantAdoptionStatusUpdate] parameters:params showLoading:YES showError:YES success: ^(AFHTTPRequestOperation *operation, id responseObject) {
                NSLog(@"statuscd succes %@", responseObject[QK_STT_CODE_SUCCESS]);
                if ([responseObject[QK_API_STATUS_CODE] isEqualToString:[NSString stringFromConst:QK_STT_CODE_SUCCESS]]) {
			                 self.doneAlv = [[CCAlertView alloc] initWithImage:[UIImage imageNamed:@"dialog_pic_done"] title:@"採用しました" message:nil delegate:self buttonTitles:@[@"OK"]];
			                 [self.doneAlv showAlert];
                }
                else {
			                 NSLog(@"responseObject : %@ ", responseObject[@"msg"]);
                }
            } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
                NSLog(@"Error: %@", error);
            }];
        }
        else {
            [self showNoInternetViewWithSelector:nil];
        }
        return;
    }
    if (self.doneAlv == alertView) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"QKGotoMessageSegue"]) {
        QKCLMessageViewController *messageVC = (QKCLMessageViewController *)[segue destinationViewController];
        messageVC.recruimentId = self.recruitmentModel.recruitmentId;
        messageVC.customerUserId = self.customerUserId;
    }
    if ([segue.identifier isEqualToString:@"QKCLWorkerDetailSegue"]) {
        QKCLWorkerDeleteReasonViewController *vc
        = (QKCLWorkerDeleteReasonViewController *)segue.destinationViewController;
        
        vc.recruitmentId  = self.recruitmentModel.recruitmentId;
        vc.userPassModel = _userInfoModel;
    }
    if ([segue.identifier isEqualToString:@"QKWorkerPaymentSalaryCalculateSegue"]) {
        QKClWorkerPaymentCalculateSalaryViewController *vc =  (QKClWorkerPaymentCalculateSalaryViewController *)segue.destinationViewController;
        if (_mode == QKApplicantDetailModeWorkActualStatusInputBefore ) {
            vc.recruitmentModel = self.recruitmentModel;
            vc.adoptSalaryModel.adoptUserInfo = self.userInfoModel;
            vc.adoptSalaryModel = self.salaryBasicModel;
        }
        if (_mode == QKApplicantDetailModeWorkActualStatusPending) {
            // vc.workerInforModel = self.salaryModel;
        }
        
    }
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

@end

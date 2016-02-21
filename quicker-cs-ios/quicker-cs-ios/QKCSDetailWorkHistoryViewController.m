//
//  QKCSDetailWorkHistoryViewController.m
//  quicker-cs-ios
//
//  Created by C Anh on 8/17/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCSDetailWorkHistoryViewController.h"
#import "QKCSWorkHistoryCell.h"
#import "QKRecruitmentDetailViewController.h"
#import "QKCSDetailWorkHistoryCell.h"
#import "QKCSHeaderWorkHistoryDetailCell.h"
#import "QKCSFooterWorkHistoryDetailCell.h"
#import "QKCSTestDetailModel.h"
#import "QKTableViewCell.h"
#import "QKCSServiceDetailCell.h"
#import "QKCSMessageViewController.h"
static NSString *footerWorkHistoryDetailCell = @"QKCSFooterWorkHistoryDetailCell";
static NSString *detailWorkHistoryCell = @"QKCSDetailWorkHistoryCell";
static NSString *headerWorkHistoryDetailCell = @"QKCSHeaderWorkHistoryDetailCell";
@interface QKCSDetailWorkHistoryViewController () <CCAlertViewDelegate>
{
    BOOL successFavorite;
    BOOL isWorkHistory;
    BOOL isWorkFavorite;
}
@property (strong, nonatomic) CCAlertView *messageAlertView;
@property (strong, nonatomic) QKCSTestDetailModel *testModel;
@end

@implementation QKCSDetailWorkHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    isWorkFavorite = NO;
    _testModel = [[QKCSTestDetailModel alloc] init];
    [self.tableView registerNib:[UINib nibWithNibName:detailWorkHistoryCell bundle:nil] forCellReuseIdentifier:detailWorkHistoryCell];
    [self.tableView registerNib:[UINib nibWithNibName:headerWorkHistoryDetailCell bundle:nil] forHeaderFooterViewReuseIdentifier:headerWorkHistoryDetailCell];
    [self.tableView registerNib:[UINib nibWithNibName:footerWorkHistoryDetailCell bundle:nil] forHeaderFooterViewReuseIdentifier:footerWorkHistoryDetailCell];
    [self setAngleLeftBarButton];
    successFavorite = YES;
    isWorkHistory = YES;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
//    [self loadSalary];
    [self dummyDataTestModel];
}
- (void) dummyDataTestModel {
//    @property (strong, nonatomic) NSString *jobTypeLCd;
//    @property (strong, nonatomic) NSString *jobTypeLName;
//    @property (strong, nonatomic) NSString *jobTypeMCd;
//    @property (strong, nonatomic) NSString *jobTypeMName;
//    @property (strong, nonatomic) NSString *jobTypeSCd;
//    @property (strong, nonatomic) NSString *jobTypeSName;
//    @property (assign, nonatomic) NSInteger transportationExpenses;
//    @property (strong, nonatomic) NSDate *startDt;
//    @property (strong, nonatomic) NSDate *endDt;
//    @property (assign, nonatomic) NSInteger salaryTotal;
//    @property (assign, nonatomic) NSInteger employmentNum;
//    @property (strong, nonatomic) NSString *paymentMethod;
//    @property (strong, nonatomic) NSString *paymentMethodName;
//    @property (strong, nonatomic) NSString *recruitmentStatus;
//    @property (strong, nonatomic) NSString *recruitmentStatusName;
//    @property (strong, nonatomic) NSString *accountingOfFeesStatus;
//    @property (assign, nonatomic) NSInteger totalSalary;
//    @property (assign, nonatomic) NSInteger totalMargin;
//    @property (assign, nonatomic) NSInteger adoptionNum;
//    
//    @property (strong, nonatomic) NSString *salaryUnit;
//    @property (assign, nonatomic) NSInteger salaryPerUnit;
//    @property (strong, nonatomic) NSDate *actualStartDt;
//    @property (strong, nonatomic) NSDate *actualEndDt;
//    @property (strong, nonatomic) NSString *worktime;
//    @property (assign, nonatomic) NSInteger recess;
//    @property (strong, nonatomic) NSString *totalAmount;
    _testModel.jobTypeLCd =  @"jobTypeLCd";
    _testModel.jobTypeLName = @"jobTypeName";
    _testModel.jobTypeMCd = @"jobTypeMCd";
    _testModel.jobTypeMName = @"jobType";
    _testModel.jobTypeSCd = @"jobTypeSCd";
    _testModel.jobTypeSName = @"jobTypeSName";
    
    _testModel.startDt = [NSDate date];
    _testModel.endDt = [NSDate date];
    
    _testModel.salaryTotal = 1000;
    _testModel.employmentNum = 10;
    _testModel.totalSalary = 2000;
    
    _testModel.recess = 123;
    
    _testModel.worktime = @"Work Time";
    
    NSLog(@"Dummy data");
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)loadSalary {
    if ([self connected]) {
        NSMutableDictionary *params = [NSMutableDictionary initWithApiKeyAndToken];
        [params setObject:[QKAccessUserDefaults getUserId] forKey:@"userId"];
        [params setObject:self.recruitmentModel.recruitmentId forKey:@"recruitmentId"];
        
        [[QKRequestManager sharedManager] asyncGET:@"" parameters:params showLoading:YES showError:YES success: ^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"statuscd succes %@", responseObject[QK_STT_CODE_SUCCESS]);
            if ([responseObject[QK_API_STATUS_CODE] isEqualToString:[NSString stringFromConst:QK_STT_CODE_SUCCESS]]) {
                NSLog(@"Success!");
//                self.salaryModel = [[QKCLSalaryModel alloc] initWithResponse:responseObject];
//                [self reloadInterface];
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
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 4) {
        return 44.0;
    }
    return 70.0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 130.0;
    }
    return 44.0;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 1:
            return NSLocalizedString(@"勤務実績", nil);
            break;
        case 2:
            return NSLocalizedString(@"総支給額", nil);
            break;
        case 3:
            return NSLocalizedString(@"控除額", nil);
        default:
            break;
    }
    return nil;
}
- (UIView *)tableView:(UITableView *)tableView  viewForFooterInSection:(NSInteger)section{
    UIView *footerView;
    if (!isWorkFavorite) {

    switch (section) {
        case 0:
        {
            
            QKCSHeaderWorkHistoryDetailCell *sectionHeaderView = (QKCSHeaderWorkHistoryDetailCell *)[tableView dequeueReusableHeaderFooterViewWithIdentifier:headerWorkHistoryDetailCell];
            sectionHeaderView.headerTotalSalaryLabel.text = [NSString stringWithFormat:@"振込予定額: %ld円",(long)_testModel.totalSalary ];
            footerView = sectionHeaderView;
                
            
        }
            break;
        case 3:
        {
            QKCSFooterWorkHistoryDetailCell *sectionFooterView = (QKCSFooterWorkHistoryDetailCell *) [tableView dequeueReusableHeaderFooterViewWithIdentifier:footerWorkHistoryDetailCell];
            [sectionFooterView.paySalaryButton addTarget:self action:@selector(paySalaryAction) forControlEvents:UIControlEventTouchUpInside];
//            sectionFooterView.contactShopButton.imageViewButton.image = [UIImage imageNamed:@""];
//            sectionFooterView.contactShopButton.decriptionTitleLabel.text = @"Test";
            UIFont *font = [UIFont boldSystemFontOfSize:15];
            sectionFooterView.paySalaryButton.titleLabel.font = font;
            sectionFooterView.contactShopButton.titleLabel.font = font;
            [sectionFooterView.contactShopButton addTarget:self action:@selector(contactShopAction) forControlEvents:UIControlEventTouchUpInside];


            footerView = sectionFooterView;
        }
            break;
        default:
            break;
    }
    }
    else {
        switch (section) {
            case 4: {
                QKCSFooterWorkHistoryDetailCell *sectionFooterView = (QKCSFooterWorkHistoryDetailCell *) [tableView dequeueReusableHeaderFooterViewWithIdentifier:footerWorkHistoryDetailCell];
                [sectionFooterView.paySalaryButton addTarget:self action:@selector(paySalaryAction) forControlEvents:UIControlEventTouchUpInside];
                UIFont *font = [UIFont boldSystemFontOfSize:15];
                sectionFooterView.paySalaryButton.titleLabel.font = font;
                sectionFooterView.contactShopButton.titleLabel.font = font;
                [sectionFooterView.contactShopButton addTarget:self action:@selector(contactShopAction) forControlEvents:UIControlEventTouchUpInside];
                
                
                footerView = sectionFooterView;
            }
                break;
                
            default:
                break;
        }
    }
    return footerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView;
    switch (section) {
        case 0:
        {
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0,tableView.frame.size.width, 70.0)];
            QKF3Label *titleLabel = [[QKF3Label alloc] init];
            titleLabel.frame = CGRectMake(0, 0, tableView.frame.size.width, 50);
            titleLabel.textAlignment = NSTextAlignmentCenter;
            titleLabel.center = view.center;
            [titleLabel setText:@"振込予定額が確定しました"];
            [view addSubview:titleLabel];
            return view;
        }
            break;
        case 1: {
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0,tableView.frame.size.width, 70.0)];
            UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0,tableView.frame.size.width, 0.5)];
            view1.backgroundColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1];
            QKF33Label *titleLabel = [[QKF33Label alloc] init];
            titleLabel.frame = CGRectMake(15, 30, tableView.frame.size.width, 50);
            titleLabel.numberOfLines = 2;
            [titleLabel setText:@"勤務実績"];
            [view addSubview:titleLabel];
            [view addSubview:view1];
            return view;
        }
            break;
        case 2:
            break;
        case 3:
            break;
        default:
            break;
    }
    return headerView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (!isWorkFavorite) {
        if (section == 0) {
            return 76.0;
        }
        else if (section == 3) {
            return  154.0;
        }
    }
    else {

        if (section == 4) {
            return  154.0;
        }
    }
    
    return 0.1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (!isWorkFavorite) {
        return 4;

    }
    else
        return 5;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (!isWorkFavorite) {
        switch (section) {
            case 0:
                return 1;
                break;
            case 1:
                return 2;
                break;
            case 2:
                return 5;
                break;
            case 3:
                return 1;
                break;
            default:
                break;
        }
    }
    else
    {
        switch (section) {
            case 0:
                return 1;
                break;
            case 1:
                return 2;
                break;
            case 2:
                return 5;
                break;
            case 3:
                return 4;
                break;
            case 4:
                return 1;
                break;
            default:
                break;
        }
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    
    QKCSServiceDetailCell *tableCell = (QKCSServiceDetailCell *)[tableView dequeueReusableCellWithIdentifier:@"QKCSServiceDetailCell"];
    if (!tableCell) {
        tableCell = [[QKCSServiceDetailCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier :@"QKCSServiceDetailCell"];
    }
    
    if (!isWorkFavorite) {
        switch (indexPath.section) {
            case 0:
            {
                QKCSDetailWorkHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:detailWorkHistoryCell];
                if (cell == nil) {
                    cell = [[QKCSDetailWorkHistoryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:detailWorkHistoryCell] ;
                }
                cell.favoriteButton.enabled = YES;
                cell.recruitmentModel = _recruitmentModel;
                if (_isFavoriteJob) {
                    cell.favoriteButton.enabled = NO;
                }
                else {
                    cell.favoriteButton.enabled = YES;
                    [cell.favoriteButton addTarget:self
                                            action:@selector(favoriteAction) forControlEvents:UIControlEventTouchUpInside];
                }
                return cell;
                break;
            }
            case 1:
            {
                switch (indexPath.row) {
                    case 0: {
                        tableCell.titleLabel.text = NSLocalizedString(@"勤務時間", nil);
                        tableCell.valueLabel.text = [NSString stringWithFormat:@"%ld額", (long)_testModel.totalSalary];
                        break;

                    }
                    case 1: {
                        tableCell.titleLabel.text = NSLocalizedString(@"労働時間", nil);
                        tableCell.valueLabel.text = [NSString stringWithFormat:@"%ld額", (long)_testModel.totalSalary];
                        break;
                    }
                    default:
                        break;
                }
                cell = tableCell;
                break;

            }
            case 2:{
                switch (indexPath.row) {
                    case 0: {
                        tableCell.titleLabel.text = NSLocalizedString(@"基本給", nil);
                        tableCell.valueLabel.text = [NSString stringWithFormat:@"%ld額", (long)_testModel.totalSalary];

                        break;
                    }
                    case 1: {
                        tableCell.titleLabel.text = NSLocalizedString(@"時間外手当", nil);
                        tableCell.valueLabel.text = [NSString stringWithFormat:@"%ld額", (long)_testModel.totalSalary];

                        break;
                    }
                    case 2:
                        tableCell.titleLabel.text = NSLocalizedString(@"CL指定の手当名が入ります", nil);
                        tableCell.valueLabel.text = [NSString stringWithFormat:@"%ld額", (long)_testModel.totalSalary];

                        break;
                    case 3: {
                        tableCell.titleLabel.text = NSLocalizedString(@"交通費", nil);
                        tableCell.valueLabel.text = [NSString stringWithFormat:@"%ld額", (long)_testModel.totalSalary];
                        break;
                    }
                    case 4: {
                        tableCell.titleLabel.text = NSLocalizedString(@"総支給額", nil);
                        tableCell.valueLabel.text = [NSString stringWithFormat:@"%ld額", (long)_testModel.totalSalary];

                        break;
                    }
                        
                    default:
                        break;
                }
                cell = tableCell;
                break;

            }
            case 3: {
                tableCell.titleLabel.text = NSLocalizedString(@"控除後支給額", nil);
                tableCell.valueLabel.textColor = [UIColor grayColor];
                tableCell.valueLabel.font = [UIFont boldSystemFontOfSize:14.0];
                tableCell.valueLabel.text = [NSString stringWithFormat:@"%ld額", (long)_testModel.totalSalary];
                cell = tableCell;

                break;

            }
                
            default:
                break;
        }

    }
    else {
        switch (indexPath.section) {
            case 0:
            {
                QKCSDetailWorkHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:detailWorkHistoryCell];
                if (cell == nil) {
                    cell = [[QKCSDetailWorkHistoryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:detailWorkHistoryCell] ;
                }
                cell.favoriteButton.enabled = NO;
                cell.recruitmentModel = _recruitmentModel;
                
                return cell;
                break;

            }
            case 1:
            {
                switch (indexPath.row) {
                    case 0: {
                        tableCell.titleLabel.text = NSLocalizedString(@"勤務時間", nil);
                        tableCell.valueLabel.text = [NSString stringWithFormat:@"%ld額", (long)_testModel.totalSalary];
                        break;

                    }
                    case 1: {
                        tableCell.titleLabel.text = NSLocalizedString(@"労働時間", nil);
                        tableCell.valueLabel.text = [NSString stringWithFormat:@"%ld額", (long)_testModel.totalSalary];
                        break;

                    }
                    default:
                        break;
                }
                cell = tableCell;
                break;

            }
            case 2:{
                switch (indexPath.row) {
                    case 0:
                        tableCell.titleLabel.text = NSLocalizedString(@"基本給", nil);
                        tableCell.valueLabel.text = [NSString stringWithFormat:@"%ld額", (long)_testModel.totalSalary];

                        break;
                    case 1:
                        tableCell.titleLabel.text = NSLocalizedString(@"時間外手当", nil);
                        tableCell.valueLabel.text = [NSString stringWithFormat:@"%ld額", (long)_testModel.totalSalary];
                        break;
                    case 2:
                        tableCell.titleLabel.text = NSLocalizedString(@"CL指定の手当名が入ります", nil);
                        tableCell.valueLabel.text = [NSString stringWithFormat:@"%ld額", (long)_testModel.totalSalary];

                        break;
                    case 3:
                        tableCell.titleLabel.text = NSLocalizedString(@"交通費", nil);
                        tableCell.valueLabel.text = [NSString stringWithFormat:@"%ld額", (long)_testModel.totalSalary];

                        
                        break;
                    case 4:
                        tableCell.titleLabel.text = NSLocalizedString(@"総支給額", nil);
                        tableCell.valueLabel.text = [NSString stringWithFormat:@"%ld額", (long)_testModel.totalSalary];

                        break;
                        
                    default:
                        break;
                }
                cell = tableCell;
                break;

            }
            case 3:
            {
                switch (indexPath.row) {
                    case 0:
                        tableCell.titleLabel.text = NSLocalizedString(@"基本給", nil);
                        tableCell.valueLabel.text = [NSString stringWithFormat:@"%ld額", (long)_testModel.totalSalary];

                        break;
                    case 1:
                        tableCell.titleLabel.text = NSLocalizedString(@"時間外手当", nil);
                        tableCell.valueLabel.text = [NSString stringWithFormat:@"%ld額", (long)_testModel.totalSalary];

                        break;
                    case 2:
                        tableCell.titleLabel.text = NSLocalizedString(@"CL指定の手当名が入ります", nil);
                        tableCell.valueLabel.text = [NSString stringWithFormat:@"%ld額", (long)_testModel.totalSalary];

                        break;
                    case 3:
                        tableCell.titleLabel.text = NSLocalizedString(@"交通費", nil);
                        tableCell.valueLabel.text = [NSString stringWithFormat:@"%ld額", (long)_testModel.totalSalary];

                        break;
                        
                    default:
                        break;
                }
                cell = tableCell;
                break;

            }
            case 4: {
                tableCell.titleLabel.text = NSLocalizedString(@"控除後支給額", nil);
                tableCell.valueLabel.textColor = [UIColor grayColor];
                tableCell.valueLabel.font = [UIFont boldSystemFontOfSize:14.0];
//                tableCell.valueLabel.text = [NSString stringWithFormat:@"%ld額", (long)_testModel.totalSalary];
                tableCell.valueLabel.text = @"TEST";
                cell = tableCell;
                break;
            }
            default:
                break;
        }
    
    }
        return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
            [self performSegueWithIdentifier:@"QKCSShowDetail2RecruitmentSegue" sender:self];
            break;
        default:
            break;
    }
}
- (void) contactShopAction {

}
- (void) paySalaryAction {
    _messageAlertView = [[CCAlertView alloc] initWithTitle:@"ログアウトしますか?"
                                                  message:nil
                                                 delegate:self
                                             buttonTitles:@[@"しない", @"ログアウト"]];
    [_messageAlertView showAlert];
    
}
- (void) favoriteAction {
    if ([self connected]) {
        NSMutableDictionary *params = [NSMutableDictionary initWithApiKeyAndToken];
        [params setObject:[QKAccessUserDefaults getUserId] forKey:@"userId"];
        [params setObject:self.recruitmentModel.shopInfo.shopId forKey:@"shopId"];
        [[QKRequestManager sharedManager] asyncPOST:[NSString stringFromConst:qkCSUrlFavoriteRegist] parameters:params showLoading:YES showError:YES success: ^(AFHTTPRequestOperation *operation, id responseObject) {
            if ([responseObject[QK_API_STATUS_CODE] isEqualToString:[NSString stringFromConst:QK_STT_CODE_SUCCESS]]) {
                _isFavoriteJob = YES;
                CCAlertView *success = [[CCAlertView alloc] initWithImage:[UIImage imageNamed:@"dialog_pic_done"] title:@"このバイトをキープしました" message:nil delegate:nil buttonTitles:@[@"OK"]];
                [success showAlert];
                NSIndexPath* indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
                NSArray* indexArray = [NSArray arrayWithObjects:indexPath, nil];

                [self.tableView reloadRowsAtIndexPaths:indexArray withRowAnimation:UITableViewRowAnimationNone];
            }
            else {
                NSLog(@"responseObject : %@ ", responseObject[@"msg"]);
            }
        } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
        }];
    }
    else {
        [self showNoInternetViewWithSelector:@selector(paySalaryAction)];
    }
    
}

- (void)alertView:(CCAlertView *)alertView selectedButtonIndex:(NSInteger)index {
    if (alertView == _messageAlertView) {
        if (index == 1) {
            [self performSegueWithIdentifier:@"QKCSShowMessegerSegue" sender:self];
            if ([self connected]) {
                NSMutableDictionary *params = [NSMutableDictionary initWithApiKeyAndToken];
                [params setObject:[QKAccessUserDefaults getUserId] forKey:@"userId"];
                [params setObject:self.recruitmentModel.recruitmentId forKey:@"recruitmentId"];
                [[QKRequestManager sharedManager] asyncPOST:[NSString stringFromConst:qkCSUrlWorkHistoryPerformance] parameters:params showLoading:YES showError:YES success: ^(AFHTTPRequestOperation *operation, id responseObject) {
                    if ([responseObject[QK_API_STATUS_CODE] isEqualToString:[NSString stringFromConst:QK_STT_CODE_SUCCESS]]) {
                        NSLog(@"Success!");
                    }
                    else {
                        NSLog(@"responseObject : %@ ", responseObject[@"msg"]);
                    }
                } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
                    NSLog(@"Error: %@", error);
                }];
            }
            else {
                [self showNoInternetViewWithSelector:@selector(paySalaryAction)];
            }

        }
            else {
                NSLog(@ "Not ...");
        }
    }
}
#pragma mark - Navigation 
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"QKCSShowDetail2RecruitmentSegue"]) {
        QKRecruitmentDetailViewController *detailViewController = (QKRecruitmentDetailViewController *)segue.destinationViewController;
        detailViewController.recruitment = _recruitmentModel;
        detailViewController.isWorkHistorycontroller = isWorkHistory;
    }
    else if ([segue.identifier isEqualToString:@"QKCSShowMessegerSegue"]) {
        QKCSMessageViewController *mesVC = (QKCSMessageViewController *)[segue destinationViewController];
        self.hidesBottomBarWhenPushed = YES;
        mesVC.recruimentId = self.recruitmentModel.recruitmentId;

    }

}
@end

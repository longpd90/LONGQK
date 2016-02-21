//
//  WorkControlViewController.m
//  quicker-cl-ios
//
//  Created by Nguyen Huu Anh on 4/20/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLWorkViewController.h"
#import "QKCLRecruitmentModel.h"
#import "QKClWorkerTableViewCell.h"
#import "QKCLApplicantDoneTableViewCell.h"
#import "QKCLAdoptionUserModel.h"
#import <QuartzCore/QuartzCore.h>
#import "QKCLWorkerDeleteReasonViewController.h"
#import "QKClWorkerPaymentCalculateSalaryViewController.h"
#import "QKCLApplicantDetailViewController.h"
#import "QKCLSalaryModel.h"
@interface QKCLWorkViewController () <CCAlertViewDelegate>
@property (nonatomic, strong) NSMutableArray *recruitmentArrays;
@property (strong, nonatomic) QKCLRecruitmentModel *selectedRecruitmentModel;
@property (strong, nonatomic) QKCLAdoptionUserModel *selectedAdoptUserModel;
@property (strong, nonatomic) QKCLCustomerSalaryModel *adoptSalaryModel;
@property (strong, nonatomic) CCAlertView *alertView;
@property (strong ,nonatomic)NSTimer *timer;
@end

static NSString *QKCLWorkerTableViewCellIdentifier = @"QKClWorkerTableViewCell";
static NSString *QKCLApplicantDoneTableViewCellIdentifier = @"QKCLApplicantDoneTableViewCell";

@implementation QKCLWorkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBarWithTitle:[QKCLAccessUserDefaults getActiveShopName] andSubTitle:@"勤務管理"];
    
    [self.thisTableview registerNib:[UINib nibWithNibName:QKCLWorkerTableViewCellIdentifier bundle:[NSBundle mainBundle]] forCellReuseIdentifier:QKCLWorkerTableViewCellIdentifier];
    [self.thisTableview registerNib:[UINib nibWithNibName:QKCLApplicantDoneTableViewCellIdentifier bundle:[NSBundle mainBundle]] forCellReuseIdentifier:QKCLApplicantDoneTableViewCellIdentifier];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getRecruitmentListAndWorker];
    
}



- (void)getRecruitmentListAndWorker {
    if ([self connected]) {
        NSMutableDictionary *params = [NSMutableDictionary initWithApiKeyAndToken];
        [params setObject:[QKCLAccessUserDefaults getUserId] forKey:@"userId"];
        [params setObject:[QKCLAccessUserDefaults getActiveShopId] forKey:@"shopId"];
        // [params setObject:QK_READ_FLG_NO forKey:@"notRead"];
        [[QKCLRequestManager sharedManager] asyncGET:[NSString stringFromConst:qkUrlRecruitmentAttendanceList] parameters:params showLoading:YES showError:YES success: ^(AFHTTPRequestOperation *operation, id responseObject) {
            if ([responseObject[QK_API_STATUS_CODE] isEqualToString:[NSString stringFromConst:QK_STT_CODE_SUCCESS]]) {
                self.recruitmentArrays = [[NSMutableArray alloc]init];
                for (NSDictionary *jobtypeSList in responseObject[@"recruitmentJobTypeSList"]) {
                    for (NSDictionary *rec in jobtypeSList[@"recruitmentList"]) {
                        QKCLRecruitmentModel *model = [[QKCLRecruitmentModel alloc]initWithResponse:rec];
                        if ([model.workStatus isEqualToString:[NSString stringFromConst:QK_WORK_STATUS_WORK_AFTER]]) {
                            NSMutableArray *workerActualStatus00Arrays =[[NSMutableArray alloc] init];
                            NSMutableArray *workerActualStatus10Arrays =[[NSMutableArray alloc] init];
                            NSMutableArray *workerActualStatus20Arrays =[[NSMutableArray alloc] init];
                            NSMutableArray *workerActualStatus25Arrays =[[NSMutableArray alloc] init];
                            for (QKCLAdoptionUserModel *userModel in model.adoptionList) {
                                NSLog(@"status%@",userModel.workActualStatus);
                                if ([userModel.workActualStatus isEqualToString:[NSString stringFromConst:QK_CL_WORK_ACTUAL_STATUS_INPUT_BEFORE]]) {
                                    [workerActualStatus00Arrays addObject:userModel];
                                    break;
                                }else if([userModel.workActualStatus isEqualToString:[NSString stringFromConst:QK_CL_WORK_ACTUAL_STATUS_INPUT_ALREADY]]) {
                                    [workerActualStatus10Arrays addObject:userModel];
                                    break;
                                    
                                }else if([userModel.workActualStatus isEqualToString:[NSString stringFromConst:QK_CL_WORK_ACTUAL_STATUS_PENDING]]) {
                                    [workerActualStatus20Arrays addObject:userModel];
                                    break;
                                }else if([userModel.workActualStatus isEqualToString:[NSString stringFromConst:QK_CL_WORK_ACTUAL_STATUS_APPROVAL]]) {
                                    [workerActualStatus25Arrays addObject:userModel];
                                    break;
                                    
                                }
                            }
                            
                            //check each workActualStatus
                            if (workerActualStatus00Arrays.count >0) {
                                model.adoptionList = workerActualStatus00Arrays;
                                [self.recruitmentArrays addObject:model];
                                workerActualStatus00Arrays =nil;
                            }
                            if (workerActualStatus10Arrays.count >0) {
                                model.adoptionList = workerActualStatus10Arrays;
                                [self.recruitmentArrays addObject:model];
                                workerActualStatus10Arrays =nil;
                            }
                            if (workerActualStatus20Arrays.count >0) {
                                model.adoptionList = workerActualStatus20Arrays;
                                [self.recruitmentArrays addObject:model];
                                workerActualStatus20Arrays =nil;
                            }
                            if (workerActualStatus25Arrays.count >0) {
                                model.adoptionList = workerActualStatus25Arrays;
                                [self.recruitmentArrays addObject:model];
                                workerActualStatus25Arrays =nil;
                            }
                            
                        }else{
                            //workStatus == 00 and 10
                            [self.recruitmentArrays addObject:model];
                        }
                        
                    }
                }
                
                [self refreshView];
            }
        } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Get recruitment list fail...");
        }];
    }
    else {
        [self showNoInternetViewWithSelector:@selector(getRecruitmentListAndWorker)];
    }
}

- (void)refreshView {
    if ([self.recruitmentArrays count] > 0) {
        [self.thisTableview setHidden:NO];
        [self.thisView setHidden:YES];
        if (_timer == nil || ![_timer isValid]) {
            // Timer
            _timer = [NSTimer scheduledTimerWithTimeInterval:60.0
                                                      target:self
                                                    selector:@selector(timerFired:)
                                                    userInfo:nil
                                                     repeats:YES];
        }

        [self.thisTableview reloadData];
    }
    else {
        [self.thisView setHidden:NO];
        [self.thisTableview setHidden:YES];
        [self.view bringSubviewToFront:self.thisView];
    }
}

#pragma  mark -UITableViewDatasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.recruitmentArrays count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    QKCLRecruitmentModel *rec = [self.recruitmentArrays objectAtIndex:section];
    return rec.adoptionList.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    QKCLRecruitmentModel *model = [self.recruitmentArrays objectAtIndex:indexPath.section];
    
    if (indexPath.row == 0) {
        QKClWorkerTableViewCell *cells = (QKClWorkerTableViewCell *)[tableView dequeueReusableCellWithIdentifier:QKCLWorkerTableViewCellIdentifier];
        if (cells == nil) {
            cells = [[QKClWorkerTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:QKCLWorkerTableViewCellIdentifier];
        }
        [cells setData:model];
        cell = cells;
    }else{
        //workStatus == 00 and 10
        if ([model.workStatus isEqualToString:[NSString stringFromConst:QK_WORK_STATUS_WORK_BEFORE]] || [model.workStatus isEqualToString:[NSString stringFromConst:QK_WORK_STATUS_WORK]]) {
            
            QKCLApplicantDoneTableViewCell *cells = (QKCLApplicantDoneTableViewCell *)[tableView dequeueReusableCellWithIdentifier:QKCLApplicantDoneTableViewCellIdentifier];
            if (cells == nil) {
                cells = [[QKCLApplicantDoneTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:QKCLApplicantDoneTableViewCellIdentifier];
            }
            
            QKCLAdoptionUserModel *userModel = [model.adoptionList objectAtIndex:indexPath.row - 1];
            [cells setData:userModel withRecruitment:model];
            cell = cells;
            
        }
        else
        {
            QKCLAdoptionUserModel *adoptUserModel = [model.adoptionList objectAtIndex:indexPath.row - 1];
            QKCLApplicantDoneTableViewCell *cells = (QKCLApplicantDoneTableViewCell *)[tableView dequeueReusableCellWithIdentifier:QKCLApplicantDoneTableViewCellIdentifier];
            if (cells == nil) {
                cells = [[QKCLApplicantDoneTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:QKCLApplicantDoneTableViewCellIdentifier];
            }
            [cells setData:adoptUserModel withRecruitment:model];
            
            [cells.cancelButton addTarget:self action:@selector(deleteWorker:) forControlEvents:UIControlEventTouchUpInside];
            [cells.paymentButton addTarget:self
                                    action:@selector(paymentforWorker:) forControlEvents:UIControlEventTouchUpInside];
            cells.paymentButton.tag = indexPath.section;
            cells.cancelButton.tag = indexPath.section;
            cell = cells;
        }
    }
    cell.tag = indexPath.row;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 20.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    QKCLRecruitmentModel *model = [self.recruitmentArrays objectAtIndex:indexPath.section];
    if (indexPath.row == 0) {
        QKClWorkerTableViewCell *cells = (QKClWorkerTableViewCell *)[tableView dequeueReusableCellWithIdentifier:QKCLWorkerTableViewCellIdentifier];
        if (cells == nil) {
            cells = [[QKClWorkerTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:QKCLWorkerTableViewCellIdentifier];
        }
        [cells setData:model];
        return [self calculateHeightForConfiguredSizingCell:cells inTableView:tableView];
    }
    else {
        QKCLAdoptionUserModel *userModel = [model.adoptionList objectAtIndex:indexPath.row -1];
        QKCLApplicantDoneTableViewCell *cells = (QKCLApplicantDoneTableViewCell *)[tableView dequeueReusableCellWithIdentifier:QKCLApplicantDoneTableViewCellIdentifier];
        if (cells == nil) {
            cells = [[QKCLApplicantDoneTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:QKCLApplicantDoneTableViewCellIdentifier];
        }
        [cells setData:userModel withRecruitment:model];
        return [self calculateHeightForConfiguredSizingCell:cells inTableView:tableView];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return;
    }
    else {
        _selectedRecruitmentModel = [self.recruitmentArrays objectAtIndex:indexPath.section];
        _selectedAdoptUserModel = [_selectedRecruitmentModel.adoptionList objectAtIndex:indexPath.row - 1];
        [self performSegueWithIdentifier:@"QKCLShowApplicantDetailSegue" sender:self];
    }
}

#pragma mark - Function
- (void)paymentforWorker:(id)sender {
    UIButton *button = (UIButton *)sender;
    NSInteger section = button.tag;
    NSInteger row = button.superview.superview.tag;
    
    _selectedRecruitmentModel = [self.recruitmentArrays objectAtIndex:section];
    _selectedAdoptUserModel = [_selectedRecruitmentModel.adoptionList objectAtIndex:row - 1];
    
    if ([_selectedAdoptUserModel.workActualStatus isEqualToString:[NSString stringFromConst:QK_CL_WORK_ACTUAL_STATUS_INPUT_BEFORE]]) {
       [self callApiPaymentSalaryStatusBefore];
    }
    if ([_selectedAdoptUserModel.workActualStatus isEqualToString:[NSString stringFromConst:QK_CL_WORK_ACTUAL_STATUS_PENDING]]) {
        [self callApiPaymentSalaryStatusPending];
    }
    
}
#pragma mark - workactual pending
- (void)callApiPaymentSalaryStatusPending {
    if ([self connected]) {
        //call CL_SAL_0002
        NSMutableDictionary *params = [NSMutableDictionary initWithApiKeyAndToken];
        [params setObject:[QKCLAccessUserDefaults getUserId] forKey:@"userId"];
        NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:self.selectedRecruitmentModel.startDt];
        NSInteger month = [components month];
        NSInteger year = [components year];
        [params setObject:[NSString stringWithFormat:@"%d", month] forKey:@
         "month"];
        [params setObject:[NSString stringWithFormat:@"%d", year] forKey:@
         "year"];
        [params setObject:[QKCLAccessUserDefaults getActiveShopId] forKey:@"shopId"];
        
        [[QKCLRequestManager sharedManager] asyncGET:[NSString stringFromConst:qkUrlSalaryFixedMonth] parameters:params showLoading:YES showError:YES success: ^(AFHTTPRequestOperation *operation, id responseObject) {
            
            if ([responseObject[QK_API_STATUS_CODE] isEqualToString:[NSString stringFromConst:QK_STT_CODE_SUCCESS]]) {
                BOOL isBreak = NO;
                for (NSDictionary *dic in responseObject[@"dayList"]) {
                    for (NSDictionary *rec in dic[@"recruitmentList"]) {
                        if ([rec[@"recruitmentId"] isEqualToString:_selectedRecruitmentModel.recruitmentId]) {
                            for (NSDictionary *adopt in  rec[@"adoptionList"]) {
                                if ([adopt[@"adoptionUserId"] isEqualToString:_selectedAdoptUserModel.adoptionUserId]) {
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
                [self performSegueWithIdentifier:@"QKWorkerPaymentSalarySegue" sender:self];
            }
            
        } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
        }];
    }
    else {
        [self showNoInternetViewWithSelector:@selector(callApiPaymentSalaryStatusPending)];
    }
}
#pragma mark -workactual before
- (void)callApiPaymentSalaryStatusBefore {
    if ([self connected]) {
        NSMutableDictionary *params = [NSMutableDictionary initWithApiKeyAndToken];
        [params setObject:[QKCLAccessUserDefaults getUserId] forKey:@"userId"];
        [params setObject:[NSString stringWithFormat:@"%d", _selectedRecruitmentModel.salaryPerUnit] forKey:@"salaryPerUnit"];
        [params setObject:_selectedRecruitmentModel.salaryUnit forKey:@"salaryUnit"];
        [params setObject:[_selectedRecruitmentModel.startDt longDateString] forKey:@"startDt"];
        [params setObject:[_selectedRecruitmentModel.endDt longDateString] forKey:@"endDt"];
        // this for test
        [params setObject:_selectedRecruitmentModel.recess forKey:@"recess"];
        [[QKCLRequestManager sharedManager] asyncPOST:[NSString stringFromConst:qkClUrlWorkerSalaryCalculate] parameters:params showLoading:YES showError:YES success: ^(AFHTTPRequestOperation *operation, id responseObject) {
            if ([responseObject[QK_API_STATUS_CODE] isEqualToString:[NSString stringFromConst:QK_STT_CODE_SUCCESS]]) {
                _adoptSalaryModel = [[QKCLCustomerSalaryModel alloc]init];
                //map API response
                _adoptSalaryModel.basicSalary = [responseObject intForKey:@"basicSalary"];
                _adoptSalaryModel.actualOvertimeAllowance = [responseObject intForKey:@"overTimeAllowance"];
                _adoptSalaryModel.actualNighttimeAllowance = [responseObject intForKey:@"midnightAllowance"];
                _adoptSalaryModel.actualWithholding = [responseObject intForKey:@"withHolding"];
                _adoptSalaryModel.margin = [responseObject intForKey:@"margin"];
                
                //map from recruitment
                _adoptSalaryModel.actualSalaryPerUnit = _selectedRecruitmentModel.salaryPerUnit;
                _adoptSalaryModel.actualStartDt = _selectedRecruitmentModel.startDt;
                _adoptSalaryModel.actualEndDt = _selectedRecruitmentModel.endDt;
                _adoptSalaryModel.actualRecess = [_selectedRecruitmentModel.recess integerValue];
                [self performSegueWithIdentifier:@"QKWorkerPaymentSalarySegue" sender:self];
            }
            
        } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"fail...%@", error);
        }];
    }
    else {
        [self showNoInternetViewWithSelector:@selector(callApiPaymentSalaryStatusBefore)];
    }
}

- (void)deleteWorker:(id)sender {
    UIButton *button = (UIButton *)sender;
    //section
    NSInteger section = button.tag;
    //row
    NSInteger row = button.superview.superview.superview.tag;
    
    _selectedRecruitmentModel = [self.recruitmentArrays objectAtIndex:section];
    _selectedAdoptUserModel = [_selectedRecruitmentModel.adoptionList objectAtIndex:row - 1];
    NSString *message = [NSString stringWithFormat:@"%@\n%@", @"繰り返しクライアント都合でキャンセルされると", @"アカウントが停止となる都合ございます（仮）"];
    _alertView = [[CCAlertView alloc] initWithTitle:@"勤務者を取り消しますか？" message:message delegate:self buttonTitles:@[@"戻る", @"次へ"]];
    [_alertView showAlert];
}


- (void)alertView:(CCAlertView *)alertView selectedButtonIndex:(NSInteger)index {
    if (alertView == _alertView) {
        if (index == 1) {
            [self performSegueWithIdentifier:@"QKWorkerDeleteSegue" sender:self];
        }
    }
}


#pragma mark -Navigation

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    // Remove seperator inset
    NSInteger lastRow = [tableView numberOfRowsInSection:indexPath.section];
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        if ((indexPath.row == 0) || (indexPath.row == lastRow - 1)) {
            [cell setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, CGRectGetWidth(tableView.bounds))];
        }
    }
    if (lastRow > 1) {
        if (indexPath.row  == 0) {
            cell.layer.mask = [self applyRoundCorners:UIRectCornerTopLeft | UIRectCornerTopRight frame:cell.bounds];
        }
        if (indexPath.row == lastRow - 1) {
            cell.layer.mask = [self applyRoundCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight frame:cell.bounds];
        }
    }
    else {
        cell.layer.mask = [self applyRoundCorners:UIRectCornerAllCorners frame:cell.bounds];
    }
    
    
    
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    
    // Explictly set your cell's layout margins
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}


#pragma mark - calcuklate worktime like follow
- (NSString *)calculateWorkTime:(NSDate *)startTime endTime:(NSDate *)endTime {
    //worktime
    NSString *workTimeLabel;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"MM月dd日 HH:mm"];
    NSString *startDate = [dateFormatter stringFromDate:startTime];
    [dateFormatter setDateFormat:@"HH:mm"];
    NSString *endDate = [dateFormatter stringFromDate:endTime];
    
    if ([startTime isSameDayWithDate:endTime]) {
        workTimeLabel = [NSString stringWithFormat:@"%@ ~ %@", startDate, endDate];
    }
    else {
        workTimeLabel = [NSString stringWithFormat:@"%@ ~ 翌%@", startDate, endDate];
    }
    return workTimeLabel;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"QKWorkerDeleteSegue"]) {
        QKCLWorkerDeleteReasonViewController *vc = (QKCLWorkerDeleteReasonViewController *)segue.destinationViewController;
        vc.userPassModel = _selectedAdoptUserModel;
        vc.recruitmentId = _selectedRecruitmentModel.recruitmentId;
    }
    
    if ([segue.identifier isEqualToString:@"QKWorkerPaymentSalarySegue"]) {
        QKClWorkerPaymentCalculateSalaryViewController *vc = (QKClWorkerPaymentCalculateSalaryViewController *)segue.destinationViewController;
        
        vc.adoptSalaryModel = _adoptSalaryModel;
        vc.adoptSalaryModel.adoptUserInfo = _selectedAdoptUserModel;
        vc.recruitmentModel = _selectedRecruitmentModel;
    }
    
    //view applicant detail
    if ([segue.identifier isEqualToString:@"QKCLShowApplicantDetailSegue"]) {
        QKCLApplicantDetailViewController *applicantDetailViewController = (QKCLApplicantDetailViewController *)segue.destinationViewController;
        
        applicantDetailViewController.recruitmentModel = _selectedRecruitmentModel;
        applicantDetailViewController.customerUserId = _selectedAdoptUserModel.adoptionUserId;
        applicantDetailViewController.userInfoModel = _selectedAdoptUserModel;
        
        if ([_selectedRecruitmentModel.workStatus isEqual:[NSString stringFromConst:QK_WORK_STATUS_WORK_BEFORE]]||[_selectedRecruitmentModel.workStatus isEqual:[NSString stringFromConst:QK_WORK_STATUS_WORK]]) {
            applicantDetailViewController.mode = QKApplicantDetailModeBeforeWorking;
        }
        else {
            //get employmentStatus
            NSMutableDictionary *params = [NSMutableDictionary initWithApiKeyAndToken];
            [params setObject:[QKCLAccessUserDefaults getUserId] forKey:@"userId"];
            [params setObject:[QKCLEncryptUtil encyptBlowfish:_selectedAdoptUserModel.adoptionUserId] forKey:@"customerUserId"];
            [params setObject:_selectedRecruitmentModel.recruitmentId forKey:@"recruitmentId"];
            NSDictionary *response;
            NSError *error;
            BOOL result = [[QKCLRequestManager sharedManager] syncGET:[NSString stringFromConst:qkUrlApplicantDetail] parameters:params response:&response error:&error showLoading:YES showError:YES];
            if (result) {
                if ([response[@"employmentStatus"] isEqualToString:[NSString stringFromConst:QK_CL_EMPLOYMENT_STATUS_EMPLOYMENT]]) {
                    //check workActualStatus
                    if ([_selectedAdoptUserModel.workActualStatus isEqualToString:[NSString stringFromConst:QK_CL_WORK_ACTUAL_STATUS_INPUT_BEFORE]]) {
                        applicantDetailViewController.mode = QKApplicantDetailModeWorkActualStatusInputBefore;
                    }
                    if ([_selectedAdoptUserModel.workActualStatus isEqualToString:[NSString stringFromConst:QK_CL_WORK_ACTUAL_STATUS_INPUT_ALREADY]]) {
                        applicantDetailViewController.mode = QKApplicantDetailModeWorkActualStatusInputAlready;
                    }
                    if ([_selectedAdoptUserModel.workActualStatus isEqualToString:[NSString stringFromConst:QK_CL_WORK_ACTUAL_STATUS_PENDING]]) {
                        applicantDetailViewController.mode = QKApplicantDetailModeWorkActualStatusPending;
                    }
                    if ([_selectedAdoptUserModel.workActualStatus isEqualToString:[NSString stringFromConst:QK_CL_WORK_ACTUAL_STATUS_APPROVAL]]) {
                        applicantDetailViewController.mode = QKApplicantDetailModeWorkActualStatusApproval;
                    }
                }
                else {
                    applicantDetailViewController.mode = QKApplicantDetailModeNonEmployment;
                }
            }
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma - mark Action create round corner for cell
- (CAShapeLayer *)applyRoundCorners:(UIRectCorner)corners frame:(CGRect)frame  {
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:frame byRoundingCorners:corners cornerRadii:CGSizeMake(10.0, 10.0)];
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = frame;
    maskLayer.path = maskPath.CGPath;
    return maskLayer;
}
- (void)timerFired:(id)sender{
    [self.thisTableview reloadData];
}
@end

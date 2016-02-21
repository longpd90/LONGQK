//
//  QKRecruitmentStatusViewController.m
//  quicker-cl-ios
//
//  Created by Nguyen Huu Anh on 7/14/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLRecruitmentStatusViewController.h"
#import "QKRecruitmentStatusJobCell.h"
#import "QKRecruitmentStatusApplicantCell.h"
#import "QKCLApplicantUserModel.h"
#import "QKCLAdoptionUserModel.h"
#import "QKCLApplicantDetailViewController.h"
#import "QKCLFreeQAModel.h"
#import "QKCLRecruitmentInformationViewController.h"


@interface QKCLRecruitmentStatusViewController () <UITableViewDelegate, CCAlertViewDelegate>

@property (strong, nonatomic) CCAlertView *confirmAlertView;
@property (strong, nonatomic) CCAlertView *completeAlertView;
@property (strong, nonatomic) NSString *customerUserId;
@property (nonatomic) BOOL isAdoptUser;
@property (strong, nonatomic) NSTimer *timer;
@end

@implementation QKCLRecruitmentStatusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (_timer == nil || ![_timer isValid]) {
        // Timer
        _timer = [NSTimer scheduledTimerWithTimeInterval:60.0
                                                  target:self
                                                selector:@selector(timerFired)
                                                userInfo:nil
                                                 repeats:YES];
    }
    
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self loadRecruitmentDetail];
}

- (void)loadRecruitmentDetail {
    if ([self connected]) {
        NSMutableDictionary *params = [NSMutableDictionary initWithApiKeyAndToken];
        [params setObject:[QKCLAccessUserDefaults getUserId] forKey:@"userId"];
        [params setObject:[QKCLAccessUserDefaults getActiveShopId] forKey:@"shopId"];
        [params setObject:self.recruitmentId forKey:@"recruitmentId"];
        
        [[QKCLRequestManager sharedManager] asyncGET:[NSString stringFromConst:qkUrlRecruitmentDetail] parameters:params showLoading:YES showError:YES success: ^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"statuscd succes %@", responseObject[QK_STT_CODE_SUCCESS]);
            if ([responseObject[QK_API_STATUS_CODE] isEqualToString:[NSString stringFromConst:QK_STT_CODE_SUCCESS]]) {
                self.recruitmentModel = [[QKCLRecruitmentModel alloc]initWithResponse:responseObject];
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
        [self showNoInternetViewWithSelector:@selector(loadRecruitmentDetail)];
    }
}

- (void)reloadInterface {
    //set message label
    if (self.recruitmentModel.applicantList.count + self.recruitmentModel.adoptionList.count == 0) {
        _messageLabel.text = NSLocalizedString(@"現在募集中です", nil);
    }
    else {
        _messageLabel.text = NSLocalizedString(@"募集終了までに採用の合否を決定してください\n（募集終了時間を過ぎると応募者はすべて不採用となります）", nil);
    }
    [self reloadCountDownLabel];
    [self reloadTotalNum];
    [self.tableView reloadData];
}

- (void)reloadCountDownLabel {
    //count down
    if ([_recruitmentModel.closingDt isLaterThanDate:[NSDate date]]) {
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSDateComponents *components = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit
                                                   fromDate:[NSDate date]
                                                     toDate:_recruitmentModel.closingDt
                                                    options:0];
        
        NSString *countDownString = @"";
        if (components.day > 0) {
            countDownString = [NSString stringWithFormat:@"採用終了まで あと%ld日%ld時間%ld分", (long)components.day, (long)components.hour, (long)components.minute];
        }
        else if (components.hour > 0) {
            countDownString = [NSString stringWithFormat:@"採用終了まで あと%ld時間%ld分", (long)components.hour, (long)components.minute];
        }
        else {
            if (components.minute > 5) {
                countDownString = [NSString stringWithFormat:@"採用終了まで あと%ld分", (long)components.minute];
            }
            else {
                countDownString = NSLocalizedString(@"まもなく終了！", nil);
            }
        }
        self.timeUntilAdoptEndLabel.text = countDownString;
    }
    else {
        self.timeUntilAdoptEndLabel.text  = NSLocalizedString(@"採用終了まで あと0分", nil);
    }
}

#pragma mark - Table delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.recruitmentModel) {
        if (self.recruitmentModel.adoptionList.count > 0) {
            return 3;
        }
        else {
            return 2;
        }
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    else if (section == 1) {
        if (self.recruitmentModel.applicantList.count == 0) {
            return 1;
        }
        else
            return self.recruitmentModel.applicantList.count;
    }
    else if (section == 2) {
        return self.recruitmentModel.adoptionList.count;
    }
    return 0;
}

- (CGFloat)       tableView:(UITableView *)tableView
    heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 80.0;
    }
    else
        return 90.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0.0;
    }
    else {
        return 30.0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        QKRecruitmentStatusJobCell *jobCell = [tableView dequeueReusableCellWithIdentifier:@"QKRecruitmentStatusJobCell"];
        jobCell.recruitmentModel = self.recruitmentModel;
        return jobCell;
    }
    else {
        if (self.recruitmentModel.applicantList.count == 0 && indexPath.section == 1) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"QKNoHaveApplicantCell"];
            return cell;
        }
        else {
            QKRecruitmentStatusApplicantCell *cell = [tableView dequeueReusableCellWithIdentifier:@"QKRecruitmentStatusApplicantCell"];
            if (indexPath.section == 1) {
                QKCLApplicantUserModel *applicantModel = [self.recruitmentModel.applicantList objectAtIndex:indexPath.row];
                [cell.applicantImageView setImageWithURL:applicantModel.applicantUserImageUrl placeholderImage:[UIImage imageNamed:@"account_pic_blankprofile"]];
                cell.applicantNameLabel.text = applicantModel.applicantUserName;
                NSLog(@"sexflagname%@",applicantModel.applicantUserAccountSexFlgName);
                cell.applicantAgeAndGenderLabel.text = [NSString stringWithFormat:@"(%d歳・%@)", [self getAgeFromBirthDay:applicantModel.applicantUserBirthday], applicantModel.applicantUserAccountSexFlgName];
                cell.messageLabel.hidden = ![applicantModel.adoptedAtSamePeriod isEqualToString:[NSString stringFromConst:QK_ADOPTED_AT_SAME_PERIOD_YES]];
                cell.favoriteImageView.hidden = YES;
            }
            else {
                QKCLAdoptionUserModel *adoptionModel = [self.recruitmentModel.adoptionList objectAtIndex:indexPath.row];
                [cell.applicantImageView setImageWithURL:adoptionModel.adoptionUserImagePath];
                cell.applicantNameLabel.text = adoptionModel.adoptionUserName;
                cell.applicantAgeAndGenderLabel.text = [NSString stringWithFormat:@"(%d歳・%@)", [self getAgeFromBirthDay:adoptionModel.adoptionUserBirthday], adoptionModel.adoptionUserAccountSexFlgName];
                 NSLog(@"sexflagname%@",adoptionModel.adoptionUserAccountSexFlgName);
                cell.favoriteImageView.hidden = YES;
            }
            return cell;
        }
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 1) {
        QKCLApplicantUserModel *applicantModel = (QKCLApplicantUserModel *)[self.recruitmentModel.applicantList objectAtIndex:indexPath.row];
        self.customerUserId = applicantModel.applicantUserId;
        self.isAdoptUser = NO;
        [self performSegueWithIdentifier:@"QKShowApplicantDetailSegue" sender:self];
    }
    else if (indexPath.section == 2) {
        QKCLAdoptionUserModel *adoptionModel = [self.recruitmentModel.adoptionList objectAtIndex:indexPath.row];
        self.customerUserId = adoptionModel.adoptionUserId;
        self.isAdoptUser = YES;
        [self performSegueWithIdentifier:@"QKShowApplicantDetailSegue" sender:self];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return @"";
            break;
            
        case 1:
            return @"応募者";
            break;
            
        case 2:
            return @"採用済";
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
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"QKShowApplicantDetailSegue"]) {
        QKCLApplicantDetailViewController *applicantVC = (QKCLApplicantDetailViewController *)[segue destinationViewController];
        applicantVC.recruitmentModel = self.recruitmentModel;
        applicantVC.customerUserId = self.customerUserId;
        for (QKCLApplicantUserModel *applicant in self.recruitmentModel.applicantList) {
            if ([applicant.applicantUserId isEqualToString:self.customerUserId]) {
                applicantVC.freeQAList = applicant.freeQaList;
                break;
            }
        }
        if (self.isAdoptUser) {
            applicantVC.mode = QKApplicantDetailModeBeforeWorking;
        }
    }
}

#pragma mark - Ultilities

- (NSInteger)getAgeFromBirthDay:(NSDate *)birthday {
    NSDate *now = [NSDate date];
    NSDateComponents *ageComponents = [[NSCalendar currentCalendar]
                                       components:NSCalendarUnitYear
                                       fromDate:birthday
                                       toDate:now
	                                      options:0];
    return [ageComponents year];
}

- (IBAction)stopRecruitment:(id)sender {
    self.confirmAlertView = [[CCAlertView alloc] initWithTitle:@"募集を中止しますか？" message:@"募集を中止すると応募者や\n投稿された質問が失われてしまいます" delegate:self buttonTitles:@[@"キャンセル", @"中止する"]];
    [self.confirmAlertView showAlert];
}

#pragma mark - CCAlertViewDelegate

- (void)alertView:(CCAlertView *)alertView selectedButtonIndex:(NSInteger)index {
    if (self.confirmAlertView == alertView) {
        if (index == 1) {
            if ([self connected]) {
                NSMutableDictionary *params = [NSMutableDictionary initWithApiKeyAndToken];
                [params setObject:[QKCLAccessUserDefaults getUserId] forKey:@"userId"];
                [params setObject:self.recruitmentId forKey:@"recruitmentId"];
                
                [[QKCLRequestManager sharedManager] asyncPOST:[NSString stringFromConst:qkUrlRecruitmentTerminate] parameters:params showLoading:YES showError:YES success: ^(AFHTTPRequestOperation *operation, id responseObject) {
                    NSLog(@"statuscd succes %@", responseObject[QK_STT_CODE_SUCCESS]);
                    if ([responseObject[QK_API_STATUS_CODE] isEqualToString:[NSString stringFromConst:QK_STT_CODE_SUCCESS]]) {
                        self.completeAlertView = [[CCAlertView alloc] initWithImage:[UIImage imageNamed:@"dialog_pic_delete"] title:@"募集を中止しました" message:@"今回の募集内容を複製して\n再度募集することができます" delegate:self buttonTitles:@[@"OK"]];
                        [self.completeAlertView showAlert];
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
        }
    }
    else if (self.completeAlertView == alertView) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)timerFired {
    [self reloadCountDownLabel];
}

- (IBAction)showApplicant:(id)sender {
    [self performSegueWithIdentifier:@"QKShowApplicantDetailSegue" sender:self];
}

- (void)reloadTotalNum {
    QKCLRecruitmentInformationViewController *recInfoViewController = (QKCLRecruitmentInformationViewController *)self.parentViewController;
    NSInteger totalApplicant = self.recruitmentModel.applicantList.count;
    if (totalApplicant > 0) {
        [recInfoViewController.leftButton setTitle:[NSString stringWithFormat:@"募集内容(%ld)", (long)totalApplicant] forState:UIControlStateNormal];
        
        [recInfoViewController.leftButton setTitle:[NSString stringWithFormat:@"募集内容(%ld)", (long)totalApplicant] forState:UIControlStateSelected];
    }
    else {
        [recInfoViewController.leftButton setTitle:@"募集内容" forState:UIControlStateNormal];
        
        [recInfoViewController.leftButton setTitle:@"募集内容" forState:UIControlStateSelected];
    }
    
    //question
    NSInteger qaCount = self.recruitmentModel.unansweredQaList.count;
    if (qaCount > 0) {
        [recInfoViewController.rightButton setTitle:[NSString stringWithFormat:@"質問(%ld)", (long)qaCount] forState:UIControlStateNormal];
        
        [recInfoViewController.rightButton setTitle:[NSString stringWithFormat:@"質問(%ld)", (long)qaCount] forState:UIControlStateSelected];
        [recInfoViewController.rightButton1 setTitle:[NSString stringWithFormat:@"質問(%ld)", (long)qaCount] forState:UIControlStateNormal];
        
        [recInfoViewController.rightButton1 setTitle:[NSString stringWithFormat:@"質問(%ld)", (long)qaCount] forState:UIControlStateSelected];
    }
    else {
        [recInfoViewController.rightButton setTitle:@"質問" forState:UIControlStateNormal];
        
        [recInfoViewController.rightButton setTitle:@"質問" forState:UIControlStateSelected];
        [recInfoViewController.rightButton1 setTitle:@"質問" forState:UIControlStateNormal];
        
        [recInfoViewController.rightButton1 setTitle:@"質問" forState:UIControlStateSelected];
    }
}

@end

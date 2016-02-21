//
//  QKJobHistoryViewController.m
//  quicker-cs-ios
//
//  Created by LongPD-PC on 5/7/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKJobHistoryViewController.h"
#import "JobHistoryTableViewCell.h"
#import "QKJobHistoryModel.h"
#import "QKTextViewTableViewCell.h"
#import "QKTableViewCell.h"
#import "QKJobTileModel.h"
#import "JobTypeMViewController.h"
#import "JobTypeSViewController.h"
#import "QKGlobalPickerView.h"
#import "QKCropImageViewController.h"
#import "QKCameraViewController.h"
#import "QKProfileDetailModel.h"
#import "QKCSWebViewController.h"
#import "QKLocationService.h"

#define  QK_CS_JOBHISTORY_MAX  10

@interface QKJobHistoryViewController () <UITextViewDelegate, QKGlobalPickerViewDelegate, QKCropImageViewControllerDelegate, QKTextViewCellDelegate, QKTextViewDelegate>
@property (strong, nonatomic) QKGlobalPickerView *qkPickerViewPaymentValue;
@property (strong, nonatomic) NSString *imageId;
@property (strong, nonatomic) UIImage *avatarImage;
@property (strong, nonatomic) QKProfileDetailModel *profileDetail;
@end

@implementation QKJobHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = NSLocalizedString(@"履歴書", nil);
    [self setAngleLeftBarButton];
    [self.finishButton setEnabled:NO];
    self.selfPromotionTextView.textView.placeholderTextColor = [UIColor darkGrayColor];
    self.educationTextView.textView.placeholderTextColor = [UIColor darkGrayColor];
    self.questionTextView.textView.placeholderTextColor = [UIColor darkGrayColor];
    
    self.selfPromotionTextView.delegate = self;
    self.educationTextView.delegate = self;
    self.jobTextView.delegate = self;
    self.jobTextView.textView.placeholderTextColor = [UIColor darkGrayColor];
    self.titles = [NSArray arrayWithObjects:@"業種", @"ジャンル", @"職種", @"働いていた期間", @"", @"", nil];
    self.jobHistorys = [NSMutableArray new];
    [self setRightBarButtonWithTitle:@"スキップ" target:@selector(skipAddHistory)];
    self.educationTextView.textView.placeholder = @"(例) \n・在学中の学校/学部/学年 \n・卒業済みの学校/学部 など";
    self.selfPromotionTextView.textView.placeholder = @"担当者に知ってほしい資格やスキル、あなたの長所などをご自由に記入してください";
    self.jobTextView.textView.placeholder = @"居酒屋は三年程度やっていたので初めてのお店でもすぐ働ける自信があります。宜しくお願いします!";
    self.questionTextView.textView.placeholder = @"回答を入力してください";
    
    if (_mode == QKCVmodeModeEdit) {
        self.contentLabel.text = @"内容を充実させるほど採用されやすくなります!";
        self.statusView.hidden = YES;
        self.tableViewConstraintToTop.constant = -50;
        self.tableViewcontraintToBottom.constant = 50;
        self.finishButton.hidden = YES;
        self.navigationItem.rightBarButtonItem = nil;
        self.applyView.hidden = YES;
        self.headerView.height = 215;
        self.historyViewContraintHeight.constant = 215;
        self.avatarViewcontraintToTop.constant = -475;
        self.contentContraintHeight.constant = 20;
        self.avatarToTopConstraint.constant = 50;
        self.tipInputLabel.hidden = YES;
        self.footerView.height = 530;
        self.historyContraintToTop.constant = 30;
        self.recruitmentFooterView.hidden = YES;
        self.avatarToTopConstraint.constant = 20;
        [self getCvJob];
        [self getprofile];
    }
    else if (self.mode == QKCVModeRecruitment) {
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(didUpdateLocation:) name:QKLocationChangedNotification object:nil];
        self.navigationItem.title = NSLocalizedString(@"応募完了", nil);
        [self.finishButton setEnabled:YES];
        self.tableViewConstraintToTop.constant = -50;
        self.tableViewcontraintToBottom.constant = 50;
        self.templateView.hidden = NO;
        self.contentLabel.text = @"履歴書の内容を充実されるほど採用されやすくなり\nます。一度入力した情報は今後応募するときにも\n利用できるので、入力の手間を短縮できます。";
        [self.finishButton setTitle:@"同意して送信" forState:UIControlStateNormal];
        [self.finishButton setTitle:@"同意して送信" forState:UIControlStateSelected];
        [self.finishButton setTitleColor:[UIColor colorWithRed:255.0 / 255.0 green:255.0 / 255.0 blue:255.0 / 255.0 alpha:1]  forState:UIControlStateNormal];
        if (self.finishButton.enabled == YES) {
            [self.finishButton setBackgroundColor:kQKColorBtnPrimary];
        }
        else {
            [self.finishButton setBackgroundColor:kQKColorDisabled];
        }
        [self getCvJob];
        [self getprofile];
    }
    else if (self.mode == QKCVmodeNormal) {
        self.contentLabel.text = @"内容を充実させると採用担当者の目に止まりやすくな\nります。";
        self.recruitmentFooterView.hidden = YES;
        self.footerView.height = 530;
        self.templateView.hidden = YES;
        self.finishButtonConstraintToTop.constant = 30;
        self.applyView.hidden = YES;
        self.headerView.height = 215;
        self.historyViewContraintHeight.constant = 215;
        self.avatarViewcontraintToTop.constant = -475;
        self.contentContraintHeight.constant = 40;
        self.avatarToTopConstraint.constant = 20;
        self.tipInputLabel.hidden = YES;
    }
    
    [[NSNotificationCenter defaultCenter] addObserverForName:@"QKDidSelectJobTypeL" object:nil queue:nil usingBlock: ^(NSNotification *note) {
        QKJobTileModel *jobTileL = (QKJobTileModel *)[note object];
        QKJobHistoryModel *jobModel = [self.jobHistorys objectAtIndex:_sectionSelecting];
        jobModel.jobtypeL = jobTileL;
        [self.jobHistoryTableView reloadData];
        [self enableFinishbutton];
    }];
    [[NSNotificationCenter defaultCenter] addObserverForName:@"QKDidSelectJobTypeM" object:nil queue:nil usingBlock: ^(NSNotification *note) {
        QKJobTileModel *jobTileM = (QKJobTileModel *)[note object];
        QKJobHistoryModel *jobModel = [self.jobHistorys objectAtIndex:_sectionSelecting];
        jobModel.jobtypeM = jobTileM;
        [self.jobHistoryTableView reloadData];
        [self enableFinishbutton];
    }];
    [[NSNotificationCenter defaultCenter] addObserverForName:@"QKDidSelectJobTypeS" object:nil queue:nil usingBlock: ^(NSNotification *note) {
        QKJobTileModel *jobTileS = (QKJobTileModel *)[note object];
        QKJobHistoryModel *jobModel = [self.jobHistorys objectAtIndex:_sectionSelecting];
        jobModel.jobtypeS = jobTileS;
        [self.jobHistoryTableView reloadData];
        [self enableFinishbutton];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - call api
- (void)getprofile {
    if ([self connected]) {
        NSMutableDictionary *params = [NSMutableDictionary initWithApiKeyAndToken];
        [params setObject:[QKAccessUserDefaults getUserId] forKey:@"userId"];
        [[QKRequestManager sharedManager] asyncGET:[NSString stringFromConst:qkCSUrlProfileDetail] parameters:params showLoading:YES showError:YES success: ^(AFHTTPRequestOperation *operation, id responseObject) {
            if ([responseObject[QK_API_STATUS_CODE] isEqualToString:[NSString stringFromConst:QK_STT_CODE_SUCCESS]]) {
                _profileDetail = [[QKProfileDetailModel alloc]initWithResponse:responseObject];
                [self setProfileInterface];
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

- (void)getCvJob {
    if ([self connected]) {
        NSMutableDictionary *params = [NSMutableDictionary initWithApiKeyAndToken];
        [params setObject:[QKAccessUserDefaults getUserId] forKey:@"userId"];
        
        [[QKRequestManager sharedManager] asyncGET:[NSString stringFromConst:qkCSUrlProfileList] parameters:params showLoading:YES showError:YES success: ^(AFHTTPRequestOperation *operation, id responseObject) {
            if ([responseObject[QK_API_STATUS_CODE] isEqualToString:[NSString stringFromConst:QK_STT_CODE_SUCCESS]]) {
                for (NSDictionary *res  in responseObject[@"careerList"]) {
                    QKJobHistoryModel *model = [[QKJobHistoryModel alloc]initWithResponse:res];
                    [_jobHistorys addObject:model];
                }
                [self.jobHistoryTableView reloadData];
            }
            else {
                NSLog(@"responseObject : %@ ", responseObject[@"msg"]);
            }
        } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
        }];
    }
    else {
        [self showNoInternetViewWithSelector:@selector(getCvJob)];
    }
}

- (void)callAPIAddJobHistory {
    if (_jobHistorys.count == 0) {
        return;
    }
    if ([self connected]) {
        NSMutableArray *array = [NSMutableArray new];
        for (int i = 0; i < _jobHistorys.count; i++) {
            QKJobHistoryModel *jobhistoryEntity = [_jobHistorys objectAtIndex:i];
            NSDictionary *entry = [[NSDictionary alloc] initWithObjectsAndKeys:
                                   jobhistoryEntity.jobtypeL.jobTile, @"jobTypeLCd",
                                   jobhistoryEntity.jobtypeM.jobTile, @"jobTypeMCd",
                                   jobhistoryEntity.jobtypeS.jobTile, @"jobTypeSCd",
                                   jobhistoryEntity.jobContent, @"freeText",
                                   jobhistoryEntity.jobPeriod, @"servicePeriod",
                                   
                                   nil];
            [array addObject:entry];
        }
        NSError *errorDictionary;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:array
                                                           options:NSJSONWritingPrettyPrinted
                                                             error:&errorDictionary];
        NSMutableDictionary *params = [NSMutableDictionary initWithApiKeyAndToken];
        [params setValue:[QKAccessUserDefaults getUserId] forKey:@"userId"];
        if (!jsonData) {
            NSLog(@"Got an error: %@", errorDictionary);
        }
        else {
            NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            [params setValue:jsonString forKey:@"json"];
            [[QKRequestManager sharedManager] asyncPOST:[NSString stringFromConst:qkCSUrlProfileCareer] parameters:params showLoading:NO showError:NO success: ^(AFHTTPRequestOperation *operation, id responseObject) {
                NSLog(@"Add profile successful...");
            } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
                NSLog(@"Add profile fail...");
            }];
        }
        //merritmask
    }
    else {
        [self showNoInternetViewWithSelector:nil];
    }
}

- (void)callAPISaveProfile {
    NSMutableDictionary *params = [NSMutableDictionary initWithApiKeyAndToken];
    [params setObject:[QKAccessUserDefaults getUserId] forKey:@"userId"];
    [params setObject:self.selfPromotionTextView.textView.text forKey:@"selfPromotion"];
    [params setObject:self.educationTextView.textView.text forKey:@"education"];
    [params setValue:[QKAccessUserDefaults getPassword] forKey:@"password"];
    [[QKRequestManager sharedManager] asyncPOST:[NSString stringFromConst:qkCSUrlProfileRegist] parameters:params showLoading:YES showError:YES constructingBodyWithBlock: ^(id <AFMultipartFormData> formData) {
        if (_avatarImage) {
            [formData appendPartWithFileData:UIImageJPEGRepresentation(_avatarImage, 1.0f) name:@"imageFile" fileName:@"image.jpeg" mimeType:@"image/jpeg"];
        }
    } success: ^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"upload success...");
    } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Upload photo error...");
    }];
}

- (void)callAPIApplicationInfoRegiest {
    if ([self connected]) {
        NSMutableDictionary *params = [NSMutableDictionary initWithApiKeyAndToken];
        [params setObject:[QKAccessUserDefaults getUserId] forKey:@"userId"];
        [params setObject:self.recruitmentModel.recruitmentId forKey:@"recruitmentId"];
        [params setObject:self.recruitmentModel.freeQId forKey:@"freeQId"];
        [params setObject:self.questionTextView.textView.text forKey:@"answer"];
        [params setObject:self.jobTextView.textView.text forKey:@"selfPromotion"];
        //        [params setObject:[NSString stringWithFormat:@"%f,%f",_lat,_lng] forKey:@"latLng"];
        [params setObject:[NSString stringWithFormat:@"%f,%f", 35.658129, 139.702133] forKey:@"latLng"];
        
        [[QKLocationService sharedLocation] updateLocation];
        [[QKRequestManager sharedManager] asyncPOST:[NSString stringFromConst:qkCSUrlApplicationInfoRegiest] parameters:params showLoading:YES showError:YES success: ^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"ApplicationInfo success");
        } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"ApplicationInfo fail");
        }];
    }
    else {
        [self showNoInternetViewWithSelector:nil];
    }
    [[QKLocationService sharedLocation] stopUpdatingLocation];
}

# pragma mark - Tableview delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _jobHistorys.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 4) {
        return 120;
    }
    else {
        return 44;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *jobHistoryContentCellIdentifier = @"QKJobHistoryContentCell";
    if (indexPath.row ==  4) {
        QKTextViewTableViewCell *jobHistoryContentTableViewCell = (QKTextViewTableViewCell *)[tableView dequeueReusableCellWithIdentifier:jobHistoryContentCellIdentifier];
        if (jobHistoryContentTableViewCell == nil) {
            jobHistoryContentTableViewCell = [UIView loadFromNibNamed:@"QKTextViewTableViewCell"];
        }
        jobHistoryContentTableViewCell.contentTextView.textView.placeholder = @"詳しい仕事内容や働いていたお店について";
        jobHistoryContentTableViewCell.delegate = self;
        [jobHistoryContentTableViewCell setCVInterFace];
        QKJobHistoryModel *jobHistory = (QKJobHistoryModel *)[self.jobHistorys objectAtIndex:indexPath.section];
        [jobHistoryContentTableViewCell setDelegate:self];
        
        jobHistoryContentTableViewCell.text = jobHistory.jobContent;
        return jobHistoryContentTableViewCell;
    }
    else {
        QKTableViewCell *jobHistoryTableViewCell = (QKTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"JobHistoryTableViewCell"];
        if (!jobHistoryTableViewCell) {
            jobHistoryTableViewCell = [[QKTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                                            reuseIdentifier :@"JobHistoryTableViewCell"];
        }
        
        [jobHistoryTableViewCell.textLabel setText:[self.titles objectAtIndex:indexPath.row]];
        QKJobHistoryModel *jobHistory;
        if (self.jobHistorys.count > 0) {
            jobHistory  = (QKJobHistoryModel *)[self.jobHistorys objectAtIndex:indexPath.section];
        }
        if (indexPath.row == 0) {
            if (jobHistory.jobtypeL.jobName.length == 0) {
                [jobHistoryTableViewCell.detailTextLabel setText:@"選択してください"];
                jobHistoryTableViewCell.detailTextLabel.textColor = [UIColor grayColor];
            }
            else {
                [jobHistoryTableViewCell.detailTextLabel setText:jobHistory.jobtypeL.jobName];
                jobHistoryTableViewCell.detailTextLabel.textColor = [UIColor grayColor];
            }
        }
        else if (indexPath.row == 1) {
            if (jobHistory.jobtypeM.jobName.length == 0) {
                [jobHistoryTableViewCell.detailTextLabel setText:@"選択してください"];
                jobHistoryTableViewCell.detailTextLabel.textColor = [UIColor grayColor];
            }
            else {
                [jobHistoryTableViewCell.detailTextLabel setText:jobHistory.jobtypeM.jobName];
                jobHistoryTableViewCell.detailTextLabel.textColor = [UIColor grayColor];
            }
        }
        else if (indexPath.row == 2) {
            if (jobHistory.jobtypeS.jobName.length == 0) {
                [jobHistoryTableViewCell.detailTextLabel setText:@"選択してください"];
                jobHistoryTableViewCell.detailTextLabel.textColor = [UIColor grayColor];
            }
            else {
                [jobHistoryTableViewCell.detailTextLabel setText:jobHistory.jobtypeS.jobName];
                jobHistoryTableViewCell.detailTextLabel.textColor = [UIColor grayColor];
            }
        }
        else if (indexPath.row == 3) {
            if ([jobHistoryTableViewCell respondsToSelector:@selector(setSeparatorInset:)]) {
                [jobHistoryTableViewCell setSeparatorInset:UIEdgeInsetsZero];
            }
            
            // Prevent the cell from inheriting the Table View's margin settings
            if ([jobHistoryTableViewCell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
                [jobHistoryTableViewCell setPreservesSuperviewLayoutMargins:NO];
            }
            
            // Explictly set your cell's layout margins
            if ([jobHistoryTableViewCell respondsToSelector:@selector(setLayoutMargins:)]) {
                [jobHistoryTableViewCell setLayoutMargins:UIEdgeInsetsZero];
            }
            if (jobHistory.jobPeriod.length == 0) {
                [jobHistoryTableViewCell.detailTextLabel setText:@"選択してください"];
                jobHistoryTableViewCell.detailTextLabel.textColor = [UIColor grayColor];
            }
            else {
                [jobHistoryTableViewCell.detailTextLabel setText:[[QKConst PERIOD_MAP] objectForKey:jobHistory.jobPeriod]];
                jobHistoryTableViewCell.detailTextLabel.textColor = [UIColor grayColor];
            }
        }
        else if (indexPath.row == 5) {
            JobHistoryTableViewCell *deleteCVTableViewCell = (JobHistoryTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"deleteCVTableViewCell"];
            if (deleteCVTableViewCell == nil) {
                deleteCVTableViewCell = [UIView loadFromNibNamed:@"JobHistoryTableViewCell"];
            }
            [deleteCVTableViewCell setdeleteLabelNumber:indexPath.section + 1];
            return deleteCVTableViewCell;
        }
        return jobHistoryTableViewCell;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        [self performSegueWithIdentifier:@"showJobtypeLSegue" sender:self];
    }
    else if (indexPath.row == 1) {
        QKJobHistoryModel *jobHistory = (QKJobHistoryModel *)[self.jobHistorys objectAtIndex:indexPath.section];
        if (jobHistory.jobtypeL.jobName.length == 0) {
            return;
        }
        [self performSegueWithIdentifier:@"showJobtypeMSegue" sender:self];
    }
    else if (indexPath.row == 2) {
        QKJobHistoryModel *jobHistory = (QKJobHistoryModel *)[self.jobHistorys objectAtIndex:indexPath.section];
        if (jobHistory.jobtypeM.jobName.length == 0) {
            return;
        }
        [self performSegueWithIdentifier:@"showJobtypeSSegue" sender:self];
    }
    else if (indexPath.row == 3) {
        [self makeSortTypePickerView];
    }
    else if (indexPath.row == 5) {
        [_jobHistorys removeObjectAtIndex:indexPath.section];
        [self.jobHistoryTableView reloadData];
        [self.addJobhistoryButton setEnabled:YES];
        
        if (_jobHistorys.count == 0) {
            [self.addJobhistoryButton setTitle:@"+ バイト歴を登録" forState:UIControlStateNormal];
            [self.addJobhistoryButton setTitle:@"+ バイト歴を登録" forState:UIControlStateSelected];
            [self enableFinishbutton];
        }
    }
    _sectionSelecting = indexPath.section;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [NSString stringWithFormat:@"バイト歴%d", section + 1];
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    UITableViewHeaderFooterView *v = (UITableViewHeaderFooterView *)view;
    v.backgroundView.backgroundColor = kQKGlobalBackgroundGrayBlueColor;
    [v.textLabel setFont:[UIFont systemFontOfSize:15.0]];
}

#pragma mark - dealloc

- (void)dealloc {
    [_jobHistoryTableView setDelegate:nil];
}

#pragma mark - action

- (void)enableFinishbutton {
    if ([self checkAllField]) {
        [self.finishButton setEnabled:YES];
    }
    else {
        [self.finishButton setEnabled:NO];
    }
}

- (BOOL)checkAllField {
    BOOL result = YES;
    if (self.selfPromotionTextView.textView.text.length == 0 ||
        self.educationTextView.textView.text.length == 0 ||
        self.avatarImageView.image == nil
        ) {
        result = NO;
    }
    if (_jobHistorys.count > 0) {
        for (int i = 0; i < _jobHistorys.count; i++) {
            QKJobHistoryModel *jobHistory = [_jobHistorys objectAtIndex:i];
            if (jobHistory.jobtypeL == nil ||
                jobHistory.jobtypeM == nil ||
                jobHistory.jobtypeS == nil ||
                jobHistory.jobContent == nil ||
                jobHistory.jobPeriod.length == 0) {
                result = NO;
            }
        }
    }
    return result;
}

- (void)popToRecruitmentDetail {
    NSUInteger ownIndex = [self.navigationController.viewControllers indexOfObject:self];
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:ownIndex - 1] animated:YES];
}

- (IBAction)addMoreHistory:(id)sender {
    QKJobHistoryModel *jobHistory  = [QKJobHistoryModel new];
    [self.jobHistorys addObject:jobHistory];
    [self.jobHistoryTableView reloadData];
    [self.addJobhistoryButton setTitle:@"+ 別のバイト歴を登録" forState:UIControlStateNormal];
    [self.addJobhistoryButton setTitle:@"+ 別のバイト歴を登録" forState:UIControlStateSelected];
    [self enableFinishbutton];
    if (self.jobHistorys.count == QK_CS_JOBHISTORY_MAX) {
        [self.addJobhistoryButton setEnabled:NO];
    }
}

- (IBAction)saveJobHistoryClicked:(id)sender {
    [self saveProfileAndCV];
    CCAlertView *successMessage;
    if (self.mode == QKCVModeRecruitment) {
        [self callAPIApplicationInfoRegiest];
        successMessage  = [[CCAlertView alloc] initWithImage:[UIImage imageNamed:@"dialog_pic_done"] title:@"送信しました" andMessage:nil style:QKAlertViewStyleWhite];
    }
    else {
        successMessage = [[CCAlertView alloc] initWithImage:[UIImage imageNamed:@"dialog_pic_done"] title:@"登録が完了しました" message:nil delegate:self buttonTitles:@[@"次へ"]];
    }
    
    successMessage.delegate = self;
    [successMessage showAlert];
}

- (void)saveProfileAndCV {
    [self callAPIAddJobHistory];
    [self callAPISaveProfile];
}

- (void)skipAddHistory {
    [self saveProfileAndCV];
    if (self.mode == QKCVModeRecruitment) {
        [self callAPIApplicationInfoRegiest];
        [[NSNotificationCenter defaultCenter]
         postNotificationName:@"updateEditCV"
         object:self];
        [self popToRecruitmentDetail];
    }
    else if (self.mode == QKCVmodeNormal) {
        [self gotoMainMenu];
    }
}

- (void)goBack:(id)sender {
    if (self.mode == QKCVmodeModeEdit) {
        [self saveProfileAndCV];
    }
    [super goBack:sender];
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

- (void)setProfileInterface {
    [self.educationTextView setText:_profileDetail.education];
    [self.selfPromotionTextView setText:_profileDetail.selfPromotion];
    if (_profileDetail.avatarURL != nil) {
        [self.avatarImageView setImageWithQKURL:_profileDetail.avatarURL placeholderImage:[UIImage imageNamed:@"account_pic_blankprofile"] withCache:NO];
        self.avatarLabel.hidden = YES;
        self.avatarLabelContraintToTop.constant = 47;
    }
}

- (void)gotoMainMenu {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    UINavigationController *mainMenuNavigationViewController = [storyboard instantiateViewControllerWithIdentifier:@"QKNavigationMainMenuViewController"];
    [[UIApplication sharedApplication] keyWindow].rootViewController = mainMenuNavigationViewController;
    [[[UIApplication sharedApplication] keyWindow] makeKeyAndVisible];
}

- (void)didUpdateLocation:(NSNotification *)notification {
    _lat = [[QKLocationService sharedLocation] latitude];
    _lng = [[QKLocationService sharedLocation] longitude];
    NSLog(@"lat :%f", [[QKLocationService sharedLocation] latitude]);
}

#pragma mark - pickerView
- (void)makeSortTypePickerView {
    if (!self.qkPickerViewPaymentValue) {
        self.qkPickerViewPaymentValue = [[QKGlobalPickerView alloc] init];
        self.qkPickerViewPaymentValue.delegate = self;
    }
    [self.qkPickerViewPaymentValue setPickerData:[[QKConst PERIOD_MAP] allValues]];
    //    if (_filter.sortCd != nil && ![_filter.sortCd isEqualToString:@""]) {
    //        [self.qkPickerViewPaymentValue setSelectedIndex:[[[QKConst SORT_TYPE_MAP] allKeys] indexOfObject:_filter.sortCd]];
    //    }
    
    [self.qkPickerViewPaymentValue show];
}

#pragma mark- PickerViewDelegate

- (void)donePickerView:(QKGlobalPickerView *)pickerView selectedIndex:(NSInteger)selectedIndex {
    QKJobHistoryModel *jobModel = [self.jobHistorys objectAtIndex:_sectionSelecting];
    
    jobModel.jobPeriod =  [[[QKConst PERIOD_MAP] allKeys] objectAtIndex:selectedIndex];
    [self.jobHistoryTableView reloadData];
    [self enableFinishbutton];
}

#pragma mark - uitextview delegate
- (void)editingTextChanged:(NSString *)textContent {
    QKJobHistoryModel *jobModel = [self.jobHistorys objectAtIndex:_sectionSelecting];
    jobModel.jobContent = textContent;
    [self enableFinishbutton];
}

- (void)editingChanged:(UITextView *)textView {
    [self enableFinishbutton];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showJobtypeMSegue"]) {
        JobTypeMViewController *jobTypeMViewController = (JobTypeMViewController *)[segue destinationViewController];
        QKJobHistoryModel *jobModel = [self.jobHistorys objectAtIndex:_sectionSelecting];
        jobTypeMViewController.jobHistoryModel = jobModel;
    }
    else if ([[segue identifier] isEqualToString:@"showJobtypeSSegue"]) {
        JobTypeSViewController *jobTypeSViewController = (JobTypeSViewController *)[segue destinationViewController];
        QKJobHistoryModel *jobModel = [self.jobHistorys objectAtIndex:_sectionSelecting];
        jobTypeSViewController.jobHistoryModel = jobModel;
    }
    if ([segue.identifier isEqualToString:@"QKShowCameraSegue"]) {
        UINavigationController *nav = [segue destinationViewController];
        QKCameraViewController *cameraViewController = (QKCameraViewController *)nav.viewControllers[0];
        cameraViewController.hintSegue = @"QKCaptureAvatarHint";
        cameraViewController.presentingVC = self;
        cameraViewController.cropImageType = QKCropImageTypeSquare;
        cameraViewController.isCaptureForAvatar = YES;
    }
}

#pragma mark- IBActions
- (IBAction)changeAvatar:(id)sender {
    [self performSegueWithIdentifier:@"QKShowCameraSegue" sender:self];
}

#pragma mark -QKCropImageViewControllerDelegate
- (void)croppedImage:(UIImage *)image imageId:(NSString *)imageId {
    _imageId = imageId;
    _avatarImage = image;
    self.avatarImageView.image = image;
    [self enableFinishbutton];
}

#pragma mark - CCAlertView Delegate

- (void)clickOnAlertView:(CCAlertView *)alertView {
    if (self.mode == QKCVModeRecruitment) {
        [[NSNotificationCenter defaultCenter]
         postNotificationName:@"updateEditCV"
         object:self];
        [self popToRecruitmentDetail];
    }
    else {
        [self gotoMainMenu];
    }
}

- (void)alertView:(CCAlertView *)alertView selectedButtonIndex:(NSInteger)index {
    [self gotoMainMenu];
}

@end

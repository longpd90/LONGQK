//
//  QKConfirmationNewRecruitmentViewController.m
//  quicker-cl-ios
//
//  Created by Nguyen Viet Thang on 5/20/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLRecruitmentDetailViewController.h"
#import "QKCLShopInfoModel.h"
#import "QKShopDetailCell.h"
#import "QKRecruitmentCell.h"
#import "QKCLMasterPreferenceConditionModel.h"
#import "QKImageView.h"
#import "NSDate+Extra.h"
#import "QKCLRecruitmentNewStep1ViewController.h"

@interface QKCLRecruitmentDetailViewController () <UITableViewDelegate>
@property (strong, nonatomic) QKCLShopInfoModel *shopInfo;
@property (strong, nonatomic) NSMutableArray *listImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightOfPreferenceView;
@end

@implementation QKCLRecruitmentDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setAngleLeftBarButton];
    [self setupInterface];
    if (!_recruitmentModel) {
        _recruitmentModel = [[QKCLRecruitmentModel alloc]init];
    }
}

- (void)setupInterface {
    self.pageControl.backgroundColor = [UIColor clearColor];
    self.pageControl.tintColor = [UIColor lightTextColor];
    self.pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    CGFloat contentOffset = 0.0f;
    self.listImageView = [[NSMutableArray alloc] init];
    for (int i = 0; i < 3; i++) {
        CGRect imageViewFrame = CGRectMake(contentOffset, 0.0f, _scrollView.frame.size.width, _scrollView.frame.size.height);
        QKImageView *imageView = [[QKImageView alloc] initWithFrame:imageViewFrame];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [_scrollView addSubview:imageView];
        [self.listImageView addObject:imageView];
        contentOffset += imageView.frame.size.width;
    }
    //    [self changeSelectedCircleImage:1];
    //self.startJobButton.bigTile = @"この募集を保存する";
    //self.startJobButton.smallTile = @"本リリース後の募集に利用するできます";
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self loadRecruimentDetail];
}

- (void)loadRecruimentDetail {
    [self loadShopInfo];
    [self setUpScrollView];
    if (self.isDetailViewController) {
        [self loadRecruitmentInfo];
        self.startJobButton.hidden = YES;
    }
}

- (void)loadRecruitmentInfo {
    if ([self connected]) {
        NSMutableDictionary *params = [NSMutableDictionary initWithApiKeyAndToken];
        [params setObject:[QKCLAccessUserDefaults getUserId] forKey:@"userId"];
        [params setObject:[QKCLAccessUserDefaults getActiveShopId] forKey:@"shopId"];
        [params setObject:self.recruitmentModel.recruitmentId forKey:@"recruitmentId"];
        
        [[QKCLRequestManager sharedManager] asyncGET:[NSString stringFromConst:qkUrlRecruitmentDetail] parameters:params showLoading:YES showError:YES success: ^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"statuscd succes %@", responseObject[QK_STT_CODE_SUCCESS]);
            if ([responseObject[QK_API_STATUS_CODE] isEqualToString:[NSString stringFromConst:QK_STT_CODE_SUCCESS]]) {
                self.recruitmentModel = [[QKCLRecruitmentModel alloc]initWithResponse:responseObject];
                [self.tableView reloadData];
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
        [self showNoInternetViewWithSelector:@selector(loadRecruitmentInfo)];
    }
}

- (void)loadShopInfo {
    if ([self connected]) {
        NSMutableDictionary *params = [NSMutableDictionary initWithApiKeyAndToken];
        [params setObject:[QKCLAccessUserDefaults getUserId] forKey:@"userId"];
        [params setObject:[QKCLAccessUserDefaults getActiveShopId] forKey:@"shopId"];
        
        
        [[QKCLRequestManager sharedManager] asyncGET:[NSString stringFromConst:qkUrlShopDetail] parameters:params showLoading:YES showError:YES success: ^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"statuscd succes %@", responseObject[QK_STT_CODE_SUCCESS]);
            if ([responseObject[QK_API_STATUS_CODE] isEqualToString:[NSString stringFromConst:QK_STT_CODE_SUCCESS]]) {
                _shopInfo = [[QKCLShopInfoModel alloc]initWithResponse:responseObject];
                [self.tableView reloadData];
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
        [self showNoInternetViewWithSelector:@selector(loadShopInfo)];
    }
}

- (void)reloadInterface {
    if ([self.recruitmentModel.recruitmentStatus isEqualToString:[NSString stringFromConst:QK_REC_STATUS_DONE_REC]] || [self.recruitmentModel.recruitmentStatus isEqualToString:[NSString stringFromConst:QK_REC_STATUS_STOP]]) {
        self.topContraint.constant = 190.0;
        self.doneWorkerTopView.hidden = NO;
        [self.view bringSubviewToFront:self.doneWorkerTopView];
    }
    else if ([self.recruitmentModel.recruitmentStatus isEqualToString:[NSString stringFromConst:QK_REC_STATUS_DONE_WORKER]] || [self.recruitmentModel.recruitmentStatus isEqualToString:[NSString stringFromConst:QK_REC_STATUS_CLOSE_REC]]) {
        self.topContraint.constant = 210.0;
        self.doneRecruimentView.hidden = NO;
        [self.view bringSubviewToFront:self.doneRecruimentView];
    }
    else self.topContraint.constant = 0.0;
    self.shopNameLabel.text = self.shopInfo.name;
    [self loadImageInScrollView];
    self.shopAddress.text = [NSString stringWithFormat:@"%@ %@ %@ %@", _shopInfo.companyAddressPrfName, _shopInfo.companyAddressCityName, _shopInfo.companyAddress1, _shopInfo.companyAddress2];
    [self loadMap];
    [self loadDateTimeWorkLabel];
    [self otherInfor];
    [self waySideAndAccessWay];
    
    [self addPreferenceConditions];
    UIView *tableHeaderView = self.tableView.tableHeaderView;
    [tableHeaderView setNeedsLayout];
    [tableHeaderView layoutIfNeeded];
    CGRect frame = tableHeaderView.frame;
    frame.size.height = CGRectGetMaxY(self.preferenceConditionsView.frame) + 20.0;
    tableHeaderView.frame = frame;
    self.tableView.tableHeaderView = tableHeaderView;
}

- (void)loadImageInScrollView {
    self.pageControl.numberOfPages = self.shopInfo.imageFileList.count;
    for (QKCLImageModel *imageModel in self.shopInfo.imageFileList) {
        int index = (int)[self.shopInfo.imageFileList indexOfObject:imageModel];
        QKImageView *imageV = (QKImageView *)[self.listImageView objectAtIndex:index];
        [imageV setImageWithQKURL:imageModel.imageUrl withCache:YES];
    }
    _scrollView.contentSize = CGSizeMake(self.view.frame.size.width * self.pageControl.numberOfPages, _scrollView.frame.size.height);
}

- (void)addPreferenceConditions {
    float x = 0;
    float y = 0;
    float witdh = self.preferenceConditionsView.frame.size.width;
    float imageWitdh = 64.0;
    float imageHeight = 45.0;
    int i = 0;
    for (QKCLMasterPreferenceConditionModel *preCondition in self.recruitmentModel.preferenceConditionList) {
        if (x + imageWitdh > witdh) {
            x = 0;
            y = y + 5.0 + imageHeight;
        }
        UIImageView *imv = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, imageWitdh, imageHeight)];
        imv.image = [UIImage imageNamed:[NSString stringWithFormat:@"recruit_ic_conditions_%@", preCondition.preferenceConditionCd]];
        [self.preferenceConditionsView addSubview:imv];
        x = x + imageWitdh + 5.0;
        i++;
    }
    
    if (x == 0 && y == 0) {
        self.heightOfPreferenceView.constant = y;
    }
    else
        self.heightOfPreferenceView.constant = y + imageHeight;
}

- (void)otherInfor {
    self.employmentNumLabel.text = [NSString stringWithFormat:@"%ld名", (long)self.recruitmentModel.employmentNum];
    self.baggageAndClothesLabel.text = self.recruitmentModel.baggageAndClothes;
    if (self.recruitmentModel.transportationExpenses == 0) {
        self.transporationExpenses.text = NSLocalizedString(@"交通費：支給なし", nil);
    }
    else {
        self.transporationExpenses.text = [NSString stringWithFormat:@"交通費：別途%ld円を支給", (long)self.recruitmentModel.transportationExpenses];
    }
    if ([self.recruitmentModel.recess integerValue] == 0) {
        self.restTimeLabel.text = NSLocalizedString(@"休憩時間：なし", nil);
    }
    else {
        self.restTimeLabel.text = [NSString stringWithFormat:@"休憩：%@ 分含む", self.recruitmentModel.recess];
    }
    NSNumber *salary = [NSDecimalNumber numberWithInteger:self.recruitmentModel.salaryTotal];
    self.salaryLabel.text = [NSString stringWithFormat:@"%@円", [salary convertToCurrency]];
    NSTimeInterval diff = [self.recruitmentModel.endDt timeIntervalSinceDate:self.recruitmentModel.startDt] - self.recruitmentModel.recess.intValue * 60;
    int hours = lround(floor(diff / 3600.)) % 100;
    int minutes = lround(floor(diff / 60.)) % 60;
    NSString *salaryUnit = @"";
    if ([self.recruitmentModel.salaryUnit isEqualToString:[NSString stringFromConst:QK_SALARY_UNIT_HOUR]]) {
        salaryUnit = @"時給￼";
    }
    else if ([self.recruitmentModel.salaryUnit isEqualToString:[NSString stringFromConst:QK_SALARY_UNIT_DAY]]) {
        salaryUnit = @"日給";
    }
    else if ([self.recruitmentModel.salaryUnit isEqualToString:[NSString stringFromConst:QK_SALARY_UNIT_MONTH]]) {
        salaryUnit = @"月￼￼￼￼給";
    }
    
    NSNumber *salaryPerUnit = [NSDecimalNumber numberWithInteger:self.recruitmentModel.salaryPerUnit];
    self.salaryPerUnitLabel.text = [NSString stringWithFormat:@"(%@%@円×実働%d時間%d分)", salaryUnit, [salaryPerUnit convertToCurrency], hours, minutes];
    
    self.jobCategoryNameLabel.text = [NSString stringWithFormat:@"%@/%@", self.recruitmentModel.jobTypeMName, self.recruitmentModel.jobTypeSName];
}

- (void)loadDateTimeWorkLabel {
    // Get necessary date components
    //self.workStartDateLabel.text = [NSString stringWithFormat:@"勤務時間  %ld月 %ld日 (月)", (long)[components month], (long)[components day]];
    
    //[dateformat setDateFormat:@"HH:mm"];
    //self.workHourLabel.text = [NSString stringWithFormat:@"%@ ~ %@", [dateformat stringFromDate:self.recruitmentModel.startDt], [dateformat stringFromDate:self.recruitmentModel.endDt]];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:[[NSLocale preferredLanguages] objectAtIndex:0]]];
    [dateFormatter setDateFormat:@"EEE"];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:self.recruitmentModel.startDt];
    self.workStartDateLabel.text = [NSString stringWithFormat:@"%ld 月 %ld 日 ( %@ )", (long)[components month], (long)[components day], [dateFormatter stringFromDate:self.recruitmentModel.startDt]];
    [dateFormatter setDateFormat:@"HH:mm"];
    if ([self.recruitmentModel.startDt isSameDayWithDate:self.recruitmentModel.endDt]) {
        self.workHourLabel.text = [NSString stringWithFormat:@"%@ ~ %@", [dateFormatter stringFromDate:self.recruitmentModel.startDt], [dateFormatter stringFromDate:self.recruitmentModel.endDt]];
    }
    else {
        self.workHourLabel.text = [NSString stringWithFormat:@"%@ ~ 翌%@", [dateFormatter stringFromDate:self.recruitmentModel.startDt], [dateFormatter stringFromDate:self.recruitmentModel.endDt]];
    }
}

- (void)loadMap {
    NSString *url = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/staticmap?center=%@&zoom=14&size=512x512&maptype=roadmap\
                     &markers=size:mid|color:red|%@", self.shopInfo.latLng, self.shopInfo.latLng];
    
    [self.mapsImageView setImageWithURL:[NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
}

- (void)waySideAndAccessWay {
    self.waySide1Label.text = self.shopInfo.wayside1;
    self.waySide2Label.text = self.shopInfo.wayside2;
    self.waySide3Label.text = self.shopInfo.wayside3;
    self.accessWay.text = self.shopInfo.accessWay;
}

- (void)updateNewCruitment {
    if (self.connected) {
        NSMutableDictionary *params = [NSMutableDictionary initWithApiKeyAndToken];
        [params setObject:[QKCLAccessUserDefaults getUserId] forKey:@"userId"];
        [params setObject:[QKCLAccessUserDefaults getActiveShopId] forKey:@"shopId"];
        
        NSDictionary *response;
        NSError *error;
        BOOL result = [[QKCLRequestManager sharedManager] syncPOST:[NSString stringFromConst:qkUrlRecruitmentRegist] parameters:params response:&response error:&error showLoading:YES showError:YES];
        if (result) {
            NSLog(@"register recruitment success...");
        }
        else {
            NSLog(@"register recruitment fail...");
        }
    }
    else {
        [self showNoInternetViewWithSelector:nil];
    }
}

//setup pagin scroll with image
- (void)setUpScrollView {
    //set up for UIScrollView
    CGFloat contentOffset = 0.0f;
    for (int i = 0; i < 3; i++) {
        CGRect imageViewFrame = CGRectMake(contentOffset, 0.0f, _scrollView.frame.size.width, _scrollView.frame.size.height);
        QKImageView *imageView = (QKImageView *)self.listImageView[i];
        imageView.frame = imageViewFrame;
        contentOffset += imageView.frame.size.width;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (_scrollView == scrollView) {
        [_scrollView setContentOffset:CGPointMake(scrollView.contentOffset.x, 0)];
        float screen_size = self.scrollView.frame.size.width;
        self.pageControl.currentPage = scrollView.contentOffset.x / screen_size;
    }
}

#pragma TableView Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        QKRecruitmentCell *cell = (QKRecruitmentCell *)[tableView dequeueReusableCellWithIdentifier:@"CellView1"];
        if (cell == nil) {
            cell = [[QKRecruitmentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellView1"];
        }
        if (!self.des || [self.des isEqualToString:@""]) {
            cell.recruitmentDesTextView.text = self.recruitmentModel.descriptions;
        }
        else
            cell.recruitmentDesTextView.text = self.des;
        if (!self.applicationQualification || [self.applicationQualification isEqualToString:@""]) {
            cell.applicantQualificationTextView.text = self.recruitmentModel.applicantQualification;
        }
        else
            cell.applicantQualificationTextView.text = self.applicationQualification;
        if (self.recruitmentModel.personInChargeImageUrl) {
            [cell.personInChangeImageView setImageWithURL:self.recruitmentModel.personInChargeImageUrl];
        }
        
        cell.personInChargeNameLabel.text = @"採用担当者";
        return cell;
    }
    else {
        QKShopDetailCell *cell = (QKShopDetailCell *)[tableView dequeueReusableCellWithIdentifier:@"CellView2"];
        if (cell == nil) {
            cell = [[QKShopDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellView2"];
        }
        cell.shopDescriptionTextView.text = self.shopInfo.descriptions;
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        QKRecruitmentCell *cell = (QKRecruitmentCell *)[tableView dequeueReusableCellWithIdentifier:@"CellView1"];
        if (cell == nil) {
            cell = [[QKRecruitmentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellView1"];
        }
        if (!self.des || [self.des isEqualToString:@""]) {
            cell.recruitmentDesTextView.text = self.recruitmentModel.descriptions;
        }
        else
            cell.recruitmentDesTextView.text = self.des;
        if (!self.applicationQualification || [self.applicationQualification isEqualToString:@""]) {
            cell.applicantQualificationTextView.text = self.recruitmentModel.applicantQualification;
        }
        else
            cell.applicantQualificationTextView.text = self.applicationQualification;
        [cell.personInChangeImageView setImageWithURL:self.recruitmentModel.personInChargeImageUrl];
        return [self calculateHeightForConfiguredSizingCell:cell];
    }
    else {
        QKShopDetailCell *cell = (QKShopDetailCell *)[tableView dequeueReusableCellWithIdentifier:@"CellView2"];
        if (cell == nil) {
            cell = [[QKShopDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellView2"];
        }
        cell.shopDescriptionTextView.text = self.shopInfo.descriptions;
        return [self calculateHeightForConfiguredSizingCell:cell];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"QKCreateNewJobSegue"]) {
        QKCLRecruitmentNewStep1ViewController *recruitmentNewVC = (QKCLRecruitmentNewStep1ViewController *)[segue destinationViewController];
        recruitmentNewVC.recuitmentModel = self.recruitmentModel;
        recruitmentNewVC.recuitmentModel.employmentNum = 0;
        recruitmentNewVC.recuitmentModel.salaryPerUnit = 0;
        recruitmentNewVC.recuitmentModel.startDt = nil;
        recruitmentNewVC.recuitmentModel.endDt = nil;
    }
}

#pragma mark - IBAction

- (IBAction)startJobOfferButtonClick:(id)sender {
    if ([self connected]) {
        NSMutableDictionary *params = [NSMutableDictionary initWithApiKeyAndToken];
        [params setObject:[QKCLAccessUserDefaults getUserId] forKey:@"userId"];
        [params setObject:[QKCLAccessUserDefaults getActiveShopId] forKey:@"shopId"];
        [params setObject:self.recruitmentModel.recruitmentId forKey:@"recruitmentId"];
        [[QKCLRequestManager sharedManager] asyncPOST:[NSString stringFromConst:qkUrlRecruitmentRegistComplete] parameters:params showLoading:YES showError:YES success: ^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"register recruitment complete...");
            if ([[responseObject objectForKey:QK_API_STATUS_CODE] isEqualToString:[NSString stringFromConst:QK_STT_CODE_SUCCESS]]) {
                //set local notification
                [self getLocalNotificationTime];
            }
        } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Register shop error %@", [error localizedDescription]);
        }];
    }
    else {
        [self showNoInternetViewWithSelector:nil];
    }
}

- (void)getLocalNotificationTime {
    NSMutableDictionary *params = [NSMutableDictionary initWithApiKeyAndToken];
    [params setObject:[QKCLAccessUserDefaults getUserId] forKey:@"userId"];
    [params setObject:self.recruitmentModel.recruitmentId forKey:@"recruitmentId"];
    [params setObject:@"0" forKey:@"notRead"];
    
    [[QKCLRequestManager sharedManager] asyncPOST:[NSString stringFromConst:qkUrlRecruitmentDetail] parameters:params showLoading:YES showError:YES success: ^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([[responseObject objectForKey:QK_API_STATUS_CODE] isEqualToString:[NSString stringFromConst:QK_STT_CODE_SUCCESS]]) {
            QKCLRecruitmentModel *model = [[QKCLRecruitmentModel alloc]initWithResponse:responseObject];
            NSDate *date = model.closingDt;
            NSString *stringFromDate = [date longDateString];
            //
            NSString *title = @"募集が開始されました";
            NSString *detail = [NSString stringWithFormat:@"%@%@%@\n\n%@\n%@", @"募集は", stringFromDate, @"に終了されます。", @"※終了後、今回の募集内容を複製し", @"再度募集することができます。"];
            
            
            CCAlertView *alertView = [[CCAlertView alloc] initWithImage:[UIImage imageNamed:@"dialog_pic_done"] title:title message:detail delegate:self buttonTitles:[NSArray arrayWithObjects:@"OK", nil]];
            [alertView showAlert];
            
            
            ///
            NSTimeInterval timeLimit = [responseObject doubleForKey:@"timeLimit"];
            NSDate *localDate = [_recruitmentModel.startDt earlierDateWithTimeInterval:timeLimit];
            
            QKCLNotificationItem *item = [[QKCLNotificationItem alloc]init];
            item.fireDate = localDate;
            item.alertBody = [NSString stringWithFormat:@"A recruitment will active after %ld s", (long)timeLimit];
            [QKCLLocalNotificationManager scheduleNotificationWithItem:item isNeedRepeat:NO];
        }
    } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error %@", error);
    }];
}

- (IBAction)addNewJob:(id)sender {
    [self performSegueWithIdentifier:@"QKCreateNewJobSegue" sender:self];
}

- (IBAction)viewMapButtonClick:(id)sender {
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:NSLocalizedString(@"地図のオープン", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"キャンセル", nil) destructiveButtonTitle:nil otherButtonTitles:NSLocalizedString(@"Apple地図", nil), NSLocalizedString(@"Google地図", nil), nil];
    [sheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    //coordinates for the place we want to display
    CLLocationCoordinate2D rdOfficeLocation = CLLocationCoordinate2DMake(21.030631, 105.784223);
    if (buttonIndex == 0) {
        //Apple Maps, using the MKMapItem class
        MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:rdOfficeLocation addressDictionary:nil];
        MKMapItem *item = [[MKMapItem alloc] initWithPlacemark:placemark];
        item.name = @"ReignDesign Office";
        [item openInMapsWithLaunchOptions:nil];
    }
    else if (buttonIndex == 1) {
        //Google Maps
        //construct a URL using the comgooglemaps schema
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"comgooglemaps://?center=%@", self.recruitmentModel.latLng]];
        if (![[UIApplication sharedApplication] canOpenURL:url]) {
            NSLog(@"Google Maps app is not installed");
            //left as an exercise for the reader: open the Google Maps mobile website instead!
            NSString *url_map = [NSString stringWithFormat:@"http://maps.google.com/maps/@%@,16z", self.recruitmentModel.latLng];
            NSURL *URL = [NSURL URLWithString:url_map];
            [[UIApplication sharedApplication] openURL:URL];
        }
        else {
            [[UIApplication sharedApplication] openURL:url];
        }
    }
}

#pragma mark - CCAlertViewDelegate

- (void)alertView:(CCAlertView *)alertView selectedButtonIndex:(NSInteger)index {
    self.tableView.delegate = nil;
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - Caculate Cell Height

- (CGFloat)calculateHeightForConfiguredSizingCell:(UITableViewCell *)sizingCell {
    sizingCell.bounds = CGRectMake(0.0f, 0.0f, CGRectGetWidth(self.tableView.frame), CGRectGetHeight(sizingCell.bounds));
    
    [sizingCell setNeedsLayout];
    [sizingCell layoutIfNeeded];
    
    CGSize size = [sizingCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return size.height + 1.0f; // Add 1.0f for the cell separator height
}


@end

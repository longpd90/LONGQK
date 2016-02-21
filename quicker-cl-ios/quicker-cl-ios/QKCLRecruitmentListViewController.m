//
//  OfferControlViewController.m
//  quicker-cl-ios
//
//  Created by Nguyen Huu Anh on 4/20/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLRecruitmentListViewController.h"
#import "QKCLRecruitmentModel.h"
#import "QKCLRecruitmentListTableViewCell.h"
#import "QKCLRecruitmentDetailViewController.h"
#import "QKCLDescriptionPaymentMethodViewController.h"
#import "QKCLRecruitmentInformationViewController.h"
#import "QKCLRecruitmentPassListViewController.h"
@interface QKCLRecruitmentListViewController ()
@property (strong, nonatomic) NSMutableArray *recruitmentArrays;
@property (strong, nonatomic) NSMutableArray *recruitmentListPassArrays;
@property (strong, nonatomic) NSIndexPath *selectedInp;
@property (strong, nonatomic) NSTimer *timer;

@end

static NSString *QKRecruitmentListTableViewCellIdentifier = @"QKCLRecruitmentListTableViewCell";

@implementation QKCLRecruitmentListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigationBarWithTitle:[QKCLAccessUserDefaults getActiveShopName] andSubTitle:@"募集管理"];
    
    //register cell
    [self.tableView registerNib:[UINib nibWithNibName:QKRecruitmentListTableViewCellIdentifier bundle:nil] forCellReuseIdentifier:QKRecruitmentListTableViewCellIdentifier];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    
    if (![[QKCLAccessUserDefaults get:@"QKStartApp"] isEqualToString:@"1"]) {
        if (![[QKCLAccessUserDefaults getPaymentSetting] isEqualToString:@"1"]) {
            if ([self checkPaymentSetting]) {
                self.recruitmentState = QKRecruitmentStateNoPayment;
                [self refreshView];
            }
            else {
                [self getRecruitmentList];
            }
        }
        else {
            //[self.tableView setContentOffset:CGPointMake(0, 164) animated:NO];
            [self getRecruitmentList];
        }
        
        [[QKCLAccessUserDefaults get:@"QKStartApp"] isEqualToString:@""];
    }
    else {
        [QKCLAccessUserDefaults put:@"QKStartApp" withValue:@""];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (BOOL)checkPaymentSetting {
    NSMutableDictionary *params = [NSMutableDictionary initWithApiKeyAndToken];
    [params setObject:[QKCLAccessUserDefaults getUserId] forKey:@"userId"];
    [params setObject:[QKCLAccessUserDefaults getActiveShopId] forKey:@"shopId"];
    
    NSDictionary *response;
    NSError *error;
    BOOL result = [[QKCLRequestManager sharedManager] syncGET:[NSString stringFromConst:qkUrlShopDetail] parameters:params response:&response error:&error showLoading:YES showError:YES];
    if (result) {
        //check paymentSystemtypeCd
        if (response[@"paymentSystemType"] == nil || [response[@"paymentSystemType"] isEqualToString:@""]) {
            //No payment
            return YES;
        }
        else {
            [QKCLAccessUserDefaults setPaymentSetting:@"1"];
            return NO;
        }
    }
    return NO;
}

- (void)getRecruitmentList {
    if ([self connected]) {
        NSMutableDictionary *params = [NSMutableDictionary initWithApiKeyAndToken];
        [params setObject:[QKCLAccessUserDefaults getUserId] forKey:@"userId"];
        [params setObject:[QKCLAccessUserDefaults getActiveShopId] forKey:@"shopId"];
        [params setObject:[NSString stringFromConst:QK_READ_FLG_NO] forKey:@"notRead"];
        [[QKCLRequestManager sharedManager] asyncGET:[NSString stringFromConst:qkClUrlRecruitmentList] parameters:params showLoading:YES showError:YES success: ^(AFHTTPRequestOperation *operation, id responseObject) {
            if ([responseObject[QK_API_STATUS_CODE] isEqualToString:[NSString stringFromConst:QK_STT_CODE_SUCCESS]]) {
                NSLog(@"Recruitment successful...");
                _recruitmentArrays = [[NSMutableArray alloc]init];
                for (NSDictionary *jobtypeSList in responseObject[@"recruitmentJobTypeSList"]) {
                    for (NSDictionary *rec in jobtypeSList[@"recruitmentList"]) {
                        QKCLRecruitmentModel *model = [[QKCLRecruitmentModel alloc]initWithResponse:rec];
                        
                        //add to arrays
                        [_recruitmentArrays addObject:model];
                    }
                }
                //Add to pass arrays
                _recruitmentListPassArrays = [[NSMutableArray alloc]init];
                for (NSDictionary *jobtypeSList in responseObject[@"recruitmentJobTypeSList"]) {
                    for (NSDictionary *rec in jobtypeSList[@"recruitmentList"]) {
                        QKCLRecruitmentModel *model = [[QKCLRecruitmentModel alloc]initWithResponse:rec];
                        if (![model.recruitmentStatus isEqual:[NSString stringFromConst:QK_REC_STATUS_DONE_WORKING]]) {
                            [_recruitmentListPassArrays addObject:model];
                            break;
                        }
                    }
                }
                
                if (_recruitmentArrays.count == 0) {
                    self.recruitmentState = QKRecruitmentStateNoRecruitment;
                    [self refreshView];
                }
                else {
                    self.recruitmentState = QKRecruitmentStateHaveRecruitment;
                    [self refreshView];
                }
            }
        } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Get recruitment list fail...");
            [self refreshView];
        }];
    }
    else {
        [self showNoInternetViewWithSelector:@selector(getRecruitmentList)];
    }
}

- (void)refreshView {
    switch (self.recruitmentState) {
        case QKRecruitmentStateNoPayment:
        {
            [self.noPaymentView setHidden:NO];
            [self.tableView setHidden:YES];
            [self.noRecruitmentView setHidden:YES];
            [self.view bringSubviewToFront:self.noPaymentView];
            self.navigationItem.rightBarButtonItem = nil;
            self.navigationItem.leftBarButtonItem = nil;
            //self.navigationController.navigationBarHidden = YES;
            
            break;
        }
            
        case QKRecruitmentStateNoRecruitment:
        {
            [self setRightBarButtonWithButton:@"新規募集" target:@selector(addNewRecruitmentButtonClicked:)];
            [self setMaskLeftBar];
            [self.noPaymentView setHidden:YES];
            [self.tableView setHidden:YES];
            [self.noRecruitmentView setHidden:NO];
            [self.view bringSubviewToFront:self.noRecruitmentView];
            [self.noRecruitmentView setHidden:NO];
            [self.view bringSubviewToFront:self.noRecruitmentView];
            //self.navigationController.navigationBarHidden = NO;
            break;
        }
            
        case QKRecruitmentStateHaveRecruitment:
        {
            //self.navigationController.navigationBarHidden = NO;
            [self.noPaymentView setHidden:YES];
            [self.tableView setHidden:NO];
            [self.noRecruitmentView setHidden:YES];
            [self.view bringSubviewToFront:self.tableView];
            [self.tableView reloadData];
            [self setRightBarButtonWithButton:@"新規募集" target:@selector(addNewRecruitmentButtonClicked:)];
            [self setMaskLeftBar];
            
            
            if (_timer == nil || ![_timer isValid]) {
                // Timer
                _timer = [NSTimer scheduledTimerWithTimeInterval:60.0
                                                          target:self
                                                        selector:@selector(timerFired:)
                                                        userInfo:nil
                                                         repeats:YES];
            }
            break;
        }
            
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */


#pragma TableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _recruitmentArrays.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QKCLRecruitmentListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:QKRecruitmentListTableViewCellIdentifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[QKCLRecruitmentListTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:QKRecruitmentListTableViewCellIdentifier];
    }
    QKCLRecruitmentModel *model = [_recruitmentArrays objectAtIndex:indexPath.row];
    [cell setRecruitment:model];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    QKCLRecruitmentListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:QKRecruitmentListTableViewCellIdentifier];
    if (!cell) {
        cell = [[QKCLRecruitmentListTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:QKRecruitmentListTableViewCellIdentifier];
    }
    QKCLRecruitmentModel *model = [_recruitmentArrays objectAtIndex:indexPath.row];
    [cell setRecruitment:model];
    return [self calculateHeightForConfiguredSizingCell:cell inTableView:tableView];
    //return 218;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.selectedInp = indexPath;
    [self performSegueWithIdentifier:@"QKRecruitmentInformationSegue" sender:self];
}

#pragma mark -IBActions
- (IBAction)noPaymentButtonClicked:(id)sender {
    [self performSegueWithIdentifier:@"QKShowPaymentSettingSegue" sender:self];
}

- (IBAction)addNewRecruitmentButtonClicked:(id)sender {
    if ([_recruitmentListPassArrays count] > 0) {
        [self performSegueWithIdentifier:@"QKRecruitmentPassListSegue" sender:self];
    }
    else {
        [self performSegueWithIdentifier:@"QKNewOfferSegue" sender:self];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"QKShowDetailRecruitment"]) {
        QKCLRecruitmentDetailViewController *recDetailVC = (QKCLRecruitmentDetailViewController *)[segue destinationViewController];
        recDetailVC.recruitmentModel = [self.recruitmentArrays objectAtIndex:self.selectedInp.row];
        recDetailVC.isDetailViewController = YES;
    }
    if ([[segue identifier] isEqualToString:@"QKShowPaymentSettingSegue"]) {
        QKCLDescriptionPaymentMethodViewController *descriptionPaymentSettingViewController = (QKCLDescriptionPaymentMethodViewController *)segue.destinationViewController;
        [descriptionPaymentSettingViewController setMode:QKPaymentSettingModeOther];
    }
    if ([[segue identifier] isEqualToString:@"QKRecruitmentInformationSegue"]) {
        QKCLRecruitmentInformationViewController *recruimentInformationViewController = (QKCLRecruitmentInformationViewController *)segue.destinationViewController;
        QKCLRecruitmentModel *recruitmentModel = [self.recruitmentArrays objectAtIndex:self.selectedInp.row];
        recruimentInformationViewController.recruitmentModel = recruitmentModel;
    }
    if ([[segue identifier] isEqualToString:@"QKRecruitmentPassListSegue"]) {
        QKCLRecruitmentPassListViewController *recruitmentPassList = (QKCLRecruitmentPassListViewController *)segue.destinationViewController;
        
        recruitmentPassList.recruitmentArrays = _recruitmentListPassArrays;
    }
}

- (void)setMaskLeftBar {
    UIButton *leftButton = [[UIButton alloc]initWithFrame:self.navigationItem.rightBarButtonItem.customView.frame];
    [leftButton setUserInteractionEnabled:NO];
    [leftButton setBackgroundColor:[UIColor clearColor]];
    self.navigationItem.leftBarButtonItem  = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
}

#pragma mark -Timer
- (void)timerFired:(id)sender {
    [self.tableView reloadData];
}

@end

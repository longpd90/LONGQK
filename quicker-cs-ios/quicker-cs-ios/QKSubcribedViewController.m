//
//  QKSubcribedViewController.m
//  quicker-cs-ios
//
//  Created by LongPD-PC on 5/7/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKSubcribedViewController.h"
#import "QKSubcriedTableViewCell.h"
#import "QKRecruitmentModel.h"
#import <MapKit/MapKit.h>
#import "QKCSMessageViewController.h"

static CGFloat expandedHeight = 205;
static CGFloat contractedHeight = 80.0;

@interface QKSubcribedViewController ()<UIActionSheetDelegate,QKSubcriedTableViewCellDelegate>{
    NSMutableArray *_days;
    int monthCount;
    NSMutableArray *months;
}
@property (nonatomic) NSInteger totalNum;
@property (strong, nonatomic) QKRecruitmentModel *recruitSelected;
@end

@implementation QKSubcribedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title =NSLocalizedString(@"応募済み", nil);
    _appliedRecruitments = [NSMutableArray new];
    _dayHaveRecruitments = [NSMutableArray new];
    _dictionaryStartDate = [NSMutableDictionary new];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self getListApplieds];
}


- (void) getListApplieds {
    if ([self connected]) {
        NSMutableDictionary *params = [NSMutableDictionary initWithApiKeyAndToken];
        [params setObject:[QKAccessUserDefaults getUserId] forKey:@"userId"];
        [[QKRequestManager sharedManager] asyncGET:[NSString stringFromConst:qkCSUrlRecruitmentAppliedList] parameters:params showLoading:YES showError:YES success: ^(AFHTTPRequestOperation *operation, id responseObject) {
            if ([responseObject[QK_API_STATUS_CODE] isEqualToString:[NSString stringFromConst:QK_STT_CODE_SUCCESS]]) {
                for (NSDictionary *appliedRecruitment in responseObject[@"appliedRecruitmentList"]) {
                    QKRecruitmentModel *appliedEntity = [[QKRecruitmentModel alloc] initWithResponse:appliedRecruitment];
                    [_appliedRecruitments addObject:appliedEntity];
                }
                [self quickSortRecruitmentsByDate];
                [self getRecruitmentsSameDay];

                _totalNum = [responseObject intForKey:@"totalNum"];

                [self refreshView];
            }
            
        } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
            
        }];
    }
    else {
        [self showNoInternetViewWithSelector:@selector(getListApplieds)];
        
    }
}

- (void)refreshView {
    if (_appliedRecruitments.count > 0) {
        UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.subcribedTableView.frame), 1.0f)];
        headerView.backgroundColor =[UIColor colorWithHexString:@"#F5FAFA"];
        [self.subcribedTableView setTableHeaderView:headerView];
        
    } else {
        [self.subcribedTableView setTableHeaderView:self.headerTableView];
    }
    [self.subcribedTableView reloadData];
}

#pragma mark - algorithm

- (void)quickSortRecruitmentsByDate {
    NSSortDescriptor *dateDescriptor = [NSSortDescriptor
                                        sortDescriptorWithKey:@"startDate"
                                        ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObject:dateDescriptor];
    NSArray *sortedEventArray = [_appliedRecruitments
                                 sortedArrayUsingDescriptors:sortDescriptors];
    _appliedRecruitments = [NSMutableArray arrayWithArray:sortedEventArray];
}

- (void)getRecruitmentsSameDay {
    for (int i = 0; i < _appliedRecruitments.count; i ++) {
        QKRecruitmentModel *recruitMentEntity = [_appliedRecruitments objectAtIndex:i];
        NSMutableArray *dates = [_dictionaryStartDate objectForKey:[recruitMentEntity.startDate stringValueFormattedBy:@"yyyy-MM-dd"]];
        if (dates) {
            [dates addObject:recruitMentEntity];
        } else {
            NSMutableArray *date = [NSMutableArray new];
            [date addObject:recruitMentEntity];
            [_dictionaryStartDate setObject:date forKey:[recruitMentEntity.startDate stringValueFormattedBy:@"yyyy-MM-dd"]];
            [_dayHaveRecruitments addObject:[recruitMentEntity.startDate stringValueFormattedBy:@"yyyy-MM-dd"]];
        }
    }
}

- (NSString *)convertFormatDate:(NSString *)dateBefore {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [dateFormatter dateFromString:dateBefore];
    NSString *dateAffter = [date stringValueFormattedBy:@"MM月dd日"];
    return dateAffter;
}
# pragma mark - Tableview delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _dayHaveRecruitments.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *day = [_dictionaryStartDate objectForKey:[_dayHaveRecruitments objectAtIndex:section]];
    return day.count;
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0,tableView.frame.size.width, 22)];
    [view setBackgroundColor:[UIColor colorWithRed:247.0/255.0 green:247.0/255.0 blue:247.0/255.0 alpha:1.0]];
    QKF42Label *titleLable = [[QKF42Label alloc]initWithFrame:CGRectMake(10, 0, tableView.frame.size.width, 22)];
    [titleLable setText:[self convertFormatDate:[_dayHaveRecruitments objectAtIndex:section]]];
    [view addSubview:titleLable];
    
    return view;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 22;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    QKRecruitmentModel *recruitmentEntity = [_appliedRecruitments objectAtIndex:indexPath.row];
    if ([recruitmentEntity.workStatus isEqualToString:@"00"] ||
        [recruitmentEntity.workStatus isEqualToString:@"10"]) {
        return expandedHeight;
    } else {
        return contractedHeight;
    }
    return contractedHeight; // Normal height
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"QKSubcriedTableViewCell";
    QKSubcriedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    cell.delegate = self;
    [cell setRecruitmentAppiled:[_appliedRecruitments objectAtIndex:indexPath.row]];
    return cell;
}


#pragma mark - sucried cell delegate

- (void)gotoMapWithRecruitment:(QKRecruitmentModel *)recruitment {
    if (!_recruitSelected) {
        _recruitSelected = [QKRecruitmentModel new];
    }
    _recruitSelected = recruitment;
    [self gotoMap];
}

- (void)gotoCallWithRecruitment:(QKRecruitmentModel *)recruitment {
    if (!_recruitSelected) {
        _recruitSelected = [QKRecruitmentModel new];
    }
    _recruitSelected = recruitment;
    [self callCenter];
}

- (void)gotoMessengerWithRecruitment:(QKRecruitmentModel *)recruitment {
    if (!_recruitSelected) {
        _recruitSelected = [QKRecruitmentModel new];
    }
    _recruitSelected = recruitment;
    self.hidesBottomBarWhenPushed = YES;
    [self performSegueWithIdentifier:@"ShowMessageFromSucriedSegue" sender:self];
    self.hidesBottomBarWhenPushed = NO;
}
#pragma mark - action

- (IBAction)findJobButtonClicked:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    UINavigationController *mainMenuNavigationViewController = [storyboard instantiateViewControllerWithIdentifier:@"QKNavigationMainMenuViewController"];
    [[UIApplication sharedApplication] keyWindow].rootViewController = mainMenuNavigationViewController;
    [[[UIApplication sharedApplication] keyWindow] makeKeyAndVisible];
}

- (void)gotoMap{
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
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"comgooglemaps://?center=%@", self.recruitSelected.latLng]];
        if (![[UIApplication sharedApplication] canOpenURL:url]) {
            NSLog(@"Google Maps app is not installed");
            //left as an exercise for the reader: open the Google Maps mobile website instead!
            NSString *url_map = [NSString stringWithFormat:@"http://maps.google.com/maps/@%@,16z", self.recruitSelected.latLng];
            NSURL *URL = [NSURL URLWithString:url_map];
            [[UIApplication sharedApplication] openURL:URL];
        }
        else {
            [[UIApplication sharedApplication] openURL:url];
        }
    }
}

- (IBAction)gotoJobhistory:(id)sender {
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ShowMessageFromSucriedSegue"]) {
        QKCSMessageViewController *messageViewController = (QKCSMessageViewController *)segue.destinationViewController;
        messageViewController.recruimentId = _recruitSelected.recruitmentId;
    }
}
@end

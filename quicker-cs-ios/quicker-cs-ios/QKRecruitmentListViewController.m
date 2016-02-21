//
//  QKRecruitmentListViewController.m
//  quicker-cs-ios
//
//  Created by LongPD-PC on 5/7/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKRecruitmentListViewController.h"
#import "QKJobTableViewCell.h"
#import "QKRecruitmentDetailViewController.h"
#import "QKTipSearchJobView.h"
#import "QKCSLoadingView.h"
#import "QKLoadMoreTableViewCelll.h"
#import "QKRecruitmentPerDay.h"

@interface QKRecruitmentListViewController ()<UIScrollViewDelegate>

@property (strong, nonatomic) QKRecruitmentModel *selectedRecruitment;

//param
@property (nonatomic) NSInteger totalNum;
@property (strong, nonatomic) NSString *autoroadCd;
@property (strong, nonatomic) NSMutableArray *recruitmentPerDays;
@property (nonatomic) BOOL isLoad;
@property (strong,nonatomic) QKCSLoadingView *pullToRefreshView;
@end
static NSString *jobTableViewCell = @"QKJobTableViewCell";

@implementation QKRecruitmentListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.jobsTableView registerNib:[UINib nibWithNibName:jobTableViewCell bundle:nil] forCellReuseIdentifier:jobTableViewCell];
    
    [NSTimer scheduledTimerWithTimeInterval:60 target:self selector:@selector(refreshCountDownView) userInfo:nil repeats:YES];
    
    UISwipeGestureRecognizer *leftSwipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeLeftGestureHandler)];
    leftSwipeGesture.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:leftSwipeGesture];
    
    UISwipeGestureRecognizer *rightSwipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRightGestureHandler)];
    rightSwipeGesture.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:rightSwipeGesture];
    
    
    //show tip
    if (![[QKAccessUserDefaults get:kQKNeedShowTipListJobKey] isEqualToString:@"1"]) {
        [QKAccessUserDefaults put:kQKNeedShowTipListJobKey withValue:@"1"];
        QKTipSearchJobView *tipSearchView = [UIView loadFromNibNamed:@"QKTipSearchJobView"];
        [tipSearchView show];
    }
    [self showLoginSuccess];
    
    //set delegate
    _calendarView.delegate = self;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    _dateString = [dateFormatter stringFromDate:[NSDate date]];
    
    //filter
    [self updateFilter];
    
    //init arrays
    _recruitmentList = [[NSMutableArray alloc]init];
    _recruitmentPerDays = [NSMutableArray new];
    
    CGFloat customRefreshControlHeight = 50.0f;
    CGFloat customRefreshControlWidth = CGRectGetWidth(self.jobsTableView.frame);
    _pullToRefreshView = [[QKCSLoadingView alloc]initWithFrame:CGRectMake(0.0, -customRefreshControlHeight, customRefreshControlWidth, customRefreshControlHeight)];
    [_pullToRefreshView addTarget:self action:@selector(reloadView:) forControlEvents:UIControlEventValueChanged];
    [self.jobsTableView addSubview:_pullToRefreshView];
    
}
-(void)updateFilter {
    //filter
    NSMutableDictionary *dic = [[QKAccessUserDefaults getRecruitmentFilter] mutableCopy];
    if (dic == nil) {
        [self createBarButtonFilter:NO];
    }else{
        _filter = nil;
        _filter = [[QKRecruitmentFilterModel alloc]initWithResponse:dic];
        [self createBarButtonFilter:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (![[QKAccessUserDefaults get:@"StartApp" ] isEqualToString:@"1"]) {
        if (!_isLoad) {
            _isLoad =YES;
            //call API to get data
            
            [self getJobList];
        }
    }else{
        [QKAccessUserDefaults put:@"StartApp" withValue:@""];
    }
    
}

- (void)swipeLeftGestureHandler {
    [self.calendarView swipeOneDayToLeft];
}

- (void)swipeRightGestureHandler {
    [self.calendarView swipeOneDayToRight];
}

- (void)refreshCountDownView {
    if (_recruitmentList.count == 0) {
        return;
    }
    [self.jobsTableView reloadData];
}
#pragma mark - show alert view

- (void)showLoginSuccess {
    if ([[CCAccessUserDefaults get:kQKNeedShowLoginAlertKey] isEqualToString:kQKNeedShowLoginAlert]) {
        [CCAccessUserDefaults put:kQKNeedShowLoginAlertKey withValue:@""];
        CCAlertView *loginSuccess = [[CCAlertView alloc] initWithImage:[UIImage imageNamed:@"dialog_pic_done"] title:@"ログインしました" andMessage:nil style:QKAlertViewStyleWhite];
        [loginSuccess showAlert];
    }
}

# pragma mark - public

- (void)loadMoreDatas {
    if (self.totalNum > [_recruitmentList count]) {
        [self getJobList];
    }
}

- (void)getJobList {
    NSMutableDictionary *params = [NSMutableDictionary initWithApiKeyAndToken];
    [params setObject:[QKAccessUserDefaults getUserId] forKey:@"userId"];
    [_recruitmentPerDays removeAllObjects];
    if (_filter.sortCd != nil) {
        [params setObject:_filter.sortCd forKey:@"sortCd"];
    }
    //    [params setObject:@"00" forKey:@"jobTypeLCd"];
    //    [params setObject:@"113" forKey:@"workAreaCd"];
    [params setObject:_dateString forKey:@"targetDt"];
    if (_filter.startDt != nil) {
        [params setObject:_filter.startDt forKey:@"startDt"];
    }
    if (_filter.endDt != nil) {
        [params setObject:_filter.endDt forKey:@"endDt"];
    }
    [params setObject:QK_CS_REC_LIST_LIMIT forKey:@"limit"];
    if (_autoroadCd != nil) {
        [params setObject:_autoroadCd forKey:@"autoroadCd"];
    }
    
    if (_filter.preferenceCdArrays.count > 0) {
        NSMutableSet *set = [[NSMutableSet alloc]init];
        [set addObjectsFromArray:_filter.preferenceCdArrays];
        [params setObject:set forKey:@"preferenceCd"];
    }
    
    [[QKRequestManager sharedManager] asyncGET:[NSString stringFromConst:qkCSUrlRecruitmentList] parameters:params showLoading:YES showError:YES success: ^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([responseObject[QK_API_STATUS_CODE] isEqualToString:[NSString stringFromConst:QK_STT_CODE_SUCCESS]]) {
            for (NSDictionary *jobInfoDic in[responseObject objectForKey:@"recruitmentList"]) {
                QKRecruitmentModel *jobModel = [[QKRecruitmentModel alloc] initWithResponse:jobInfoDic];
                [_recruitmentList addObject:jobModel];
            }
            
            for (NSDictionary *jobInfoDic in[responseObject objectForKey:@"recruitmentCountPerDayList"]) {
                QKRecruitmentPerDay *recruitmentPerDay = [[QKRecruitmentPerDay alloc] initWithResponse:jobInfoDic];
                [_recruitmentPerDays addObject:recruitmentPerDay];
                [self.calendarView setRecruitmentPerDays:_recruitmentPerDays];
            }
            
            _autoroadCd = [responseObject stringForKey:@"autoroadCd"];
            _totalNum = [responseObject intForKey:@"totalNum"];
            [self refreshView];
        }else{
            [_pullToRefreshView endRefreshing];
        }
        
    } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [_pullToRefreshView endRefreshing];
    }];
}

- (void)getAllRecruitmentListWithoutFilter {
    [_recruitmentList removeAllObjects];
    NSMutableDictionary *params = [NSMutableDictionary initWithApiKeyAndToken];
    [params setObject:[QKAccessUserDefaults getUserId] forKey:@"userId"];
    
    [params setObject:_dateString forKey:@"targetDt"];
    [params setObject:QK_CS_REC_LIST_LIMIT forKey:@"limit"];
    [params setObject:_autoroadCd forKey:@"autoroadCd"];
    
    NSDictionary*response;
    NSError*error;
    BOOL result = [[QKRequestManager sharedManager] syncGET:[NSString stringFromConst:qkCSUrlRecruitmentList] parameters:params response:&response error:&error showLoading:YES showError:YES];
    if (result) {
        for (NSDictionary *jobInfoDic in[response objectForKey:@"recruitmentList"]) {
            QKRecruitmentModel *jobModel = [[QKRecruitmentModel alloc] initWithResponse:jobInfoDic];
            [_recruitmentList addObject:jobModel];
        }
        _autoroadCd = [response stringForKey:@"autoroadCd"];
        _totalNum = [response intForKey:@"totalNum"];
    }
    
}

- (void)refreshView {
    if (_recruitmentList.count > 0) {
        UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.jobsTableView.frame), 1.0f)];
        headerView.backgroundColor =[UIColor colorWithHexString:@"#F5FAFA"];
        [self.jobsTableView setTableHeaderView:headerView];
        
    } else {
        [self.jobsTableView setTableHeaderView:self.tableHeaderView];
        [self getAllRecruitmentListWithoutFilter];
        
    }
    [self.jobsTableView reloadData];
    [self.jobsTableView setContentOffset:CGPointMake(0,0)];
    [_pullToRefreshView endRefreshing];
}

- (void)changeCondition:(id)sender {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeFilter) name:@"QKChangeRecruitmentFilter" object:nil];
    [self performSegueWithIdentifier:@"QKShowJobFilterSegue" sender:self];
}

- (void)createBarButtonFilter:(BOOL)flag {
    if (flag == YES) {
        [self setRightBarButtonWithImage:[UIImage imageNamed:@"nav_btn_search_active"] target:@selector(changeCondition:)];
    }else{
        
        [self setRightBarButtonWithImage:[UIImage imageNamed:@"nav_btn_search_inactive"] target:@selector(changeCondition:)];
    }
}

-(void)changeFilter {
    _autoroadCd = @"";
    [self updateFilter];
    [_recruitmentList removeAllObjects];
    [self getJobList];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"QKChangeRecruitmentFilter" object:nil];
}

# pragma mark - Tableview delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([_recruitmentList count] < self.totalNum) {
        return [_recruitmentList count] + 1;
    }
    else {
        return [_recruitmentList count];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row < self.recruitmentList.count) {
        return 344;
    } else {
        return 80;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([tableView numberOfRowsInSection:0] == self.recruitmentList.count || indexPath.row < self.recruitmentList.count) {
        QKJobTableViewCell *cell = (QKJobTableViewCell *)[tableView dequeueReusableCellWithIdentifier:jobTableViewCell forIndexPath:indexPath];
        if (!cell) {
            cell = [[QKJobTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:jobTableViewCell];
        }
        QKRecruitmentModel *model = [_recruitmentList objectAtIndex:indexPath.row];
        [cell setRecruitmentEntity:model];
        return cell;
    } else {
        QKLoadMoreTableViewCelll *cell = (QKLoadMoreTableViewCelll *)[tableView dequeueReusableCellWithIdentifier:@"QKLoadMoreTableViewCelll"];
        
        NSMutableArray *loadmoreimages = [[NSMutableArray alloc] init];
        for (int i = 1; i < 33; i++) {
            NSString *imageName = [NSString stringWithFormat:@"common_loader_small_000%d", i];
            if (i > 9) {
                imageName = [NSString stringWithFormat:@"common_loader_small_00%d", i];
            }
            [loadmoreimages addObject:[UIImage imageNamed:imageName]];
        }
        cell.backgroundColor=[UIColor clearColor];
        cell.indicatorImageView.animationImages = loadmoreimages;
        cell.indicatorImageView.animationDuration = 1;
        [cell.indicatorImageView startAnimating];
        return cell;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    _selectedRecruitment = [_recruitmentList objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"QKShowRecruitmentDetailSegue" sender:self];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger lastRowIndex = [tableView numberOfRowsInSection:0];
    if (indexPath.row == lastRowIndex - 1) {
        [self loadMoreDatas];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 20.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView*footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(tableView.frame), 20.0f)];
    footerView.backgroundColor =[UIColor colorWithHexString:@"#F5FAFA"];
    return footerView;
}

#pragma mark - QKCalendarHorizontalViewDelegate
- (void)changeDate:(NSDate *)date bySwipe:(BOOL)isSwipe {
    _dateString = [self getDateString:date];
    _dateLabel.text = [self getStringForLabel:date];
    _autoroadCd = @"";
    [_recruitmentList removeAllObjects];
    [self getJobList];
}

- (NSString *)getDateString:(NSDate *)date {
    //get date
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    return [dateFormatter stringFromDate:date];
}

- (NSString *)getStringForLabel:(NSDate *)date {
    //get date
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"MM月dd日には"];
    return [dateFormatter stringFromDate:date];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"QKShowRecruitmentDetailSegue"]) {
        QKRecruitmentDetailViewController *detailViewController = (QKRecruitmentDetailViewController *)segue.destinationViewController;
        detailViewController.recruitment = _selectedRecruitment;
    }
}

#pragma mark - ScrollDelegate(VietND)
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [_pullToRefreshView containingScrollViewDidEndDragging:scrollView];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGRect frame  =_pullToRefreshView.frame;
    frame.size.height =scrollView.contentOffset.y;
    [_pullToRefreshView setFrame:frame];
    //[_pullToRefreshView layoutSubviews];
    [_pullToRefreshView layoutIfNeeded];
    
}
-(void)reloadView:(id)sender {
    if ([_pullToRefreshView isRefreshing]) {
        _autoroadCd = @"";
        [_recruitmentList removeAllObjects];
        [self getJobList];
    }
}
@end

//
//  NoticeViewController.m
//  quicker-cl-ios
//
//  Created by Nguyen Huu Anh on 4/20/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLNoticeViewController.h"
#import "QKNoticeTableViewCell.h"
#import "QKCLShopShowInfoViewController.h"
#import "QKCLNoticeModel.h"
#import "QKImageView.h"
#import "QKCLMessageViewController.h"
#import "QKCLDescriptionPaymentMethodViewController.h"

@interface QKCLNoticeViewController ()
@property (weak, nonatomic) IBOutlet UIView *noNoticeView;
@property (strong, nonatomic) NSMutableArray *noticeList;
@property (strong, nonatomic) UIRefreshControl *refreshControl;
@property (nonatomic) NSInteger totalNum;
@property (nonatomic, strong) NSString *autoroadCd;
@property (nonatomic, strong) NSMutableArray *imageArray;
@property (nonatomic) NSInteger selectedIndex;
@property (strong, nonatomic) NSDateFormatter *dateFormatter;

@end

@implementation QKCLNoticeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBarWithTitle:[QKCLAccessUserDefaults getActiveShopName] andSubTitle:@"通知"];
    
    [self initRefreshControl];
    
    //load more animation
    [self createAnimationImage];
    
    _dateFormatter = [[NSDateFormatter alloc] init];
    [_dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    _autoroadCd = @"";
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //Constructor
    _noticeList = [[NSMutableArray alloc]init];
    [self getNoticeList];
}

- (void)createAnimationImage {
    _imageArray = [[NSMutableArray alloc] init];
    for (int i = 1; i < 33; i++) {
        NSString *imageName = [NSString stringWithFormat:@"common_loader_small_000%d", i];
        if (i > 9) {
            imageName = [NSString stringWithFormat:@"common_loader_small_00%d", i];
        }
        [_imageArray addObject:[UIImage imageNamed:imageName]];
    }
}

- (void)initRefreshControl {
    _refreshControl = [[UIRefreshControl alloc]init];
    
    [_refreshControl addTarget:self action:@selector(refreshTable) forControlEvents:UIControlEventValueChanged];
    [self.thisTableView addSubview:_refreshControl];
}

- (void)getNoticeList {
    if ([self connected]) {
        //Loading data
        NSMutableDictionary *params = [NSMutableDictionary initWithApiKeyAndToken];
        [params setObject:[QKCLAccessUserDefaults getUserId] forKey:@"userId"];
        [params setObject:[QKCLAccessUserDefaults getActiveShopId] forKey:@"shopId"];
        [params setObject:QK_CL_NOTICE_LIMIT forKey:@"limit"];
        [params setObject:_autoroadCd forKey:@"autoroadCd"];
        
        [[QKCLRequestManager sharedManager] asyncGET:[NSString stringFromConst:qkUrlNotice] parameters:params showLoading:YES showError:YES success: ^(AFHTTPRequestOperation *operation, id responseObject) {
            if ([responseObject[QK_API_STATUS_CODE] isEqualToString:[NSString stringFromConst:QK_STT_CODE_SUCCESS]]) {
                for (NSDictionary *res in responseObject[@"noticeList"]) {
                    QKCLNoticeModel *model = [[QKCLNoticeModel alloc]initWithResponse:res];
                    
                    [_noticeList addObject:model];
                }
                self.totalNum = [responseObject intForKey:@"totalNum"];
                self.autoroadCd = [responseObject stringForKey:@"autoroadCd"];
                
                [self refreshView];
            }
        } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
            [self refreshView];
        }];
    }
    else {
        [self showNoInternetViewWithSelector:@selector(getNoticeList)];
    }
}

- (void)refreshView {
    if ([_noticeList count] == 0) {
        self.noNoticeView.hidden = NO;
        self.thisTableView.hidden = YES;
        [self.view bringSubviewToFront:self.noNoticeView];
    }
    else {
        self.noNoticeView.hidden = YES;
        self.thisTableView.hidden = NO;
        [self.view bringSubviewToFront:self.thisTableView];
        [_thisTableView reloadData];
    }
}

#pragma mark action UIRefreshControl
- (void)refreshTable {
    [_refreshControl endRefreshing];
    [self.thisTableView reloadData];
}

- (void)loadMoreDatas {
    if (self.totalNum > [_noticeList count]) {
        [self getNoticeList];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDatasouce

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([_noticeList count] < self.totalNum) {
        return [self.noticeList count] + 1;
    }
    else {
        return [_noticeList count];
    }
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger lastRowIndex = [tableView numberOfRowsInSection:0];
    
    if (indexPath.row == lastRowIndex - 1) {
        [self loadMoreDatas];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([tableView numberOfRowsInSection:0] == self.noticeList.count || indexPath.row < self.noticeList.count) {
        QKNoticeTableViewCell *cell = (QKNoticeTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"QKNoticeTableViewCell"];
        QKCLNoticeModel *model = [_noticeList objectAtIndex:indexPath.row];
        cell.titleLabel.text = model.noticeDetail;
        cell.timeLabel.text = [_dateFormatter stringFromDate:model.noticeDt];
        
        [cell.statusIconView setBackgroundColor:[UIColor redColor]];
        if ([QK_READ_FLG_DONE isEqualToString:model.readF]) {
            [cell.statusIconView setHidden:YES];
        }
        
        return cell;
    }
    
    else {
        QKNoticeTableViewCell *cell = (QKNoticeTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"QKLoadMoreCell"];
        cell.indicatorImageView.animationImages = _imageArray;
        cell.indicatorImageView.animationDuration = 1;
        [cell.indicatorImageView startAnimating];
        return cell;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    _selectedIndex = indexPath.row;
    QKNoticeTableViewCell *selectedCell = (QKNoticeTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    [selectedCell.statusIconView setHidden:YES];
    
    QKCLNoticeModel *model = [_noticeList objectAtIndex:indexPath.row];
    
    if ([model.noticeId isEqualToString:[NSString stringFromConst:QK_CL_NOTICE_ID_0006]]) {
        //nothing
    }
    if ([model.noticeId isEqualToString:[NSString stringFromConst:QK_CL_NOTICE_ID_0007]]) {
        //D-8-1
        //[self performSegueWithIdentifier:@"QKActionToShopInfoSegue" sender:self];
    }
    if ([model.noticeId isEqualToString:[NSString stringFromConst:QK_CL_NOTICE_ID_0009]]) {
        //J-1-1
    }
    if ([model.noticeId isEqualToString:[NSString stringFromConst:QK_CL_NOTICE_ID_0012]]) {
        //H-7
    }
    if ([model.noticeId isEqualToString:[NSString stringFromConst:QK_CL_NOTICE_ID_0021]]) {
        //H-2-3
    }
    if ([model.noticeId isEqualToString:[NSString stringFromConst:QK_CL_NOTICE_ID_0024]]) {
        //H-2-3
    }
    if ([model.noticeId isEqualToString:[NSString stringFromConst:QK_CL_NOTICE_ID_0028]]) {
        //O-1-1
        self.hidesBottomBarWhenPushed = YES;
        [self performSegueWithIdentifier:@"QKActionToMessageSegue" sender:self];
        self.hidesBottomBarWhenPushed = NO;
    }
    if ([model.noticeId isEqualToString:[NSString stringFromConst:QK_CL_NOTICE_ID_0033]]) {
        //I-1-1
    }
    if ([model.noticeId isEqualToString:[NSString stringFromConst:QK_CL_NOTICE_ID_0038]]) {
        //I-1-1
    }
    if ([model.noticeId isEqualToString:[NSString stringFromConst:QK_CL_NOTICE_ID_0040]]) {
        //K-1-4
    }
    if ([model.noticeId isEqualToString:[NSString stringFromConst:QK_CL_NOTICE_ID_0062]]) {
        //M-18
        [self performSegueWithIdentifier:@"QKActionToPayMentSegue" sender:self];
    }
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    QKCLNoticeModel *model = [_noticeList objectAtIndex:_selectedIndex];
    if ([segue.identifier isEqualToString:@"QKActionToMessageSegue"]) {
        QKCLMessageViewController *messageViewController = (QKCLMessageViewController *)segue.destinationViewController;
        [messageViewController setCustomerUserId:model.fromUserId];
        [messageViewController setRecruimentId:model.recruitmentId];
    }
    if ([segue.identifier isEqualToString:@"QKActionToPayMentSegue"]) {
        QKCLDescriptionPaymentMethodViewController *descriptionPaymentViewController = (QKCLDescriptionPaymentMethodViewController *)segue.destinationViewController;
        [descriptionPaymentViewController setShopId:model.shopId];
    }
}

@end

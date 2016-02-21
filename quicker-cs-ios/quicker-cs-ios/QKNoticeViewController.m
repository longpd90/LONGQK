//
//  QKNotificationViewController.m
//  quicker-cs-ios
//
//  Created by LongPD-PC on 5/7/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKNoticeViewController.h"
#import "QKNoticeTableViewCell.h"
#import "QKCSNoticeModel.h"
#import "QKCSMessageViewController.h"

@interface QKNoticeViewController ()
@property (strong, nonatomic) NSMutableArray *noticeList;
@property (strong, nonatomic) UIRefreshControl *refreshControl;
@property (nonatomic) NSInteger totalNum;

@property(nonatomic,strong) NSMutableArray *imageArray;
@property (weak, nonatomic) IBOutlet UIView *noNoticeView;
@property (nonatomic) NSInteger selectedIndex;

@end

@implementation QKNoticeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _imageArray = [[NSMutableArray alloc] init];
    [self createAnimationImage];
    
    _noticeList = [[NSMutableArray alloc]init];
    
    [self initRefreshControl];
    self.navigationItem.title = NSLocalizedString(@"通知", nil);
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [_noticeList removeAllObjects];
    [self getNoticeList];
}
- (void)createAnimationImage {
    
    for (int i = 1; i < 33; i++ ) {
        NSString *imageName = [NSString stringWithFormat:@"common_loader_small_000%d",i];
        if (i > 9 ) {
            imageName = [NSString stringWithFormat:@"common_loader_small_00%d",i];
        }
        [_imageArray addObject:[UIImage imageNamed:imageName]];
    }
    
}
- (void)initRefreshControl {
    
    _refreshControl = [[UIRefreshControl alloc]init];
    
    [_refreshControl addTarget:self action:@selector(refreshTable) forControlEvents:UIControlEventValueChanged];
    [self.thisTableView addSubview:_refreshControl];
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

- (void)getNoticeList {
    if ([self connected]) {
        //Loading data
        NSMutableDictionary *params= [NSMutableDictionary initWithApiKeyAndToken];
        [params setObject:[QKAccessUserDefaults getUserId] forKey:@"userId"];
        [[QKRequestManager sharedManager] asyncGET:[NSString stringFromConst:qkCSUrlNoticeList] parameters:params showLoading:YES showError:YES success: ^(AFHTTPRequestOperation *operation, id responseObject) {
            if ([responseObject[QK_API_STATUS_CODE]
                 isEqualToString:[NSString
                                  stringFromConst:QK_STT_CODE_SUCCESS]]) {
                     for (NSDictionary *res in responseObject[@"noticeList"]) {
                         QKCSNoticeModel *model = [[QKCSNoticeModel alloc]initWithResponse:res];
                         
                         [_noticeList addObject:model];
                     }
                     self.totalNum = [responseObject intForKey:@"totalNum"];
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
    if (_noticeList.count>0) {
        self.noNoticeView.hidden = YES;
        self.thisTableView.hidden = NO;
        [self.view bringSubviewToFront:self.thisTableView];
        
        [_thisTableView reloadData];
    }else{
        self.noNoticeView.hidden = NO;
        self.thisTableView.hidden = YES;
        [self.view bringSubviewToFront:self.noNoticeView];
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

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90.0f;
}
- (CGFloat)tableView:(UITableView *)tableView
heightForHeaderInSection:(NSInteger)section {
    return 0.001f;
}

#pragma mark - UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([tableView numberOfRowsInSection:0] == self.noticeList.count) {
        QKNoticeTableViewCell *cell = (QKNoticeTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"QKNoticeTableViewCell"];
        
        QKCSNoticeModel *model = [_noticeList objectAtIndex:indexPath.row];
        [cell setNoticeEntity:model];
        return cell;
    }
    else if (indexPath.row < self.noticeList.count) {
        QKNoticeTableViewCell *cell = (QKNoticeTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"QKNoticeTableViewCell"];
        QKCSNoticeModel *model = [_noticeList objectAtIndex:indexPath.row];
        [cell setNoticeEntity:model];
        return cell;
    }
    else {
        QKNoticeTableViewCell *cell = (QKNoticeTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"QKLoadMoreCell"];
        cell.loadMoreImageView.animationImages = _imageArray;
        cell.loadMoreImageView.animationDuration = 1;
        [cell.loadMoreImageView startAnimating];
        return cell;
    }
    return nil;
    
    
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger lastRowIndex = [tableView numberOfRowsInSection:0];
    
    if (indexPath.row == lastRowIndex - 1 ) {
        [self loadMoreDatas];
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    _selectedIndex = indexPath.row;
    QKNoticeTableViewCell *selectedCell = (QKNoticeTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    [selectedCell.statusIconView setHidden:YES];
    
    QKCSNoticeModel *model = [_noticeList objectAtIndex:indexPath.row];
    if ([model.noticeType isEqualToString:[NSString stringFromConst:QK_NOTICE_TYPE_MESSAGE]]) {
        self.hidesBottomBarWhenPushed = YES;
        [self performSegueWithIdentifier:@"QKActionToMessageSegue" sender:self];
        self.hidesBottomBarWhenPushed = NO;
        
    }
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    QKCSNoticeModel *model = [_noticeList objectAtIndex:_selectedIndex];
    if ([segue.identifier isEqualToString:@"QKActionToMessageSegue"]) {
        QKCSMessageViewController *messageViewController = (QKCSMessageViewController *)segue.destinationViewController;
        [messageViewController setRecruimentId:model.recruitmentId];
        
        
        
    }
}



@end

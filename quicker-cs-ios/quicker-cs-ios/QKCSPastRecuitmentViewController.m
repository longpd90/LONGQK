//
//  QKCSPastRecuitmentViewController.m
//  quicker-cs-ios
//
//  Created by C Anh on 8/19/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCSPastRecuitmentViewController.h"
#import "QKCSScrollImageViewCell.h"
#import "QKCSDetailWorkHistoryCell.h"
#import "QKCSRecruitmentNoTimeCell.h"
#import "QKCSRecruitmentLocationCell.h"
#import "QKCSRecuitmentTimeCell.h"
#import "QKCSRecruitmentDecriptionCell.h"
#import "QKCSImageViewCell.h"
#import "QKMasterPreferenceConditionModel.h"

static NSString *detailWorkHistoryCell = @"QKCSDetailWorkHistoryCell";
static NSString *recruitmentNotimeCell = @"QKCSRecruitmentNoTimeCell";
static NSString *scollImageCell = @"QKCSScrollImageViewCell";
static NSString *locationCell = @"QKCSRecruitmentLocationCell";
static NSString *recruitmentTimeCell = @"QKCSRecuitmentTimeCell";
static NSString *decriptionCell = @"QKCSRecruitmentDecriptionCell";
static NSString *imageViewCell = @"QKCSImageViewCell";

@interface QKCSPastRecuitmentViewController ()
@property (strong, nonatomic) NSMutableArray *recruitmentList;
@property (strong, nonatomic) NSMutableArray *recruitmentListExist;


@end

@implementation QKCSPastRecuitmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setAngleLeftBarButton];
    [self.tableView registerNib:[UINib nibWithNibName:scollImageCell bundle:nil] forCellReuseIdentifier:scollImageCell];
    [self.tableView registerNib:[UINib nibWithNibName:detailWorkHistoryCell bundle:nil] forCellReuseIdentifier:detailWorkHistoryCell];
    [self.tableView registerNib:[UINib nibWithNibName:recruitmentNotimeCell bundle:nil] forCellReuseIdentifier:recruitmentNotimeCell];
    [self.tableView registerNib:[UINib nibWithNibName:locationCell bundle:nil] forCellReuseIdentifier:locationCell];
    [self.tableView registerNib:[UINib nibWithNibName:recruitmentTimeCell bundle:nil] forCellReuseIdentifier:recruitmentTimeCell];
    [self.tableView registerNib:[UINib nibWithNibName:decriptionCell bundle:nil] forCellReuseIdentifier:decriptionCell];
    [self.tableView registerNib:[UINib nibWithNibName:imageViewCell bundle:nil] forCellReuseIdentifier:imageViewCell];
    _recruitmentList = [[NSMutableArray alloc] init];
    _recruitmentListExist = [[NSMutableArray alloc] init];
    [NSTimer scheduledTimerWithTimeInterval:59
                                     target:self selector:@selector(refreshTableView)
                                   userInfo:nil repeats:YES];

}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self loadShopInfo];
}
- (void) refreshTableView {
    [self.tableView reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)loadShopInfo {
    if ([self connected]) {
        NSMutableDictionary *params = [NSMutableDictionary initWithApiKeyAndToken];
        [params setObject:[QKAccessUserDefaults getUserId] forKey:@"userId"];
        [params setObject:_recruitmentModel.shopInfo.shopId forKey:@"shopId"];
        
        [[QKRequestManager sharedManager] asyncGET:[NSString stringFromConst:qkCSUrlShopDetail ] parameters:params showLoading:YES showError:YES success: ^(AFHTTPRequestOperation *operation, id responseObject) {
            if ([responseObject[QK_API_STATUS_CODE] isEqualToString:[NSString stringFromConst:QK_STT_CODE_SUCCESS]]) {
                _shopModel = [[QKShopInfoModel alloc]initWithResponse:responseObject];
                NSLog(@"Free Item List: %@", _shopModel.freeItemList);

                for (NSDictionary *jobInfoDic in[responseObject objectForKey:@"recruitmentList"]) {
                    QKRecruitmentModel *jobModel = [[QKRecruitmentModel alloc] initWithResponse:jobInfoDic];

                    [_recruitmentList addObject:jobModel];
                }
                for (QKRecruitmentModel *jobModel in _recruitmentList) {
                    if ([jobModel.recruitmentStatus isEqualToString:@"05"]) {
                        [_recruitmentListExist addObject:jobModel];
                    }
                }
               
                [self.tableView reloadData];
        
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

#pragma mark - UITableViewSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 1 + _shopModel.freeItemList.count;
            break;
        case 2:
        {
            if (_recruitmentListExist.count > 0) {
                return _recruitmentListExist.count;
            }
            return 1;
        }
            break;
        case 3:
            return 1;
            break;
        default:
            break;
    }
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 0.01;
            break;
        case 1:
            return 0.01;
        case 2:
            return 70.0;
            break;
        case 3:
            return 70.0;
            break;
        default:
            break;
    }
    return 0.01;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return nil;
            break;
        case 1:
            return nil;
            break;
        case 2:
            return NSLocalizedString(@"募集中のバイト", nil);
            break;
        case 3:
            return nil;
            break;
        default:
            break;
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
            return 213.0;
            break;
        case 1:
        {
            QKCSRecruitmentDecriptionCell *cell = (QKCSRecruitmentDecriptionCell *)[tableView dequeueReusableCellWithIdentifier:decriptionCell];
            if (cell == nil) {
                cell = [[QKCSRecruitmentDecriptionCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:decriptionCell];
            }
            cell.recruitmentModel = self.recruitmentModel;
            return [self calculateHeightForConfiguredSizingCell:cell inTableView:tableView];
        }
            break;
        case 2:
            if (_recruitmentListExist.count > 0) {
                return 165.0;

            }
            return 70.0;
            break;
        case 3:
        {
     
            QKCSRecruitmentLocationCell *cell = (QKCSRecruitmentLocationCell *)[tableView dequeueReusableCellWithIdentifier:locationCell];
            if (cell == nil) {
                cell = [[QKCSRecruitmentLocationCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:locationCell];
            }
            cell.recruitmentModel = self.recruitmentModel;
            return [self calculateHeightForConfiguredSizingCell:cell inTableView:tableView];
        }
            break;
        default:
            break;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:{
            QKCSImageViewCell *cell = (QKCSImageViewCell *)[tableView dequeueReusableCellWithIdentifier:imageViewCell];
            QKImageModel *imageModel;
            
            if (self.recruitmentModel.imageList.count > 0) {
                imageModel  = self.recruitmentModel.imageList[0];
                [cell.imageView1 setImageWithURL:imageModel.imageUrl];
                cell.imageView1.backgroundColor = [UIColor clearColor];
            }
            cell.recruitmentModel = self.recruitmentModel;
            return cell;
        }
            break;
        case 1: {
            QKCSRecruitmentDecriptionCell *cell = [tableView dequeueReusableCellWithIdentifier:decriptionCell];
            cell.recruitmentModel = self.recruitmentModel;
            cell.shopInfoModel = self.shopModel;
            return cell;
        }
            break;
        case 2: {
            
            if (_recruitmentListExist.count > 0) {
                QKCSRecuitmentTimeCell *cell = [tableView dequeueReusableCellWithIdentifier:recruitmentTimeCell];
                cell.recuitmentModel = [self.recruitmentListExist objectAtIndex:indexPath.row];
                return cell;
            }
            else {
                QKCSRecruitmentNoTimeCell *cell = [tableView dequeueReusableCellWithIdentifier:recruitmentNotimeCell];
                return cell;
            }
        }
            break;
        case 3: {
            QKCSRecruitmentLocationCell *cell = [tableView dequeueReusableCellWithIdentifier:locationCell];
            cell.recruitmentModel = self.recruitmentModel;
            return cell;
        }
            break;
        default:
            break;
    }
    return nil;
    
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    // Remove seperator inset
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    // Prevent the cell from inheriting the Table View's margin settings
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    
    // Explictly set your cell's layout margins
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}
@end

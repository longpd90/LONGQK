//
//  QKCLWorkerYearListViewController.m
//  quicker-cl-ios
//
//  Created by Quy on 7/29/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLWorkerYearListViewController.h"
#import "QKTableViewCell.h"
#import "QKCLWorkerYearModel.h"
#import "QKCLWorkerMonthListViewController.h"
@interface QKCLWorkerYearListViewController ()
@property (nonatomic, strong) NSMutableArray *yearList;
@property (nonatomic, strong) NSString *year;
@property (nonatomic, strong) NSString *month;
@end
static NSString *kQKTableViewCell = @"CELL";
@implementation QKCLWorkerYearListViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // [self getWorkersPast];
    [self setAngleLeftBarButton];
    [self.thisView setHidden:YES];
    [self setTitle:@"過去の勤務者"];
    
    
    self.yearList = [[NSMutableArray alloc]init];
    /*
     QKCLWorkerYearModel *year1 = [[QKCLWorkerYearModel alloc]init];
     year1.year = @"2014";
     
     //test
     QKCLWorkerMonthModel *month1 = [[QKCLWorkerMonthModel alloc]init];
     month1.month = @"1";
     month1.workersCount = @"10";
     [year1.monthList addObject:month1];
     QKCLWorkerMonthModel *month2 = [[QKCLWorkerMonthModel alloc]init];
     month2.month = @"2";
     month2.workersCount = @"20";
     [year1.monthList addObject:month2];
     [self.yearList addObject:year1];
     
     QKCLWorkerYearModel *year2 = [[QKCLWorkerYearModel alloc]init];
     year2.year = @"2015";
     
     //test
     QKCLWorkerMonthModel *month3 = [[QKCLWorkerMonthModel alloc]init];
     month3.month = @"3";
     month3.workersCount = @"30";
     [year2.monthList addObject:month3];
     QKCLWorkerMonthModel *month4 = [[QKCLWorkerMonthModel alloc]init];
     month4.month = @"4";
     month4.workersCount = @"40";
     [year2.monthList addObject:month4];
     [self.yearList addObject:year2];
     self.thisView.layer.contents = (id)[UIImage imageNamed:@"account_bgi_work.png"].CGImage;
     */
    [self getWorkersPast];
}

- (void)checkCountWorker {
    if ([self.yearList count] > 0) {
        [self.thisView setHidden:YES];
        [self.thisTableView setHidden:NO];
        [self.thisTableView reloadData];
    }
    else {
        [self.thisView setHidden:NO];
        [self.thisTableView setHidden:YES];
    }
}

#pragma mark- UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    QKCLWorkerYearModel *yearModel = [self.yearList objectAtIndex:section];
    return yearModel.monthList.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.yearList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    QKTableViewCell *cells = (QKTableViewCell *)[tableView dequeueReusableCellWithIdentifier:kQKTableViewCell];
    if (cells == nil) {
        cells = [[QKTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:kQKTableViewCell];
    }
    QKCLWorkerYearModel *yearModel = [self.yearList objectAtIndex:indexPath.section];
    QKCLWorkerMonthModel *monthnModel = [yearModel.monthList objectAtIndex:indexPath.row];
    
    cells.textLabel.text = [NSString stringWithFormat:@"%@月", monthnModel.month];
    
    cells.detailTextLabel.text = [NSString stringWithFormat:@"勤務者：%@名", monthnModel.workersCount];
    cell = cells;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    QKCLWorkerYearModel *yearmodel = [self.yearList objectAtIndex:indexPath.section];
    QKCLWorkerMonthModel *monthmodel = [yearmodel.monthList objectAtIndex:indexPath.row];
    
    self.year = yearmodel.year;
    self.month = monthmodel.month;
    [self performSegueWithIdentifier:@"QKWorkerMothSegue" sender:self];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 25.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    QKCLWorkerYearModel *yearModel = [self.yearList objectAtIndex:section];
    
    return [NSString stringWithFormat:@"%@年", yearModel.year];
}

- (void)getWorkersPast {
    if ([self connected]) {
        NSMutableDictionary *params = [NSMutableDictionary initWithApiKeyAndToken];
        [params setObject:[QKCLAccessUserDefaults getUserId] forKey:@"userId"];
        [params setObject:[QKCLAccessUserDefaults getActiveShopId] forKey:@"shopId"];
        [[QKCLRequestManager sharedManager] asyncGET:[NSString stringFromConst:qkClUrlWorkersPastYearList] parameters:params showLoading:YES showError:YES success: ^(AFHTTPRequestOperation *operation, id responseObject) {
            if ([responseObject[QK_API_STATUS_CODE] isEqualToString:[NSString stringFromConst:QK_STT_CODE_SUCCESS]]) {
                for (NSDictionary *dic in responseObject[@"yearList"]) {
                    QKCLWorkerYearModel *model = [[QKCLWorkerYearModel alloc]initWithResonponse:dic];
                    [self.yearList addObject:model];
                }
                [self checkCountWorker];
            }
        } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"error... %@", error);
        }];
    }
    else {
        [self showNoInternetViewWithSelector:@selector(getWorkersPast)];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"QKWorkerMothSegue"]) {
        QKCLWorkerMonthListViewController *vc = (QKCLWorkerMonthListViewController *)segue.destinationViewController;
        vc.year = self.year;
        
        vc.month = self.month;
    }
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

@end

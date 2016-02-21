//
//  QKCLWorkerMonthListViewController.m
//  quicker-cl-ios
//
//  Created by Quy on 7/30/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLWorkerMonthListViewController.h"
#import "QKCLWorkerDayModel.h"
#import "QKCLAdoptionUserModel.h"
#import "QKCLApplicantTableViewCell.h"
#import "QKCLWorkerDayModel.h"
@interface QKCLWorkerMonthListViewController ()
@property (nonatomic, strong) NSMutableArray *dayArray;

@end
static NSString *workerCell = @"QKCLApplicantTableViewCell";
@implementation QKCLWorkerMonthListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setAngleLeftBarButton];
    
    NSString *title = [NSString stringWithFormat:@"%@年%@月の勤務者", self.year, _month];
    [self setTitle:title];
    self.dayArray = [[NSMutableArray alloc]init];
    [self.thisTableView registerNib:[UINib nibWithNibName:workerCell bundle:[NSBundle mainBundle]] forCellReuseIdentifier:workerCell];
    // this for test
    /*
     QKCLWorkerDayModel *day26 = [[QKCLWorkerDayModel alloc]init];
     day26.day = @"26";
     
     
     QKAdoptionUserModel *workerModel1 = [[QKAdoptionUserModel alloc]init];
     workerModel1.adoptionUserName = @"小林 宗太";
     
     workerModel1.adoptionUserAge = @"23";
     [day26.adoptionList addObject:workerModel1];
     QKAdoptionUserModel *workerModel2 = [[QKAdoptionUserModel alloc]init];
     workerModel2.adoptionUserName = @"加藤 祐介";
     workerModel2.adoptionUserAge = @"21";
     [day26.adoptionList addObject:workerModel2];
     QKAdoptionUserModel *workerModel3 = [[QKAdoptionUserModel alloc]init];
     workerModel3.adoptionUserName = @"加藤 祐介";
     workerModel3.adoptionUserAge = @"20";
     [day26.adoptionList addObject:workerModel3];
     
     
     [self.dayArray addObject:day26];
     
     
     QKCLWorkerDayModel *day19  = [[QKCLWorkerDayModel alloc]init];
     day19.day = @"19";
     
     QKAdoptionUserModel *workerModel4 = [[QKAdoptionUserModel alloc]init];
     workerModel4.adoptionUserName = @"小林 宗太";
     
     workerModel4.adoptionUserAge = @"18";
     [day19.adoptionList addObject:workerModel4];
     QKAdoptionUserModel *workerModel5 = [[QKAdoptionUserModel alloc]init];
     workerModel5.adoptionUserName = @"加藤 祐介";
     workerModel5.adoptionUserAge = @"16";
     [day19.adoptionList addObject:workerModel5];
     
     
     [self.dayArray addObject:day19];
     
     */
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getWorkersDay];
}

- (void)getWorkersDay {
    if ([self connected]) {
        NSMutableDictionary *params = [NSMutableDictionary initWithApiKeyAndToken];
        [params setObject:[QKCLAccessUserDefaults getUserId] forKey:@"userId"];
        [params setObject:[QKCLAccessUserDefaults getActiveShopId] forKey:@"shopId"];
        [params setObject:self.month forKey:@"month"];
        [[QKCLRequestManager sharedManager] asyncGET:[NSString stringFromConst:qkClUrlWorkersPastMonthList] parameters:params showLoading:YES showError:YES success: ^(AFHTTPRequestOperation *operation, id responseObject) {
            if ([responseObject[QK_API_STATUS_CODE] isEqualToString:[NSString stringFromConst:QK_STT_CODE_SUCCESS]]) {
                for (NSDictionary *dic in responseObject[@"dayList"]) {
                    QKCLWorkerDayModel *model = [[QKCLWorkerDayModel alloc]initWithResponse:dic];
                    [self.dayArray addObject:model];
                }
                [self.thisTableView reloadData];
            }
        } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"error... %@", error);
        }];
    }
    else {
        [self showNoInternetViewWithSelector:@selector(getWorkersDay)];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    QKCLWorkerDayModel *dayModel = [self.dayArray objectAtIndex:section];
    
    return [dayModel.adoptionList count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.dayArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    
    QKCLApplicantTableViewCell *cells = (QKCLApplicantTableViewCell *)[tableView dequeueReusableCellWithIdentifier:workerCell];
    if (cells == nil) {
        cells = [[QKCLApplicantTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:workerCell];
    }
    QKCLWorkerDayModel *dayModel = [self.dayArray objectAtIndex:indexPath.section];
    
    QKCLAdoptionUserModel *adoptModel = [dayModel.adoptionList objectAtIndex:indexPath.row];
    cells.workerName.text = adoptModel.adoptionUserName;
    NSString *age = [NSString stringWithFormat:@"(%@歳・男性)", adoptModel.adoptionUserAge];
    if (indexPath.section == 0) {
        if (indexPath.row == 2) {
            [cells.ratingWorkerIcon setImage:[UIImage imageNamed:@"list_ic_rightfav"]];
        }
    }
    [cells.avartarImageView setImage:[UIImage imageNamed:@"camera_pic_hint_face"]];
    cells.workerAge.text = age;
    
    cell = cells;
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 25.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    QKCLWorkerDayModel *dayModel = [self.dayArray objectAtIndex:section];
    
    return [NSString stringWithFormat:@"%@日", dayModel.day];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end

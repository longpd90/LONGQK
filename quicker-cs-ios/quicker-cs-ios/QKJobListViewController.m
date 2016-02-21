//
//  QKJobListViewController.m
//  quicker-cs-ios
//
//  Created by LongPD-PC on 5/11/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKJobListViewController.h"
#import "QKJobTableViewCell.h"

@interface QKJobListViewController ()

@property (strong, nonatomic) NSMutableArray *recruitmentList;

@end

static NSString *jobTableViewCell = @"QKJobTableViewCell";

@implementation QKJobListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getJobList];
}

- (void)getJobList {
    if (!_recruitmentList) {
        _recruitmentList = [[NSMutableArray alloc] init];
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSMutableDictionary *params = [NSMutableDictionary initWithApiKey];
    [params setObject:[dateFormatter stringFromDate:[NSDate date]] forKey:@"targetDt"];
    [[QKRequestManager sharedManager] asyncGET:[NSString stringFromConst:qkCSUrlRecruitmentPreviewList] parameters:params showLoading:NO showError:YES success: ^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([responseObject[QK_API_STATUS_CODE] isEqualToString:[NSString stringFromConst:QK_STT_CODE_SUCCESS]]) {
            for (NSDictionary *jobInfoDic in[responseObject objectForKey:@"recruitmentList"]) {
                QKRecruitmentModel *jobModel = [[QKRecruitmentModel alloc] initWithResponse:jobInfoDic];
                [_recruitmentList addObject:jobModel];
            }
            NSInteger totalNum = [responseObject intForKey:@"totalNum"];
            self.totalLabel.text = [NSString stringWithFormat:@"%d 件あります",totalNum];
            
            [self refreshData];
        }
        
    } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    [self refreshData];
}

- (void)refreshData {
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

# pragma mark - Tableview delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _recruitmentList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 342;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *JobTableViewCellIdentifier = @"QKJobTableViewCell";
    
    QKJobTableViewCell *cell = (QKJobTableViewCell *)[tableView dequeueReusableCellWithIdentifier:JobTableViewCellIdentifier];
    
    if (!cell) {
        cell = [UIView loadFromNibNamed:JobTableViewCellIdentifier];
    }
    QKRecruitmentModel *model = [_recruitmentList objectAtIndex:indexPath.row];
    [cell setRecruitmentEntity:model];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}

#pragma mark - action

- (IBAction)dismissButtonClicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion: ^{
    }];
}

- (IBAction)signupButtonClicked:(id)sender {
    UINavigationController *mainMenuNavigationViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"QKNavigationSignupViewController"];
    [[UIApplication sharedApplication] keyWindow].rootViewController = mainMenuNavigationViewController;
    [[[UIApplication sharedApplication] keyWindow] makeKeyAndVisible];
}

@end

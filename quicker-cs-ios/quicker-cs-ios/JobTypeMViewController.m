//
//  JobTypeMViewController.m
//  quicker-cs-ios
//
//  Created by LongPD-PC on 5/25/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "JobTypeMViewController.h"
#import "QKJobTileModel.h"

@interface JobTypeMViewController ()

@end

@implementation JobTypeMViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = NSLocalizedString(@"ジャンル", nil);
    
    [self setAngleLeftBarButton];
    [self getData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getData {
    NSMutableDictionary *params = [NSMutableDictionary initWithApiKeyAndToken];
    [params setValue:_jobHistoryModel.jobtypeL.jobTile forKey:@"jobTypeLCd"];
    
    NSDictionary *response;
    NSError *error;
    BOOL result =  [[QKRequestManager sharedManager] syncGET:[NSString stringFromConst:qkUrlMasterJobTypeM] parameters:params response:&response error:&error showLoading:YES showError:YES];
    
    if (result) {
        self.jobtiles = [self loadItemsFromArray:response[@"jobTypeMMaster"]];
        [self.jobTypeMTableView reloadData];
    }
    else {
        NSLog(@"get data fail");
    }
}
- (NSArray *)loadItemsFromArray:(NSArray *)sourceArray {
    if (![sourceArray isKindOfClass:[NSArray class]]) return nil;
    if (sourceArray.count <= 0) return nil;

    NSMutableArray *array = [NSMutableArray array];
    
    for (NSDictionary *item in sourceArray) {
        QKJobTileModel *jobTileItem = [[QKJobTileModel alloc] initWithResponseJobTileM:item];
        [array addObject:jobTileItem];
    }
    return array;
}

#pragma mark - tableview delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _jobtiles.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ProfileCellIdentifier = @"PDSettingsCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ProfileCellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ProfileCellIdentifier];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
    }
    if (_jobtiles.count > 0) {
        QKJobTileModel *jobTile = [_jobtiles objectAtIndex:indexPath.row];
        cell.textLabel.text = jobTile.jobName;
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    QKJobTileModel *jobtile = [_jobtiles objectAtIndex:indexPath.row];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"QKDidSelectJobTypeM" object:jobtile];
    [self goBack:nil];
}

@end

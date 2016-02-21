//
//  JobTypeLViewController.m
//  quicker-cs-ios
//
//  Created by LongPD-PC on 5/25/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "JobTypeLViewController.h"

@interface JobTypeLViewController ()

@end

@implementation JobTypeLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = NSLocalizedString(@"業種", nil);
    [self setAngleLeftBarButton];
    [self getData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)getData {
    NSMutableDictionary *params = [NSMutableDictionary initWithApiKeyAndToken];
    NSDictionary *response;
    NSError *error;
    BOOL result =  [[QKRequestManager sharedManager] syncGET:[NSString stringFromConst:qkUrlMasterJobTypeL] parameters:params response:&response error:&error showLoading:YES showError:YES];
    
    if (result) {
        self.jobtiles = [self loadItemsFromArray:response[@"jobTypeLMaster"]];
        [self refreshView];
    }
}

- (void)refreshView {
    [self.jobTypeLTableView reloadData];
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
    [[NSNotificationCenter defaultCenter] postNotificationName:@"QKDidSelectJobTypeL" object:jobtile];
    [self goBack:nil];
}

- (NSArray *)loadItemsFromArray:(NSArray *)sourceArray {
    if (![sourceArray isKindOfClass:[NSArray class]]) return nil;
    if (sourceArray.count <= 0) return nil;
    NSMutableArray *array = [NSMutableArray array];
    
    for (NSDictionary *item in sourceArray) {
        QKJobTileModel *jobTileItem = [[QKJobTileModel alloc] initWithResponseJobTileL:item];
        [array addObject:jobTileItem];
    }
    return array;
}

@end

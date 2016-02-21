//
//  QKCLSelectMasterPreferenceViewController.m
//  quicker-cl-ios
//
//  Created by VietND on 7/31/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLSelectMasterPrefectureTableViewController.h"
#import "QKTableViewCell.h"

@interface QKCLSelectMasterPrefectureTableViewController ()
@property (nonatomic)   NSInteger selectedCurveIndex;
@property (strong, nonatomic) NSMutableArray *prefectureArrays;
@end
@implementation QKCLSelectMasterPrefectureTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //custom back on navigation
    [self setAngleLeftBarButton];
    
    //regist cell
    
    //get data for job type
    _prefectureArrays = [[NSMutableArray alloc]init];
    [self getPreferenceList];
}

#pragma Get JobType Data From Server
- (void)getPreferenceList {
    if ([self connected]) {
        NSDictionary *response;
        NSError *error;
        NSMutableDictionary *params = [NSMutableDictionary initWithApiKey];
        
        BOOL result =  [[QKCLRequestManager sharedManager] syncGET:[NSString stringFromConst:qkUrlMasterPrefecture] parameters:params response:&response error:&error showLoading:YES showError:YES];
        
        if (result) {
            for (NSDictionary *data in response[@"prefectureMaster"]) {
                QKCLMasterPrefectureModel *model = [[QKCLMasterPrefectureModel alloc]initWithRespone:data];
                [_prefectureArrays addObject:model];
            }
            [self.tableView reloadData];
        }
    }
    else {
        [self showNoInternetViewWithSelector:@selector(getPreferenceList)];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma TableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_prefectureArrays count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QKTableViewCell *cell = (QKTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"CellRow"];
    if (cell == nil) {
        cell = [[QKTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellRow"];
    }
    QKCLMasterPrefectureModel *model = [_prefectureArrays objectAtIndex:indexPath.row];
    cell.textLabel.text = model.prfName;
    
    if ([_currentPrefectureModel.prfJisCd isEqualToString:model.prfJisCd]) {
        cell.accessoryView = [UIView QKTableViewCellAccessoryCheckmark];
        _selectedCurveIndex = indexPath.row;
    }
    else {
        cell.accessoryView = nil;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.accessoryView = [UIView QKTableViewCellAccessoryCheckmark];
        _currentPrefectureModel = [_prefectureArrays objectAtIndex:indexPath.row];
        
        if (_selectedCurveIndex != indexPath.row) {
            NSIndexPath *oldPath = [NSIndexPath indexPathForRow:_selectedCurveIndex inSection:indexPath.section];
            cell = [tableView cellForRowAtIndexPath:oldPath];
            cell.accessoryView = nil;
            _selectedCurveIndex = indexPath.row;
        }
    }
    [self performSelector:@selector(goBack:) withObject:nil afterDelay:0.0];
}

- (void)goBack:(id)sender {
    [super goBack:sender];
    if ([self.delegate respondsToSelector:@selector(prefectureSelected:)]) {
        [self.delegate prefectureSelected:_currentPrefectureModel];
    }
}

@end

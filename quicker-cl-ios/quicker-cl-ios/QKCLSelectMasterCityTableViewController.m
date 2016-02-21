//
//  QKCLSelectMasterCityTableViewController.m
//  quicker-cl-ios
//
//  Created by VietND on 7/31/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLSelectMasterCityTableViewController.h"
#import "QKTableViewCell.h"


@interface QKCLSelectMasterCityTableViewController ()
@property (nonatomic)   NSInteger selectedCurveIndex;
@property (strong, nonatomic) NSMutableArray *cityArrays;
@end
@implementation QKCLSelectMasterCityTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //custom back on navigation
    [self setAngleLeftBarButton];
    
    //regist cell
    
    //get data
    _cityArrays = [[NSMutableArray alloc]init];
    [self getCityList];
}

#pragma Get JobType Data From Server
- (void)getCityList {
    if ([self connected]) {
        NSDictionary *response;
        NSError *error;
        NSMutableDictionary *params = [NSMutableDictionary initWithApiKey];
        [params setObject:_currentCityModel.prfJisCd forKey:@"prfJisCd"];
        
        BOOL result =  [[QKCLRequestManager sharedManager] syncGET:[NSString stringFromConst:qkUrlMasterCity] parameters:params response:&response error:&error showLoading:YES showError:YES];
        
        if (result) {
            for (NSDictionary *data in response[@"cityMaster"]) {
                QKCLMasterCityModel *model = [[QKCLMasterCityModel alloc]initWithRespone:data];
                [_cityArrays addObject:model];
            }
            [self.tableView reloadData];
        }
    }
    else {
        [self showNoInternetViewWithSelector:@selector(getCityList)];
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
    return [_cityArrays count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QKTableViewCell *cell = (QKTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"CellRow"];
    if (cell == nil) {
        cell = [[QKTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellRow"];
    }
    QKCLMasterCityModel *model = [_cityArrays objectAtIndex:indexPath.row];
    cell.textLabel.text = model.cityName;
    
    if ([_currentCityModel.cityJisCd isEqualToString:model.cityJisCd]) {
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
        self.currentCityModel = [_cityArrays objectAtIndex:indexPath.row];
        
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
    if ([self.delegate respondsToSelector:@selector(citySelected:)]) {
        [self.delegate citySelected:_currentCityModel];
    }
}

@end

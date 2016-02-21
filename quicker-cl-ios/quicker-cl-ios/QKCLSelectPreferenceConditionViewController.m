//
//  QKSelectPreferenceConditionViewController.m
//  quicker-cl-ios
//
//  Created by Vietnd on 6/13/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLSelectPreferenceConditionViewController.h"
#import "QKCLMasterPreferenceConditionModel.h"
#import "QKTableViewCell.h"

@interface QKCLSelectPreferenceConditionViewController ()
@property (strong, nonatomic) NSMutableArray *preConditionArrays;
@property (strong, nonatomic) NSMutableArray *selectedConditionArrays;
@end

@implementation QKCLSelectPreferenceConditionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setAngleLeftBarButton];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    //Constructor
    _preConditionArrays = [[NSMutableArray alloc]init];
    _selectedConditionArrays = [[NSMutableArray alloc]init];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getPreConditionList];
}

- (void)getPreConditionList {
    if ([self connected]) {
        //init data
        NSMutableDictionary *params = [NSMutableDictionary initWithApiKey];
        NSDictionary *response;
        NSError *error;
        BOOL result =  [[QKCLRequestManager sharedManager] syncGET:[NSString stringFromConst:qkUrlMasterPreferenceCondition] parameters:params response:&response error:&error showLoading:YES showError:YES];
        if (result) {
            for (NSDictionary *preCondition in response[@"preferenceCondition"]) {
                QKCLMasterPreferenceConditionModel *modfl = [[QKCLMasterPreferenceConditionModel alloc]initWithResponse:preCondition];
                [_preConditionArrays addObject:modfl];
                //check selected
                if ([_currentConditionCdArrays containsObject:preCondition[@"preferenceConditionCd"]]) {
                    [_selectedConditionArrays addObject:modfl];
                }
            }
            [self.tableView reloadData];
        }
    }
    else {
        [self showNoInternetViewWithSelector:@selector(getPreConditionList)];
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
    return [_preConditionArrays count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QKTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SwitchCell"];
    if (!cell) {
        cell = [[QKTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"SwitchCell"];
    }
    
    QKCLMasterPreferenceConditionModel *modfl = (QKCLMasterPreferenceConditionModel *)[_preConditionArrays objectAtIndex:indexPath.row];
    cell.textLabel.text = modfl.preferenceConditionName;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    UISwitch *switchView = [UIView QKSwitch];
    switchView.tag = indexPath.row;
    cell.accessoryView = switchView;
    [switchView setOn:NO animated:NO];
    [switchView addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
    
    if ([self.selectedConditionArrays containsObject:modfl]) {
        [switchView setOn:YES];
    }
    else {
        [switchView setOn:NO];
    }
    return cell;
}

- (void)switchChanged:(id)sender {
    UISwitch *switchControl = (UISwitch *)sender;
    QKCLMasterPreferenceConditionModel *model = [_preConditionArrays objectAtIndex:switchControl.tag];
    
    if (switchControl.on) {
        [self.selectedConditionArrays addObject:model];
    }
    else {
        [self.selectedConditionArrays removeObject:model];
    }
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

#pragma mark - Override
- (void)goBack:(id)sender {
    [super goBack:sender];
    if ([self.delegate respondsToSelector:@selector(preferenceConditionSelected:)]) {
        [self.delegate preferenceConditionSelected:self.selectedConditionArrays];
    }
}

@end

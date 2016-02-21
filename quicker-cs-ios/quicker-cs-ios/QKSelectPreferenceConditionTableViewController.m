//
//  QKSelectPreferenceConditionViewController.m
//  quicker-cl-ios
//
//  Created by Vietnd on 6/13/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKSelectPreferenceConditionTableViewController.h"
#import "QKMasterPreferenceConditionModel.h"
#import "QKTableViewCell.h"

@interface QKSelectPreferenceConditionTableViewController ()
@property (strong, nonatomic) NSMutableArray *preConditionArrays;
@property (strong, nonatomic) NSMutableArray *selectedConditionArrays;
@end

@implementation QKSelectPreferenceConditionTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setAngleLeftBarButton];
    
    [self getPreConditionList];
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    //Constructor
    _preConditionArrays = [[NSMutableArray alloc]init];
    _selectedConditionArrays = [[NSMutableArray alloc]init];
}

- (void)getPreConditionList {
    if ([self connected]) {
        //init data
        NSMutableDictionary *params = [NSMutableDictionary initWithApiKey];
        
        [[QKRequestManager sharedManager] asyncGET:[NSString stringFromConst:qkUrlMasterPreferenceCondition] parameters:params showLoading:NO showError:YES success: ^(AFHTTPRequestOperation *operation, id responseObject) {
            if ([responseObject[QK_API_STATUS_CODE]
                 isEqualToString:[NSString
                                  stringFromConst:QK_STT_CODE_SUCCESS]]) {
                     for (NSDictionary *preCondition in responseObject[@"preferenceCondition"]) {
                         QKMasterPreferenceConditionModel *modfl = [[QKMasterPreferenceConditionModel alloc]initWithResponse:preCondition];
                         [_preConditionArrays addObject:modfl];
                         //check selected
                         if ([_currentConditionCdArrays containsObject:preCondition[@"preferenceConditionCd"]]) {
                             [_selectedConditionArrays addObject:modfl];
                         }
                         [self.tableView reloadData];
                     }
                 }
        } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
        }];
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
    
    QKMasterPreferenceConditionModel *modfl = (QKMasterPreferenceConditionModel *)[_preConditionArrays objectAtIndex:indexPath.row];
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
    QKMasterPreferenceConditionModel *model = [_preConditionArrays objectAtIndex:switchControl.tag];
    
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

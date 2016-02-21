//
//  QKJobConditionTableViewController.m
//  quicker-cs-ios
//
//  Created by Quy on 5/21/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKRecruitmentFilterTableViewController.h"
#import "QKMasterPreferenceConditionModel.h"
#import "QKSelectPreferenceConditionTableViewController.h"
#import "QKTableViewCell.h"
#import "QKGlobalDatePickerView.h"
#import "QKGlobalPickerView.h"


@interface QKRecruitmentFilterTableViewController () < QKGlobalPickerViewDelegate, QKSelectPreferenceConditionDelegate>


@property (strong, nonatomic) QKGlobalPickerView *sortTypePickerView;
@property (strong, nonatomic) QKGlobalPickerView *startDatePicker;
@property (strong, nonatomic) QKGlobalPickerView *endDatePicker;
@property (strong, nonatomic) NSDateFormatter *dateFormatter;
@property (strong, nonatomic) NSMutableArray *preConditionArrays;
@property (strong, nonatomic) NSMutableArray *startTimeArrays;
@property (strong, nonatomic) NSMutableArray *endTimeArrays;
@end

static NSString *QKTableViewCellIdentifier = @"QKTableViewCell";

@implementation QKRecruitmentFilterTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setLeftBarButtonWithTitle:@"キャンセル" target:@selector(goBack:)];
    
    //filter
    NSMutableDictionary *dic = [[QKAccessUserDefaults getRecruitmentFilter] mutableCopy];
    if (dic) {
        _filter = nil;
        _filter = [[QKRecruitmentFilterModel alloc]initWithResponse:dic];
        
    }else{
        
        _filter = [[QKRecruitmentFilterModel alloc]init];
    }
    
    //dateFormatter
    _dateFormatter = [[NSDateFormatter alloc]init];
    [_dateFormatter setDateFormat:@"HH:mm"];
    
    _preConditionArrays = [[NSMutableArray alloc]init];
    if (_filter.preferenceCdArrays != nil && _filter.preferenceCdArrays.count > 0) {
        [self getPreConditionList];
    }
    
    _startTimeArrays =[[NSMutableArray alloc]init];
    
    for (int i = 0; i < 24; i++) {
        for (int j = 0; j < 60; j = j + 15) {
            NSString *str = [NSString stringWithFormat:@"%@%d:%@%d", i / 10 ?[NSString stringWithFormat:@"%d", i / 10] : @"0", i % 10, [NSString stringWithFormat:@"%d", j / 10], j % 10];
            [_startTimeArrays addObject:str];
            
        }
    }
    _endTimeArrays =[[NSMutableArray alloc]init];
    //    [_endTimeArrays addObject:@"24:00"];
}

- (void)getPreConditionList {
    if ([self connected]) {
        //init data
        NSMutableDictionary *params = [NSMutableDictionary initWithApiKey];
        
        [[QKRequestManager sharedManager] asyncGET:[NSString stringFromConst:qkUrlMasterPreferenceCondition] parameters:params showLoading:YES showError:YES success: ^(AFHTTPRequestOperation *operation, id responseObject) {
            if ([responseObject[QK_API_STATUS_CODE] isEqualToString:[NSString stringFromConst:QK_STT_CODE_SUCCESS]]) {
                
                
                for (NSDictionary *preCondition in responseObject[@"preferenceCondition"]) {
                    QKMasterPreferenceConditionModel *modfl = [[QKMasterPreferenceConditionModel alloc]initWithResponse:preCondition];
                    //check selected
                    if ([_filter.preferenceCdArrays containsObject:preCondition[@"preferenceConditionCd"]]) {
                        [_preConditionArrays addObject:modfl];
                    }
                    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:3 inSection:0];
                    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
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

#pragma mark - TableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    switch (section) {
        case 0:
            return 4;
            
        case 1:
            return 2;
            
        default:
            break;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QKTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:QKTableViewCellIdentifier];
    if (!cell) {
        cell = [[QKTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:QKTableViewCellIdentifier];
    }
    cell.accessoryType = UITableViewCellAccessoryNone;
    switch (indexPath.section) {
        case 0: {
            switch (indexPath.row) {
                case 0:
                    cell.textLabel.text = NSLocalizedString(@"並び順", nil);
                    if (_filter.sortCd != nil && ![_filter.sortCd isEqualToString:@""]) {
                        NSInteger index = [[[QKConst SORT_TYPE_MAP] allKeys] indexOfObject:_filter.sortCd];
                        cell.detailTextLabel.text = [[QKConst.SORT_TYPE_MAP allValues] objectAtIndex:index];
                    }
                    
                    [cell.detailTextLabel setHighlighted:YES];
                    break;
                    
                case 1:
                    cell.textLabel.text = NSLocalizedString(@"勤務開始時間", nil);
                    if (_filter.startDt != nil && ![_filter.startDt isEqualToString:@""]) {
                        cell.detailTextLabel.text = _filter.startDt;
                        [cell.detailTextLabel setHighlighted:YES];
                    }
                    else {
                        cell.detailTextLabel.text =  NSLocalizedString(@"未設定", nil);
                        [cell.detailTextLabel setHighlighted:NO];
                    }
                    
                    break;
                    
                case 2:
                    cell.textLabel.text = NSLocalizedString(@"勤務終了時間", nil);
                    if (_filter.endDt != nil && ![_filter.endDt isEqualToString:@""]) {
                        cell.detailTextLabel.text = _filter.endDt;
                        [cell.detailTextLabel setHighlighted:YES];
                    }
                    else {
                        cell.detailTextLabel.text =  NSLocalizedString(@"未設定", nil);
                        [cell.detailTextLabel setHighlighted:NO];
                    }
                    
                    break;
                    
                case 3:
                    cell.textLabel.text = NSLocalizedString(@"こだわり条件", nil);
                    
                    cell.detailTextLabel.text =  [self makePreferenceConditionString];
                    [cell.detailTextLabel setHighlighted:YES];
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    break;
                    
                default:
                    break;
            }
        }
            break;
            
        case 1: {
            switch (indexPath.row) {
                case 0:
                    cell.textLabel.text = NSLocalizedString(@"職種", nil);
                    cell.textLabel.textColor =[UIColor colorWithHexString:@"#ccc"];
                    cell.detailTextLabel.text = NSLocalizedString(@"飲食・フード", nil);
                    break;
                    
                case 1:
                    cell.textLabel.text = NSLocalizedString(@"勤務地", nil);
                    cell.textLabel.textColor =[UIColor colorWithHexString:@"#ccc"];
                    cell.detailTextLabel.text = NSLocalizedString(@"渋谷", nil);
                    break;
                    
                default:
                    break;
            }
            cell.userInteractionEnabled = NO;
        }
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            break;
            
        default:
            break;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0: {
                [self makeSortTypePickerView];
                break;
            }
                
            case 1:
            {
                if (_filter.startDt == nil || [_filter.startDt isEqualToString:@""]) {
                    QKTableViewCell *cell = (QKTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
                    cell.detailTextLabel.text = NSLocalizedString(@"選択してください", nil);
                }
                [self makeStartDatePicker];
                break;
            }
                
                
                
            case 2:
            {
                if (_filter.endDt == nil || [_filter.endDt isEqualToString:@""]) {
                    QKTableViewCell *cell = (QKTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
                    cell.detailTextLabel.text = NSLocalizedString(@"選択してください", nil);
                }
                [self makeEndDatePicker];
                break;
            }
                
            case 3:
                [self performSegueWithIdentifier:@"QKSelectPreferenceConditionSegue" sender:self];
                break;
                
            default:
                break;
        }
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    //override
}
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"QKSelectPreferenceConditionSegue"]) {
        QKSelectPreferenceConditionTableViewController *controller = (QKSelectPreferenceConditionTableViewController *)segue.destinationViewController;
        controller.delegate = self;
        controller.currentConditionCdArrays = _filter.preferenceCdArrays;
    }
}

#pragma mark- PickerViewDelegate

- (void)donePickerView:(QKGlobalPickerView *)pickerView selectedIndex:(NSInteger)selectedIndex {
    if (pickerView == self.sortTypePickerView) {
        _filter.sortCd = [[[QKConst SORT_TYPE_MAP] allKeys] objectAtIndex:selectedIndex];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        
        
    }
    if (pickerView == self.startDatePicker) {
        _filter.startDt = [pickerView.pickerData objectAtIndex:selectedIndex];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
        NSIndexPath *indexPathEnd = [NSIndexPath indexPathForRow:2 inSection:0];
        
        NSArray* startTimeData = [_filter.startDt componentsSeparatedByString: @":"];
        NSString* hourStartTime = [startTimeData objectAtIndex: 0];
        NSString *muniteStartTime = [startTimeData objectAtIndex:1];
        
        int hourStartTimeIntValue = [hourStartTime intValue];
        int muniteStartTimeIntValue = [muniteStartTime intValue];
        
        NSArray* endTimeData = [_filter.endDt componentsSeparatedByString: @":"];
        NSString* hourEndTime = [endTimeData objectAtIndex: 0];
        NSString *muniteEndTime = [endTimeData objectAtIndex:1];
        
        int hourEndTimeIntValue = [hourEndTime intValue];
        int muniteEndTimeIntValue = [muniteEndTime intValue];
        
        if ((hourEndTimeIntValue - hourStartTimeIntValue) < 1 ||
            (((hourEndTimeIntValue - hourStartTimeIntValue) == 1)  &&
             ((muniteEndTimeIntValue - muniteStartTimeIntValue) < 0))) {
                _filter.endDt = NSLocalizedString(@"未設定", nil);
                
            }
        [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPathEnd] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    if (pickerView == self.endDatePicker) {
        _filter.endDt = [pickerView.pickerData objectAtIndex:selectedIndex];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:2 inSection:0];
        [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    
}

-(void)cancelPickerView:(QKGlobalPickerView*)pickerView {
    if (pickerView == self.startDatePicker) {
        if (_filter.startDt == nil || [_filter.startDt isEqualToString:@""]) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
            QKTableViewCell *cell = (QKTableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath];
            cell.detailTextLabel.text =  NSLocalizedString(@"未設定", nil);
        }
        
    }
    if (pickerView == self.endDatePicker) {
        if (_filter.endDt == nil || [_filter.endDt isEqualToString:@""]) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:2 inSection:0];
            QKTableViewCell *cell = (QKTableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath];
            cell.detailTextLabel.text =  NSLocalizedString(@"未設定", nil);
        }
    }
}

#pragma mark -QkPreConditionDelegate
- (void)preferenceConditionSelected:(NSMutableArray *)selectedConditionArrays {
    _preConditionArrays = selectedConditionArrays;
    if (!_filter.preferenceCdArrays) {
        _filter.preferenceCdArrays = [[NSMutableArray alloc]init];
    }
    else {
        [_filter.preferenceCdArrays removeAllObjects];
    }
    for (QKMasterPreferenceConditionModel *model in selectedConditionArrays) {
        [_filter.preferenceCdArrays addObject:model.preferenceConditionCd];
    }
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:3 inSection:0];
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark -Actions
- (NSString *)makePreferenceConditionString {
    NSString *preConditionString = @"";
    BOOL isFirst = YES;
    for (QKMasterPreferenceConditionModel *model in _preConditionArrays) {
        if (isFirst) {
            isFirst = NO;
            preConditionString = model.preferenceConditionName;
        }
        else {
            preConditionString = [NSString stringWithFormat:@"%@,%@", preConditionString, model.preferenceConditionName];
        }
    }
    return preConditionString;
}

- (void)makeSortTypePickerView {
    if (!self.sortTypePickerView) {
        self.sortTypePickerView = [[QKGlobalPickerView alloc] init];
        self.sortTypePickerView.delegate = self;
    }
    [self.sortTypePickerView setPickerData:[[QKConst SORT_TYPE_MAP] allValues]];
    if (_filter.sortCd != nil && ![_filter.sortCd isEqualToString:@""]) {
        [self.sortTypePickerView setSelectedIndex:[[[QKConst SORT_TYPE_MAP] allKeys] indexOfObject:_filter.sortCd]];
    }
    
    [self.sortTypePickerView show];
}

- (void)makeStartDatePicker {
    
    if (!self.startDatePicker) {
        self.startDatePicker = [[QKGlobalPickerView alloc] init];
        self.startDatePicker.delegate = self;
        
        [self.startDatePicker setPickerData:self.startTimeArrays];
        
    }
    if (_filter.startDt != nil && ![_filter.startDt isEqualToString:@""]) {
        [self.startDatePicker setSelectedIndex:[self.startTimeArrays indexOfObject:_filter.startDt]];
    }
    [self.startDatePicker show];
}

- (void)makeEndDatePicker {
    if (!self.endDatePicker) {
        self.endDatePicker = [[QKGlobalPickerView alloc] init];
        self.endDatePicker.delegate = self;
    }
    
    //init
    if (_endTimeArrays != nil) {
        [_endTimeArrays removeAllObjects];
        
    }
    NSArray* startTimeData = [_filter.startDt componentsSeparatedByString: @":"];
    NSString* hour = [startTimeData objectAtIndex: 0];
    NSString *munite = [startTimeData objectAtIndex:1];
    
    int hourIntValue = [hour intValue];
    int muniteIntValue = [munite intValue];
    for (int i = hourIntValue + 1; i < hourIntValue + 25; i++) {
        if (i == (hourIntValue + 1)) {
            for (int j = muniteIntValue; j < 60; j = j + 15) {
                NSString *str = [NSString stringWithFormat:@"%@%d:%@%d", i / 10 ?[NSString stringWithFormat:@"%d", i / 10] : @"0", i % 10, [NSString stringWithFormat:@"%d", j / 10], j % 10];
                [_endTimeArrays addObject:str];
            }
        }
        else if (i == (hourIntValue + 24)) {
            for (int j = 0; j <= muniteIntValue; j = j + 15) {
                NSString *str = [NSString stringWithFormat:@"%@%d:%@%d", i / 10 ?[NSString stringWithFormat:@"%d", i / 10] : @"0", i % 10, [NSString stringWithFormat:@"%d", j / 10], j % 10];
                [_endTimeArrays addObject:str];
            }
        }
        else {
            for (int j = 0; j < 60; j = j + 15) {
                NSString *str = [NSString stringWithFormat:@"%@%d:%@%d", i / 10 ?[NSString stringWithFormat:@"%d", i / 10] : @"0", i % 10, [NSString stringWithFormat:@"%d", j / 10], j % 10];
                [_endTimeArrays addObject:str];
            }
        }
    }
    [self.endDatePicker setPickerData:self.endTimeArrays];
    if (_filter.endDt != nil && ![_filter.endDt isEqualToString:@""]) {
        if ([self.endTimeArrays containsObject:_filter.endDt]) {
            [self.endDatePicker setSelectedIndex:[self.endTimeArrays indexOfObject:_filter.endDt]];
        }
    }
    [self.endDatePicker reloadPicker];
    [self.endDatePicker show];
}

- (NSString *)parseTimeFormatter:(NSInteger)hour {
    if (hour < 10) {
        return [NSString stringWithFormat:@"0%ld", (long)hour];
    }
    else {
        return [NSString stringWithFormat:@"%ld", (long)hour];
    }
}

#pragma mark -IBActions
- (IBAction)updateFilterButtonClicked:(id)sender {
    [self updateRecruitmentFilter];
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        [[NSNotificationCenter defaultCenter]postNotificationName:@"QKChangeRecruitmentFilter" object:nil];
    }];
}

- (void)updateRecruitmentFilter {
    NSMutableDictionary *dic = [[QKAccessUserDefaults getRecruitmentFilter] mutableCopy];
    if(!dic) {
        dic = [[NSMutableDictionary alloc]init];
    }
    if (_filter.sortCd != nil) {
        [dic setObject:_filter.sortCd forKey:@"sortCd"];
    }
    if (_filter.startDt != nil) {
        [dic setObject:_filter.startDt forKey:@"startDt"];
    }
    if (_filter.endDt != nil) {
        [dic setObject:_filter.endDt forKey:@"endDt"];
    }
    if (_filter.preferenceCdArrays != nil) {
        [dic setObject:_filter.preferenceCdArrays forKey:@"preferenceCdArrays"];
    }
    [QKAccessUserDefaults setRecruitmentFilter:dic];
}

@end

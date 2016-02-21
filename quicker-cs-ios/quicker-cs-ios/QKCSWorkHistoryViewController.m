//
//  QKCSWorkHistoryViewController.m
//  quicker-cs-ios
//
//  Created by C Anh on 8/13/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCSWorkHistoryViewController.h"
#import "QKCSWorkHistoryCell.h"
#import "QKCSWorkHistoryTranferCell.h"
#import "QKCSWorkHistoryModel.h"
#import "QKRecruitmentModel.h"
#import "QKRecruitmentDetailViewController.h"
#import "QKCSDetailWorkHistoryViewController.h"
@interface QKCSWorkHistoryViewController () {
    BOOL nothing;
    NSString *stringSelected;
    BOOL workActualStatus;
    BOOL flagFavorite;
    BOOL isWorkHistory;
}

@property (strong, nonatomic) NSMutableArray *dateStringArray;
@property (strong, nonatomic) NSMutableArray *years;
@property (strong, nonatomic) NSMutableArray *months;
@property (strong, nonatomic) QKGlobalDatePickerView *datePicker;
@property (strong, nonatomic) QKGlobalPickerView *pickerView;

@property (strong, nonatomic) NSMutableArray *listWorkHistory;

@property (strong, nonatomic) QKRecruitmentModel *selectedRecruitment;

@end

@implementation QKCSWorkHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getAppliedRecruitmentList];
    nothing = NO;
    isWorkHistory = YES;
    workActualStatus = NO;
    flagFavorite = NO;
    _years = [[NSMutableArray alloc] init];
    NSArray *monthArray = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12"];
    _months = [[NSMutableArray alloc] initWithArray:monthArray];
    _dateStringArray = [[NSMutableArray alloc] init];
    [self setAngleLeftBarButton];
    self.navigationItem.title = NSLocalizedString(@"給料情報", nil);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Get Job List

- (void)getAppliedRecruitmentList {
    if ([self connected]) {
        // Call API
        NSMutableDictionary *params = [NSMutableDictionary initWithApiKeyAndToken];
        [params setObject:[QKAccessUserDefaults getUserId] forKey:@"userId"];
        
        [[QKRequestManager sharedManager] asyncGET:[NSString stringFromConst:qkCSUrlAppliedRecruitmentList] parameters:params showLoading:YES showError:YES success: ^(AFHTTPRequestOperation *operation, id responseObject) {
            self.listWorkHistory = [[NSMutableArray alloc] init];
                for (NSDictionary *appliedRecuitment in responseObject[@"appliedRecruitmentList"]) {
                    QKRecruitmentModel *appliedRecruitmentModel = [[QKRecruitmentModel alloc] initWithResponse:appliedRecuitment];
                    [self.listWorkHistory addObject:appliedRecruitmentModel];
                }
                [self refreshView];
            [self.tableView reloadData];
            
        } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
        }];
    }
    else {
        [self showNoInternetViewWithSelector:@selector(getAppliedRecruitmentList)];
    }
}
- (void)refreshView {
    if (_listWorkHistory.count>0) {
        self.nothingView.hidden = YES;
        self.tableView.hidden = NO;
        [self setRightBarButtonWithImage:[UIImage imageNamed:@"nav_btn_search_inactive"] target:@selector(clickToFilter)];

        [_tableView reloadData];
    }else{
        self.nothingView.hidden = NO;
        self.tableView.hidden = YES;
        [self setRightBarButtonWithImage:[UIImage imageNamed:@"nav_btn_search_active"] target:@selector(clickToFilter)];
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (_listWorkHistory.count > 0) {
        return 2;
    }
    else {
        return 0;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_listWorkHistory.count > 0) {
        if (section == 0) {
            int numberOfRowInSection1 = 0;
            for (QKRecruitmentModel *model in _listWorkHistory) {
                if ([model.workActualStatus isEqualToString:@"00"] || [model.workActualStatus isEqualToString:@"20"]) {
                    numberOfRowInSection1++;
                }
            }
            return numberOfRowInSection1;
        }
        else if (section == 1) {
            int numberOfRowInSection2 = 0;
            for (QKRecruitmentModel *model in _listWorkHistory) {
                if ([model.workActualStatus isEqualToString:@"10"] || [model.workActualStatus isEqualToString:@"25"]) {
                    numberOfRowInSection2++;
                }
            }
            return numberOfRowInSection2;
        }
    }

    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    if (indexPath.section == 0) {
        for (QKRecruitmentModel *model in _listWorkHistory) {
            if ([model.workActualStatus isEqualToString:@"20"] || [model.workActualStatus isEqualToString:@"00"]) {
                QKCSWorkHistoryTranferCell *tranferHistoryCell = [tableView dequeueReusableCellWithIdentifier:@"QKCSWorkHistoryTranferCell"];
                tranferHistoryCell.shopModel =  [self.listWorkHistory objectAtIndex:indexPath.row];
                cell = tranferHistoryCell;
            }
        }

    }
    else if (indexPath.section == 1) {
        for (QKRecruitmentModel *model in _listWorkHistory) {
            if ([model.workActualStatus isEqualToString:@"10"] || [model.workActualStatus isEqualToString:@"25"]) {

                QKCSWorkHistoryCell *historyCell = [tableView dequeueReusableCellWithIdentifier:@"QKCSWorkHistoryCell"];
                historyCell.shopModel =  [self.listWorkHistory objectAtIndex:indexPath.row];
                cell = historyCell;
            }
        }
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 85.0;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    // Remove seperator inset
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    // Prevent the cell from inheriting the Table View's margin settings
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    
    // Explictly set your cell's layout margins
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 70.0;
}
- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    if (section == 0) {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0,tableView.frame.size.width, 70.0)];

    if (1) {
        [view setBackgroundColor:[UIColor colorWithRed:244.0/255.0 green:250.0/255.0 blue:250.0/255.0 alpha:1.0]];
        QKF33Label *titleLabel = [[QKF33Label alloc] init];
        titleLabel.frame = CGRectMake(15, 10, tableView.frame.size.width, 50);
        titleLabel.numberOfLines = 2;
        [titleLabel setText:@"振込待ち\n2015年3月29日(月)勤務"];
        
        view.backgroundColor = [UIColor clearColor];
        [view addSubview:titleLabel];
    }
    
        
        return view;
//    }
//    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    _selectedRecruitment = [self.listWorkHistory objectAtIndex:indexPath.row];

    if ([_selectedRecruitment.employmentStatus isEqualToString:@"10"]
        || [_selectedRecruitment.employmentStatus isEqualToString:@"20"]
        || [_selectedRecruitment.employmentStatus isEqualToString:@"30"]) {

          [self performSegueWithIdentifier:@"QKCSDetailWorkHistorySegue" sender:self];
    }
    else if ([_selectedRecruitment.employmentStatus isEqualToString:@"00"]){
        // Go to C01 -7
        if ([_selectedRecruitment.workActualStatus isEqualToString:@"20"]
            || [_selectedRecruitment.workActualStatus isEqualToString:@"10"]) {
            [self performSegueWithIdentifier:@"QKCSShowDetailRecruitmentSegue" sender:self];
        }
        else {
            [self performSegueWithIdentifier:@"QKCSDetailWorkHistorySegue" sender:self];
        }
    }
}
- (void) clickToFilter {
    [self addDatePicker];
}
#pragma mark - QKGlobalPickerViewDelegate
- (void)donePickerView:(QKGlobalPickerView *)pickerView selectedIndex:(NSInteger)selectedIndex {
    [self setRightBarButtonWithImage:[UIImage imageNamed:@"nav_btn_search_active"] target:@selector(clickToFilter)];
    stringSelected = [self.pickerView.pickerData objectAtIndex:selectedIndex];
}
//
- (void)addDatePicker {
    self.pickerView = [[QKGlobalPickerView alloc] init];
    self.pickerView.delegate = self;
    
    NSDate *today = [[NSDate alloc] init];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setYear:-1];
    NSDate *lastYear = [gregorian dateByAddingComponents:offsetComponents toDate:today options:0];

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy"];
    NSString *yearString = [formatter stringFromDate:[NSDate date]];
    NSString *lastYearString = [formatter stringFromDate:lastYear];
    NSArray *yearArray = @[lastYearString, yearString];
    [self.years addObjectsFromArray:yearArray];
    [formatter setDateFormat:@"MM"];
    NSString *month;
    NSString *monthString = [formatter stringFromDate:[NSDate date]];
    if ([_dateStringArray count] == 0) {
        for (NSString *year in self.years) {
            if ([year isEqualToString:yearString]) {
                for (int i = 0; i < [self.months count]; i++) {
                    month = [self.months objectAtIndex:i];
                    if ([monthString containsString:month]) {
                        [_dateStringArray addObject:[NSString stringWithFormat:@"%@年%@月", year, month]];
                        break;
                    }
                    [_dateStringArray addObject:[NSString stringWithFormat:@"%@年%@月", year, month]];
                }
            }
            else {
                for (NSString *month in self.months) {
                    [_dateStringArray addObject:[NSString stringWithFormat:@"%@年%@月", year, month]];
                }
            }
        }
    }
    if (stringSelected) {
        [self.pickerView setSelectedIndex:[self.dateStringArray indexOfObject:stringSelected]];

    }
    else if (yearString && monthString) {
        [self.pickerView setSelectedIndex:[self.dateStringArray count] - 1];

    }
    [self.pickerView setPickerData:_dateStringArray];
    [self.pickerView show];
}
#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    if ([segue.identifier isEqualToString:@"QKCSShowDetailRecruitmentSegue"]) {
        QKRecruitmentDetailViewController *detailViewController = (QKRecruitmentDetailViewController *)segue.destinationViewController;
        detailViewController.recruitment = _selectedRecruitment;
        detailViewController.isWorkHistorycontroller = isWorkHistory;
    }
    else if ([segue.identifier isEqualToString:@"QKCSDetailWorkHistorySegue"]) {
        QKCSDetailWorkHistoryViewController *detailWorkHistoryController = (QKCSDetailWorkHistoryViewController *)segue.destinationViewController;
        detailWorkHistoryController.isFavoriteJob = flagFavorite;
        detailWorkHistoryController.recruitmentModel = _selectedRecruitment;
    }
}

@end

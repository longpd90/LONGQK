//
//  QKCalendarHorizontalView.m
//  quicker-cs-ios
//
//  Created by LongPD-PC on 6/4/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCalendarHorizontalView.h"
#import "QKCalendarTableViewCell.h"
#import "QKRecruitmentPerDay.h"

@interface QKCalendarHorizontalView ()
@property (nonatomic) BOOL isFirst;
@end
@implementation QKCalendarHorizontalView

- (void)awakeFromNib {
    self.backgroundColor = kQKGlobalBlueColor;
    _calendarTableView = [[UITableView alloc] init];
    _calendarTableView.dataSource = self;
    _calendarTableView.delegate = self;
    _calendarTableView.scrollEnabled = NO;
    [_calendarTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    _lastCellSelectedIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self addSubview:_calendarTableView];
    
    UISwipeGestureRecognizer *leftSwipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeLeftGestureHandler)];
    leftSwipeGesture.direction = UISwipeGestureRecognizerDirectionLeft;
    [self addGestureRecognizer:leftSwipeGesture];
    
    UISwipeGestureRecognizer *rightSwipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRightGestureHandler)];
    rightSwipeGesture.direction = UISwipeGestureRecognizerDirectionRight;
    [self addGestureRecognizer:rightSwipeGesture];
    
    
    _calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    [self setup];
}

- (void)layoutSubviews {
    _calendarTableView.frame = CGRectMake(0, 64, self.width, 50);
    [_calendarTableView setTransform:CGAffineTransformMakeRotation(-M_PI_2)];
}

- (void)setup {
    _months = [[NSMutableArray alloc] init];
    NSDate *monthBeginNow = [NSDate date].monthBegin;
    NSDate *afterMonthBegin = [[NSDate date] dateByAddingMonth:1];
    [_months addObject:monthBeginNow];
    [_months addObject:afterMonthBegin];
    
    //
    _isFirst = YES;
}

- (void)swipeLeftGestureHandler {
    NSIndexPath *lastLeftCellIndexPath = [_calendarTableView indexPathForRowAtPoint:CGPointMake(_calendarTableView.contentOffset.x, _calendarTableView.contentOffset.y + self.width / 16.0)];
    
    NSIndexPath *indexPath = [_calendarTableView indexPathForRowAtPoint:CGPointMake(_calendarTableView.contentOffset.x, _calendarTableView.contentOffset.y + self.width + self.width / 16.0)];
    
    if (lastLeftCellIndexPath.section == 0 && indexPath.row == 0 && indexPath.section == 0) {
        [_calendarTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:1] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
    else {
        [_calendarTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
}

- (void)swipeRightGestureHandler {
    NSIndexPath *lastLeftCellIndexPath = [_calendarTableView indexPathForRowAtPoint:CGPointMake(_calendarTableView.contentOffset.x, _calendarTableView.contentOffset.y + self.width - self.width / 16.0)];
    
    NSIndexPath *indexPath = [_calendarTableView indexPathForRowAtPoint:CGPointMake(_calendarTableView.contentOffset.x, _calendarTableView.contentOffset.y + self.width / 16.0)];
    if (lastLeftCellIndexPath.section == 1 && indexPath.row == 0 && indexPath.section == 0) {
        NSDate *date = [_months objectAtIndex:0];
        NSInteger numberDay = [self getNumberDayOfMonth:date];
        NSInteger dayIndex = [[NSDate date] stringValueFormattedBy:@"dd"].intValue;
        [_calendarTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForItem:numberDay - dayIndex inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
    else {
        [_calendarTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
}

- (void)swipeOneDayToRight {
    if (_lastCellSelectedIndexPath.row == 0 && _lastCellSelectedIndexPath.section == 0) {
        return;
    }
    else {
        NSIndexPath *nextSelectedIndexPath = [self swipeToRight];
        NSDate *date = [_months objectAtIndex:nextSelectedIndexPath.section];
        NSArray *arrayDate = [self daysForMonthAtDate:date startIndex:nextSelectedIndexPath.section];
        NSDate *dateCurrent = [arrayDate objectAtIndex:nextSelectedIndexPath.row];
        BOOL haveRecruitment = [self chekHaveRecruitment:dateCurrent];
        if (haveRecruitment) {
            [self changeDateWithIndexPath:nextSelectedIndexPath];
        } else {
            _lastCellSelectedIndexPath = nextSelectedIndexPath;
            [self swipeOneDayToRight];
        }
    }
}

- (NSIndexPath *)swipeToRight {
    NSIndexPath *nextSelectedIndexPath;
    NSDate *date = [_months objectAtIndex:0];
    NSInteger numberDay = [self getNumberDayOfMonth:date];
    NSInteger dayIndex = [[NSDate date] stringValueFormattedBy:@"dd"].intValue;
    
    if (_lastCellSelectedIndexPath.row == 0 && _lastCellSelectedIndexPath.section == 1) {
        nextSelectedIndexPath = [NSIndexPath indexPathForRow:numberDay - dayIndex inSection:0];
    }
    else {
        nextSelectedIndexPath = [NSIndexPath indexPathForRow:_lastCellSelectedIndexPath.row - 1 inSection:_lastCellSelectedIndexPath.section];
    }
    return nextSelectedIndexPath;
}

- (void)swipeOneDayToLeft {
    NSInteger lastRowIndex = [_calendarTableView numberOfRowsInSection:1];
    if (_lastCellSelectedIndexPath.row == lastRowIndex - 1 && _lastCellSelectedIndexPath.section == 1) {
        return;
    } else {
        NSIndexPath *nextSelectedIndexPath = [self swipeToLeft];
        NSDate *date = [_months objectAtIndex:nextSelectedIndexPath.section];
        NSArray *arrayDate = [self daysForMonthAtDate:date startIndex:nextSelectedIndexPath.section];
        NSDate *dateCurrent = [arrayDate objectAtIndex:nextSelectedIndexPath.row];
        BOOL haveRecruitment = [self chekHaveRecruitment:dateCurrent];
        if (haveRecruitment) {
            [self changeDateWithIndexPath:nextSelectedIndexPath];
        } else {
            _lastCellSelectedIndexPath = nextSelectedIndexPath;
            [self swipeOneDayToLeft];
        }
    }
}

- (NSIndexPath *)swipeToLeft {
    NSIndexPath *nextSelectedIndexPath;
    NSDate *date = [_months objectAtIndex:0];
    NSInteger numberDay = [self getNumberDayOfMonth:date];
    NSInteger dayIndex = [[NSDate date] stringValueFormattedBy:@"dd"].intValue;
    
    if (_lastCellSelectedIndexPath.row == numberDay - dayIndex && _lastCellSelectedIndexPath.section == 0) {
        nextSelectedIndexPath = [NSIndexPath indexPathForRow:0 inSection:_lastCellSelectedIndexPath.section + 1];
    }
    else {
        nextSelectedIndexPath = [NSIndexPath indexPathForRow:_lastCellSelectedIndexPath.row + 1 inSection:_lastCellSelectedIndexPath.section];
    }

    return nextSelectedIndexPath;
}

- (void)changeDateWithIndexPath:(NSIndexPath *)indexPath {
    QKCalendarTableViewCell *cellSelect = (QKCalendarTableViewCell *)[_calendarTableView cellForRowAtIndexPath:indexPath];
    [cellSelect setSelected:YES];
    
    QKCalendarTableViewCell *cellDeselect = (QKCalendarTableViewCell *)[_calendarTableView cellForRowAtIndexPath:_lastCellSelectedIndexPath];
    [cellDeselect deselectedCell];
    
    _lastCellSelectedIndexPath = indexPath;
    [_calendarTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionNone animated:YES];
    
    //call delegate
    if ([self.delegate respondsToSelector:@selector(changeDate:bySwipe:)]) {
        [self.delegate changeDate:[self getSelectedDate] bySwipe:YES];
    }

}



#pragma mark - private

- (NSInteger)getNumberDayOfMonth:(NSDate *)month {
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setMonth:[month stringValueFormattedBy:@"MM"].intValue];
    
    NSRange range = [_calendar rangeOfUnit:NSCalendarUnitDay
                                    inUnit:NSCalendarUnitMonth
                                   forDate:[_calendar dateFromComponents:comps]];
    return range.length;
}

- (NSArray *)daysForMonthAtDate:(NSDate *)date startIndex:(NSInteger)startIndex {
    NSDateComponents *months = [[NSDateComponents alloc] init];
    months.day = [self getNumberDayOfMonth:date];
    NSMutableArray *result = [NSMutableArray array];
    
    if (startIndex == 0) {
        for (NSUInteger i = [[NSDate date] stringValueFormattedBy:@"dd"].intValue; i <= months.day + 1; i++) {
            NSDateComponents *days = [[NSDateComponents alloc] init];
            days.day = i - 1;
            [result addObject:[_calendar dateByAddingComponents:days toDate:date options:0]];
        }
    }
    else {
        NSInteger dayIndex = [[NSDate date] stringValueFormattedBy:@"dd"].intValue;
        NSInteger monthNumberDay = [self getNumberDayOfMonth:date];
        for (NSUInteger i = 0; i < MIN(monthNumberDay, dayIndex); i++) {
            NSDateComponents *days = [[NSDateComponents alloc] init];
            days.day = i;
            [result addObject:[_calendar dateByAddingComponents:days toDate:date options:0]];
        }
    }
    return result;
}

- (NSDate *)getSelectedDate {
    NSDate *date = [_months objectAtIndex:_lastCellSelectedIndexPath.section];
    NSArray *arrayDate = [self daysForMonthAtDate:date startIndex:_lastCellSelectedIndexPath.section];
    NSDate *dateCurrent = [arrayDate objectAtIndex:_lastCellSelectedIndexPath.row];
    return dateCurrent;
}

- (void)setRecruitmentPerDays:(NSArray *)recruitmentPerDays {
    _recruitmentPerDays = recruitmentPerDays;
    [self.calendarTableView reloadData];
}

- (BOOL)chekHaveRecruitment:(NSDate *)dateCheck {
    BOOL result = NO;
    for (int i = 0; i < _recruitmentPerDays.count; i ++) {
        QKRecruitmentPerDay *recruitmentPerDay = (QKRecruitmentPerDay *)[_recruitmentPerDays objectAtIndex:i];
        if ([recruitmentPerDay.targetDate compare:dateCheck] == NSOrderedSame ) {
            result = YES;
        }
    }
    return result;
}

# pragma mark - Tableview delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSDate *date = [_months objectAtIndex:section];
    NSInteger numberDay = [self getNumberDayOfMonth:date];
    NSInteger dayIndex = [[NSDate date] stringValueFormattedBy:@"dd"].intValue;
    if (section == 0) {
        return numberDay - dayIndex + 1;
    }
    else {
        NSDate *afterMonthBegin = [[NSDate date] dateByAddingMonth:1];
        NSInteger monthNumberDay = [self getNumberDayOfMonth:afterMonthBegin];
        return MIN(monthNumberDay, dayIndex);
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.width / 8.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return self.width / 8.0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, self.width / 8.0)];
    [headerView setBackgroundColor:kQKGlobalBlueColor];
    UILabel *labelMonth = [[UILabel alloc] initWithFrame:headerView.frame];
    labelMonth.textColor = [UIColor whiteColor];
    [labelMonth setFont:[UIFont systemFontOfSize:19]];
    [labelMonth setTextAlignment:NSTextAlignmentCenter];
    NSDate *date = [_months objectAtIndex:section];
    NSInteger monthString = [date stringValueFormattedBy:@"MM"].intValue;
    labelMonth.text = [NSString stringWithFormat:@"%ld月", (long)monthString];
    [headerView addSubview:labelMonth];
    [labelMonth setTransform:CGAffineTransformMakeRotation(M_PI_2)];
    return headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *calendarCellTableViewCell = @"QKCalendarTableViewCell";
    
    QKCalendarTableViewCell *cell = (QKCalendarTableViewCell *)[tableView dequeueReusableCellWithIdentifier:calendarCellTableViewCell];
    if (cell == nil) {
        cell = [UIView loadFromNibNamed:calendarCellTableViewCell];
    }
    NSDate *date = [_months objectAtIndex:indexPath.section];
    NSArray *arrayDate = [self daysForMonthAtDate:date startIndex:indexPath.section];
    NSDate *dateCurrent = [arrayDate objectAtIndex:indexPath.row];
    BOOL haveRecruitment = [self chekHaveRecruitment:dateCurrent];
    cell.haveRecruitment = haveRecruitment;
    cell.dateInput = dateCurrent;
    if (indexPath.row == _lastCellSelectedIndexPath.row && indexPath.section == _lastCellSelectedIndexPath.section) {
        [cell setSelected:YES];
        if (_isFirst) {
            _isFirst = NO;
            //call delegate
            if ([self.delegate respondsToSelector:@selector(changeDate:bySwipe:)]) {
                [self.delegate changeDate:[self getSelectedDate] bySwipe:NO];
            }
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_lastCellSelectedIndexPath.section == indexPath.section &&
        _lastCellSelectedIndexPath.row == indexPath.row) {
        return;
    }
    NSDate *date = [_months objectAtIndex:indexPath.section];
    NSArray *arrayDate = [self daysForMonthAtDate:date startIndex:indexPath.section];
    NSDate *dateCurrent = [arrayDate objectAtIndex:indexPath.row];
    BOOL haveRecruitment = [self chekHaveRecruitment:dateCurrent];
    if (!haveRecruitment) {
        return;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    QKCalendarTableViewCell *cell = (QKCalendarTableViewCell *)[tableView cellForRowAtIndexPath:_lastCellSelectedIndexPath];
    [cell deselectedCell];
    _lastCellSelectedIndexPath = indexPath;
    
    //call delegate
    if ([self.delegate respondsToSelector:@selector(changeDate:bySwipe:)]) {
        [self.delegate changeDate:[self getSelectedDate] bySwipe:NO];
    }
}

@end

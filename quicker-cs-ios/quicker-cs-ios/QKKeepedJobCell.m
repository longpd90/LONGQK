//
//  QKKeepedJobCell.m
//  quicker-cs-ios
//
//  Created by Nguyen Huu Anh on 7/13/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKKeepedJobCell.h"

@implementation QKKeepedJobCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setRecModel:(QKRecruitmentModel *)recModel {
    _recModel = recModel;
    self.recNameLabel.text = recModel.shopInfo.name;
    self.recCategoryNameLabel.text = recModel.jobTypeSName;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSDate *startDate = [dateFormatter dateFromString:recModel.startDt];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:startDate];
    NSDate *endDate = [dateFormatter dateFromString:recModel.endDt];
    NSString *workStartString = [NSString stringWithFormat:@"%ld月%ld日", (long)[components month], (long)[components day]];
    [dateFormatter setDateFormat:@"HH:mm"];
    NSString *workTimeString;
    if ([self isSameDayWithDate1:startDate date2:endDate]) {
        workTimeString = [NSString stringWithFormat:@"%@~%@", [dateFormatter stringFromDate:startDate], [dateFormatter stringFromDate:endDate]];
    } else {
        workTimeString = [NSString stringWithFormat:@"%@~翌%@", [dateFormatter stringFromDate:startDate], [dateFormatter stringFromDate:endDate]];
    }
    self.workingTimeLabel.text = [NSString stringWithFormat:@"%@ %@   %@%@円",workStartString, workTimeString, [self getTextForSalaryUnitLabel], recModel.salaryPerUnit];
}

- (BOOL)isSameDayWithDate1:(NSDate*)date1 date2:(NSDate*)date2 {
    NSCalendar* calendar = [NSCalendar currentCalendar];
    
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;
    NSDateComponents* comp1 = [calendar components:unitFlags fromDate:date1];
    NSDateComponents* comp2 = [calendar components:unitFlags fromDate:date2];
    
    return [comp1 day]   == [comp2 day] &&
    [comp1 month] == [comp2 month] &&
    [comp1 year]  == [comp2 year];
}

- (NSString *)getTextForSalaryUnitLabel {
    NSString *result;
    if ([_recModel.salaryUnit isEqualToString:@"01"]) {
        result = @"時給￼";
    }
    else if ([_recModel.salaryUnit isEqualToString:@"02"]) {
        result = @"日給";
    }
    else if ([_recModel.salaryUnit isEqualToString:@"03"]) {
        result = @"月￼￼￼￼給";
    }
    return result;
}

@end

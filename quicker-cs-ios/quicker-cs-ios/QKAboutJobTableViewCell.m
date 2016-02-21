//
//  QKAboutJobTableViewCell.m
//  quicker-cs-ios
//
//  Created by LongPD-PC on 6/11/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKAboutJobTableViewCell.h"
#import "QKMasterPreferenceConditionModel.h"
#import "UIImageView+AFNetworking.h"
#import "NSNumber+QKCSConvertToCurrency.h"

@implementation QKAboutJobTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)setJobEntity:(QKRecruitmentModel *)jobEntity {
    _jobEntity = jobEntity;
    self.jobNameLabel.text = jobEntity.shopInfo.name;
    self.jobCatagoryLabel.text = [NSString stringWithFormat:@"%@/%@", jobEntity.jobTypeMName,jobEntity.jobTypeSName];
    
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* components = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:[self dateFromString:self.jobEntity.startDt]]; // Get necessary date components
    NSDateFormatter *dF = [[NSDateFormatter alloc] init];
    [dF setLocale:[[NSLocale alloc] initWithLocaleIdentifier:[[NSLocale preferredLanguages] objectAtIndex:0]]];
    [dF setDateFormat:@"EEE"];
    
    self.workStartDateLabel.text = [NSString stringWithFormat:@"勤務時間  %ld月 %ld日 (%@)", (long)[components month], (long)[components day], [dF stringFromDate:[self dateFromString:self.jobEntity.startDt]]];
    NSDate *startDate = [self dateFromString:self.jobEntity.startDt];
    NSDate *endDate = [self dateFromString:self.jobEntity.endDt];
    
    NSDateFormatter *dateformat = [[NSDateFormatter alloc] init];
    [dateformat setDateFormat:@"HH:mm"];
    if ([self isSameDayWithDate1:startDate date2:endDate]) {
        self.workingTimeLabel.text = [NSString stringWithFormat:@"%@ ~ %@", [dateformat stringFromDate:startDate], [dateformat stringFromDate:endDate]];
    } else {
        self.workingTimeLabel.text = [NSString stringWithFormat:@"%@ ~ 翌%@", [dateformat stringFromDate:startDate], [dateformat stringFromDate:endDate]];
    }
    self.restTimeLabel.text = [NSString stringWithFormat:@"休憩：%@ 分含む", jobEntity.recess];
    NSNumber *salaryNumber = [NSNumber numberWithInteger:[self.jobEntity.salaryTotal integerValue]];
    self.salaryTotalLabel.text = [NSString stringWithFormat:@"%@円",[salaryNumber convertToCurrency]];
    
    NSTimeInterval diff = [endDate timeIntervalSinceDate:startDate] - self.jobEntity.recess.intValue * 60;
    int hours = lround(floor(diff / 3600.)) % 100;
    int minutes = lround(floor(diff / 60.)) % 60;
    NSString *salaryUnit = @"";
    if ([self.jobEntity.salaryUnit isEqualToString:@"01"]) {
        salaryUnit = @"時給￼";
    }
    else if ([self.jobEntity.salaryUnit isEqualToString:@"02"]) {
        salaryUnit = @"日給";
    }
    else if ([self.jobEntity.salaryUnit isEqualToString:@"03"]) {
        salaryUnit = @"月￼￼￼￼給";
    }
    NSNumber *salaryPerUnit = [NSNumber numberWithInteger:[self.jobEntity.salaryPerUnit integerValue]];
    self.salaryPerUnitLabel.text = [NSString stringWithFormat:@"(%@%@円×実働%d時間%d分)",salaryUnit,[salaryPerUnit convertToCurrency], hours, minutes];
    NSNumber *transporationExpenses = [NSNumber numberWithInteger:self.jobEntity.transporationExpenses.integerValue];
    self.transportationExpensesLabel.text = [NSString stringWithFormat:@"交通費：別途%@円を支給",[transporationExpenses convertToCurrency]];
    
    self.employmentNuberLabel.text = [NSString stringWithFormat:@"%@名",self.jobEntity.employmentNum];
    
    self.baggedsLabel.text = jobEntity.baggageAndClothes;
    [self addPreferenceConditions];
    self.height = CGRectGetMaxY(self.preConditionView.frame);
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

- (void)addPreferenceConditions {
    float x = 0;
    float y = 0;
    float witdh = [UIApplication sharedApplication].keyWindow.frame.size.width  - 30.0;
    float imageWitdh = 64.0;
    float imageHeight = 45.0;
    int i = 0;
    for (QKMasterPreferenceConditionModel *preCondition in self.jobEntity.preferenceConditionList) {
        if (x + imageWitdh > witdh) {
            x = 0;
            y = y + 5.0 + imageHeight;
        }
        UIImageView *imv = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, imageWitdh, imageHeight)];
        [imv setImageWithURL:preCondition.preferenceConditionImagePath];
        [self.preConditionView addSubview:imv];
        x = x + imageWitdh + 5.0;
        i++;
    }
    CGRect frame = self.preConditionView.frame;
    if (x == 0 && y == 0) {
        frame.size.height = y;
        self.bottomContrain.constant = 0;
        
    } else
        frame.size.height = y + imageHeight;
    
    self.preConditionView.frame = frame;
    self.heightContrainPreCondition.constant = CGRectGetHeight(frame);
}

- (NSDate *)dateFromString:(NSString *)date {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    return [dateFormatter dateFromString:date];
}

@end

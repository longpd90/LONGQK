//
//  QKCSRecuitmentTimeCell.m
//  quicker-cs-ios
//
//  Created by C Anh on 8/19/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCSRecuitmentTimeCell.h"
#import "QKMasterPreferenceConditionModel.h"
#import "UIImageView+AFNetworking.h"
#import "QKConst.h"
#import "NSNumber+QKCSConvertToCurrency.h"


@implementation QKCSRecuitmentTimeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.completeRecruimentTimeView.layer.cornerRadius = 3.0;
    self.completeRecruimentTimeView.backgroundColor = [UIColor colorWithRed:242.0/255.0 green:142.0/255.0 blue:65.0/255.0 alpha:1];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setRecuitmentModel:(QKRecruitmentModel *)recuitmentModel {
    _recuitmentModel = recuitmentModel;
    if (([self.recuitmentModel.salaryTotal isEqualToString:@""]) || (self.recuitmentModel.salaryTotal == nil)) {
        self.totalSalaryLabel.text = @"0円";
    }
    else {
        NSNumber *salaryIntValue = [NSNumber numberWithInteger:[self.recuitmentModel.salaryTotal integerValue]];
        self.totalSalaryLabel.text = [NSString stringWithFormat:@"%@円", [salaryIntValue convertToCurrency]];

    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:[[NSLocale preferredLanguages] objectAtIndex:0]]];
    NSDate *startDate = [self dateFromString:self.recuitmentModel.startDt];
    NSDate *endDate = [self dateFromString:self.recuitmentModel.endDt];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:startDate];
    [dateFormatter setDateFormat:@"EEE"];
    self.workStartDateLabel.text = [NSString stringWithFormat:@"%ld 月 %ld 日 ( %@ )", (long)[components month], (long)[components day],[dateFormatter stringFromDate:startDate]];
    
    
    NSDateFormatter *dateformat = [[NSDateFormatter alloc] init];
    [dateformat setDateFormat:@"HH:mm"];
    if ([self isSameDayWithDate1:startDate date2:endDate]) {
        self.timeWorkingRecuitmentLabel.text = [NSString stringWithFormat:@"%@ ~ %@", [dateformat stringFromDate:startDate], [dateformat stringFromDate:endDate]];
    } else {
        self.timeWorkingRecuitmentLabel.text = [NSString stringWithFormat:@"%@ ~ 翌%@", [dateformat stringFromDate:startDate], [dateformat stringFromDate:endDate]];
    }
    [self drawClock:recuitmentModel.closingDt];
    self.timeCompleteLabel.text = [self timeFormatted:recuitmentModel.closingDt];
    self.jobTypeSLabel.text = recuitmentModel.jobTypeSName;
    //    [self checkCondition];
    [self addImageForPreConditionView];
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
- (void)drawClock :(NSDate *)closingDate {
    NSTimeInterval diff = [closingDate timeIntervalSinceDate:[NSDate date]];
    if (diff <= 0) {
        diff = 0;
    }
    NSInteger minute = diff/60;
    NSInteger divideMunite = minute%60;
    float percentCricle = divideMunite/60.0;
    [self.clockView setOption:percentCricle];
}


- (NSString *)timeFormatted:(NSDate *)closingDt
{
    NSTimeInterval timeInterval = [closingDt timeIntervalSinceDate:[NSDate date]];
    NSInteger totalSeconds = timeInterval;
    if (totalSeconds <= 0) {
        totalSeconds = 0;
    }
    if (totalSeconds > 3 * 60 * 60) {
        self.completeRecruimentTimeView.backgroundColor = kQKColorBase;
    } else {
        self.completeRecruimentTimeView.backgroundColor = kQKColorKey;
    }
    int minutes = (totalSeconds / 60) % 60;
    int hours = (totalSeconds / 3600 ) % 24;
    if (hours > 0){
        return [NSString stringWithFormat:@"あと%02d時間%02d分で募集終了！",hours, minutes];
    } else if (minutes > 0) {
        return [NSString stringWithFormat:@"あと%02d分で募集終了！", minutes];
    } else {
        return [NSString stringWithFormat:@"あと%02d分で募集終了！", minutes];
    }
}
- (void) checkCondition {
    for (QKMasterPreferenceConditionModel *preCondition in self.recuitmentModel.preferenceConditionList) {

        if ([preCondition.preferenceConditionCd isEqualToString:@"12"]) {
            self.condition1ImageView.width = 0.1;
        }
        if ([preCondition.preferenceConditionCd isEqualToString:@"00"]) {
            self.condition2ImageView.width = 0.1;
        }
        if (![preCondition.preferenceConditionCd isEqualToString:@"00"] && ![preCondition.preferenceConditionCd isEqualToString:@"12"]) {
        }
    }
}
- (void)addImageForPreConditionView {
    
   
        for (QKMasterPreferenceConditionModel *preCondition in _recuitmentModel.preferenceConditionList) {
            if ([preCondition.preferenceConditionCd isEqualToString:@"12"]) {
                NSLog(@"PreferenceConditionCD: %@", preCondition.preferenceConditionCd);
                NSLayoutConstraint *constraint = [NSLayoutConstraint
                                                  constraintWithItem:self.condition2ImageView
                                                  attribute:NSLayoutAttributeWidth
                                                  relatedBy:NSLayoutRelationEqual
                                                  toItem:nil
                                                  attribute:NSLayoutAttributeNotAnAttribute
                                                  multiplier:1.0
                                                  constant:30];
                [self.condition2ImageView setTranslatesAutoresizingMaskIntoConstraints:NO];

                [self.condition2ImageView.superview addConstraint:constraint];
            }
            
            if ([preCondition.preferenceConditionCd isEqualToString:@"00"]) {
                NSLayoutConstraint *constraint = [NSLayoutConstraint
                                                  constraintWithItem:self.condition1ImageView
                                                  attribute:NSLayoutAttributeWidth
                                                  relatedBy:NSLayoutRelationEqual
                                                  toItem:nil
                                                  attribute:NSLayoutAttributeNotAnAttribute
                                                  multiplier:1.0
                                                  constant:30];
                [self.condition1ImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
                [self.condition1ImageView.superview addConstraint:constraint];

            }
        }
}
- (NSDate *)dateFromString:(NSString *)date {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    return [dateFormatter dateFromString:date];
}
@end

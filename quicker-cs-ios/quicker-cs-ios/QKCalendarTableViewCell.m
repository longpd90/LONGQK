//
//  QKCalendarTableViewCell.m
//  quicker-cs-ios
//
//  Created by LongPD-PC on 6/4/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCalendarTableViewCell.h"

@implementation QKCalendarTableViewCell

- (void)awakeFromNib {
    self.todayLabel.hidden = YES;
    [self.contentView setTransform:CGAffineTransformMakeRotation(M_PI_2)];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    if (!_haveRecruitment) {
        return;
    }
    if (selected) {
        self.backGroundView.backgroundColor = [UIColor whiteColor];
        self.labelText.textColor = kQKColorBase;
        self.weekDayName.textColor = kQKColorBase;
        self.todayLabel.textColor = kQKColorBase;
    }
}

- (void)deselectedCell {
    self.backGroundView.backgroundColor = kQKGlobalBlueColor;
    self.labelText.textColor = kQKColorWhite;
    self.weekDayName.textColor = kQKColorWhite;
    self.todayLabel.textColor = kQKColorWhite;
}

- (void)setDateInput:(NSDate *)dateInput {
    _dateInput = dateInput;
    self.labelText.text = [NSString stringWithFormat:@"%ld", (long)[dateInput stringValueFormattedBy:@"dd"].integerValue];
    self.weekDayName.text = [dateInput stringValueFormattedBy:@"EEE"];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    if ([[dateFormatter stringFromDate:[NSDate date]] isEqualToString:[dateFormatter stringFromDate:dateInput]]) {
        self.todayLabel.hidden = NO;
    }
    dateFormatter = nil;
}

- (void)setHaveRecruitment:(BOOL)haveRecruitment {
    _haveRecruitment = haveRecruitment;
    if (!haveRecruitment) {
        self.todayLabel.textColor = kQKColorDisabled;
        self.labelText.textColor = kQKColorDisabled;
        self.weekDayName.textColor = kQKColorDisabled;

    } else {
        self.todayLabel.textColor = [UIColor whiteColor];
        self.labelText.textColor = [UIColor whiteColor];
        self.weekDayName.textColor = [UIColor whiteColor];

    }
}

@end

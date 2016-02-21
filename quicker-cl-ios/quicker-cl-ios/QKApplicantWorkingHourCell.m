//
//  QKApplicantWorkingHourCell.m
//  quicker-cl-ios
//
//  Created by Nguyen Huu Anh on 8/13/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKApplicantWorkingHourCell.h"

@implementation QKApplicantWorkingHourCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setCustomerSalaryModel:(QKCLCustomerSalaryModel *)customerSalaryModel {
    _customerSalaryModel = customerSalaryModel;
    self.actualStartDt.text = [self getStringFromDate:customerSalaryModel.actualStartDt];
    self.actualEndDtLabel.text = [self getStringFromDate:customerSalaryModel.actualEndDt];
    
    self.worktimeLabel.text = [self getWorktimeFrom:customerSalaryModel.actualStartDt to:customerSalaryModel.actualEndDt withRecess:customerSalaryModel.actualRecess];
    self.recessLabel.text = [NSString stringWithFormat:@"(休憩%d分)", customerSalaryModel.actualRecess];
}

- (NSString *)getWorktimeFrom:(NSDate *)start to:(NSDate *)to withRecess:(int)recess {
    NSTimeInterval timeInterval = [to timeIntervalSinceDate:start];
    NSInteger totalSeconds = timeInterval - recess*60;
    if (totalSeconds <= 0) {
        totalSeconds = 0;
    }
    
    int minutes = (totalSeconds / 60) % 60;
    int hours = (totalSeconds / 3600) % 24;
    int days = (totalSeconds / 86400);
    
    if (days > 0) {
        return [NSString stringWithFormat:@"%d日%02d時間%02d分", days, hours, minutes];
    }
    
    if (hours > 0) {
        return [NSString stringWithFormat:@"%02d時間%02d分", hours, minutes];
    }
    else if (minutes > 0) {
        return [NSString stringWithFormat:@"%02d分", minutes];
    }
    
    return nil;

}

- (NSString *)getStringFromDate:(NSDate *)date {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy年dd月MM日 HH:mm"];
    return [dateFormatter stringFromDate:date];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end

//
//  QKClWorkerTableViewCell.m
//  quicker-cl-ios
//
//  Created by Quy on 8/3/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKClWorkerTableViewCell.h"
#import "QKCLConst.h"
#import "NSDate+Extra.h"
#import "chiase-ios-core/NSString+Extra.h"
#import "QKCLAdoptionUserModel.h"

@implementation QKClWorkerTableViewCell

- (void)awakeFromNib {
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
}

- (void)setUpHeaderText {
    _leftHeaderLabel.text = @"勤務済";
    _middleHeaderLabel.text = @"";
    _rightHeaderLabel.text = @"給与の支払いを完了してください";
    
    
    _headerView.backgroundColor = kQKColorBtnSecondary;
}

- (void)setUpHeaderNormalText {
    _leftHeaderLabel.text = @"勤務前";
    _middleHeaderLabel.text = @"勤務開始まで";
    _rightHeaderLabel.text = @"あと2時間34分";
    _headerView.backgroundColor = kQKColorBase;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

-(void)setData:(QKCLRecruitmentModel*)recruitment {
    self.jobTypeSName.text = recruitment.jobTypeSName;
    self.dayLabel.text = [NSDate calculateWorkTime:recruitment.startDt endTime:recruitment.endDt];
    
    if ([recruitment.workStatus isEqualToString:[NSString stringFromConst:QK_WORK_STATUS_WORK_BEFORE ]]) {
        _leftHeaderLabel.text = NSLocalizedString( @"勤務前", nil);
        _middleHeaderLabel.text = NSLocalizedString(@"勤務開始まで", nil);
        _rightHeaderLabel.text = [self returnCountDown:recruitment.closingDt];
        _headerView.backgroundColor = kQKColorBase;
        
    }else if ([recruitment.workStatus isEqualToString:[NSString stringFromConst:QK_WORK_STATUS_WORK ]]) {
        _leftHeaderLabel.text = NSLocalizedString( @"勤務中", nil);
        _middleHeaderLabel.text = @"";
        _rightHeaderLabel.text = @"";
        _headerView.backgroundColor = kQKColorBase;
    }
    else if ([recruitment.workStatus isEqualToString:[NSString stringFromConst:QK_WORK_STATUS_WORK_AFTER ]]) {
        _leftHeaderLabel.text = NSLocalizedString( @"勤務済", nil);
        _middleHeaderLabel.text = @"";
        _headerView.backgroundColor = kQKColorBtnSecondary;
        QKCLAdoptionUserModel *adoptUserModel = recruitment.adoptionList[0];
        if ( [adoptUserModel.workActualStatus isEqualToString:[NSString stringFromConst:QK_CL_WORK_ACTUAL_STATUS_INPUT_BEFORE]]) {
            //actualStatus = 00
            _rightHeaderLabel.text = NSLocalizedString(@"勤務実績を入力してください", nil);
        }
        else if ( [adoptUserModel.workActualStatus isEqualToString:[NSString stringFromConst:QK_CL_WORK_ACTUAL_STATUS_INPUT_ALREADY]]) {
            //actualStatus = 10
            _rightHeaderLabel.text = NSLocalizedString(@"勤務実績を確認中です", nil);
        }else if ( [adoptUserModel.workActualStatus isEqualToString:[NSString stringFromConst:QK_CL_WORK_ACTUAL_STATUS_PENDING]]) {
            //actualStatus = 20
            _rightHeaderLabel.text = NSLocalizedString(@"勤務実績を修正してください", nil);
        }else if ( [adoptUserModel.workActualStatus isEqualToString:[NSString stringFromConst:QK_CL_WORK_ACTUAL_STATUS_APPROVAL]]) {
            //actualStatus = 25
            _rightHeaderLabel.text = @"";
        }
    }
    
    
}
-(NSString*)returnCountDown:(NSDate*)closingDt {
    NSString*countDownString =@"";
    //count down
    if ([closingDt isLaterThanDate:[NSDate date]]) {
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSDateComponents *components = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit
                                                   fromDate:[NSDate date]
                                                     toDate:closingDt
                                                    options:0];
        
        
        if (components.hour > 0) {
            countDownString = [NSString stringWithFormat:@"あと%ld時間%ld分", (long)components.hour, (long)components.minute];
        }
        else {
            countDownString = [NSString stringWithFormat:@"あと%ld分", (long)components.minute];
        }
    }
    else {
        countDownString  = NSLocalizedString(@"あと0分", nil);
    }
    return countDownString;
}
@end

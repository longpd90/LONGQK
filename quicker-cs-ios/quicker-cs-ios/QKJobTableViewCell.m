//
//  QKJobTableViewCell.m
//  quicker-cs-ios
//
//  Created by LongPD-PC on 5/11/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKJobTableViewCell.h"
#import "QKMasterPreferenceConditionModel.h"
#import "QKConst.h"
#import "NSDate+Extra.h"

@implementation QKJobTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self setUpInterface];
}

- (void)setUpInterface {
    self.backgroundCellView.layer.cornerRadius = 4;
    self.backgroundCellView.layer.shadowOffset = CGSizeMake(1, 1);
    self.backgroundCellView.layer.shadowOpacity = 0.5;
    self.backgroundCellView.layer.shadowRadius = 2;
    self.backgroundCellView.layer.shadowColor = [UIColor darkGrayColor].CGColor;
    self.backgroundCellView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.backgroundCellView.layer.borderWidth = 0.5;
    
    self.personInChargeImageView.layer.borderWidth = 3.0;
    self.personInChargeImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    
    
    //    CAShapeLayer *maskLayerOverView = [CAShapeLayer layer];
    //    maskLayerOverView.frame = self.shopImageView.frame;
    //    UIBezierPath *roundedPathOverView =
    //    [UIBezierPath bezierPathWithRoundedRect:maskLayerOverView.bounds
    //                          byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight
    //                                cornerRadii:CGSizeMake(4, 4)];
    //    maskLayerOverView.path = [roundedPathOverView CGPath];
    //
    //    self.shopImageView.layer.mask = maskLayerOverView;
    //
    //    CAShapeLayer *maskLayerOverView1 = [CAShapeLayer layer];
    //    maskLayerOverView1.frame = self.dimView.frame;
    //    UIBezierPath *roundedPathOverView1 =
    //    [UIBezierPath bezierPathWithRoundedRect:maskLayerOverView1.bounds
    //                          byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight
    //                                cornerRadii:CGSizeMake(4, 4)];
    //    maskLayerOverView1.path = [roundedPathOverView1 CGPath];
    //
    //    self.dimView.layer.mask = maskLayerOverView1;
    
    self.personInChargeImageView.layer.cornerRadius = 33.5f;
}


- (void)setRecruitmentEntity:(QKRecruitmentModel *)entity {
    _recruitmentEntity = entity;
    if (entity.shopInfo.imageFileList.count > 0) {
        @try {
            QKImageModel *shopImageModel = entity.shopInfo.imageFileList[0];
            [self.shopImageView setImageWithQKURL:shopImageModel.imageUrl placeholderImage:nil withCache:YES];
        }
        @catch (NSException *exception)
        {
        }
    }
    self.recNameLabel.text = entity.shopInfo.name;
    self.recCategoryNameLabel.text = entity.jobTypeSName;
    [self.personInChargeImageView setImageWithQKURL:entity.personInChargeImageUrl placeholderImage:nil withCache:YES];
    //self.countDownLabel.text = [self timeFormatted:entity.closingDt];
    
    self.coutDownView.backgroundColor = kQKColorKey;
    //count down
    if ([entity.closingDt isLaterThanDate:[NSDate date]]) {
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSDateComponents *components = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit
                                                   fromDate:[NSDate date]
                                                     toDate:entity.closingDt
                                                    options:0];
        
        NSString *countDownString = @"";
        if (components.day > 0) {
            countDownString = [NSString stringWithFormat:@"あと%ld日%ld時間%ld分で募集終了!", (long)components.day, (long)components.hour, (long)components.minute];
        }
        else if (components.hour > 0) {
            countDownString = [NSString stringWithFormat:@"あと%ld時間%ld分で募集終了!", (long)components.hour, (long)components.minute];
            if (components.hour >3 && components.day == 0) {
                self.coutDownView.backgroundColor = kQKColorBase;
            }
        }
        else {
            
            countDownString = [NSString stringWithFormat:@"あと%ld分で募集終了!", (long)components.minute];
            
        }
        self.countDownLabel.text = countDownString;
    }
    else {
        self.countDownLabel.text  = NSLocalizedString(@"あと0分で募集終了!", nil);
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:[[NSLocale preferredLanguages] objectAtIndex:0]]];
    NSDate *startDate = [dateFormatter dateFromString:entity.startDt];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:startDate];
    NSDate *endDate = [dateFormatter dateFromString:entity.endDt];
    [dateFormatter setDateFormat:@"EEE"];
    self.workStartDtLabel.text = [NSString stringWithFormat:@"%ld 月 %ld 日 ( %@ )", (long)[components month], (long)[components day],[dateFormatter stringFromDate:startDate]];
    [dateFormatter setDateFormat:@"HH:mm"];
    if ([self isSameDayWithDate1:startDate date2:endDate]) {
        self.workTimeLabel.text = [NSString stringWithFormat:@"%@ ~ %@", [dateFormatter stringFromDate:startDate], [dateFormatter stringFromDate:endDate]];
    } else {
        self.workTimeLabel.text = [NSString stringWithFormat:@"%@ ~ 翌%@", [dateFormatter stringFromDate:startDate], [dateFormatter stringFromDate:endDate]];
    }
    
    
    self.salaryPerUnitLabel.text = [NSString stringWithFormat:@"%@円", entity.salaryPerUnit];
    NSString*accessWay;
    if (entity.shopInfo.wayside1 && ![entity.shopInfo.wayside1 isEqualToString:@""]) {
        accessWay =[NSString stringWithFormat:@"%@",entity.shopInfo.wayside1];
    }
    if (entity.shopInfo.wayside2 && ![entity.shopInfo.wayside2 isEqualToString:@""]) {
        accessWay =[NSString stringWithFormat:@"%@,%@",accessWay,entity.shopInfo.wayside2];
    }
    if (entity.shopInfo.wayside3 && ![entity.shopInfo.wayside3 isEqualToString:@""]) {
        accessWay =[NSString stringWithFormat:@"%@,%@",accessWay,entity.shopInfo.wayside3];
    }
    self.accessWayLabel.text = accessWay;
    [self addImageForPreConditionView];
    [self drawClock:entity.closingDt];
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

- (void)setTextForSalaryUnitLabel {
    if ([_recruitmentEntity.salaryUnit isEqualToString:@"01"]) {
        self.salaryUnitLabel.text = @"時給￼";
    }
    else if ([_recruitmentEntity.salaryUnit isEqualToString:@"02"]) {
        self.salaryUnitLabel.text = @"日給";
    }
    else if ([_recruitmentEntity.salaryUnit isEqualToString:@"03"]) {
        self.salaryUnitLabel.text = @"月￼￼￼￼給";
    }
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


- (void)addImageForPreConditionView {
    self.condition2ImageView.hidden = YES;
    self.condition1ImageView.hidden = YES;
    float imageWitdh = 35.0;
    float imageHeight = 35.0;
    UIView *tempView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 35.0)];
    float x = 40;
    float y = 0;
    NSMutableArray *imageArray = [[NSMutableArray alloc] init];
    
    for (QKMasterPreferenceConditionModel *preCondition in _recruitmentEntity.preferenceConditionList) {
        UIImageView *imv = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, imageWitdh, imageHeight)];
        //        imv.image = [UIImage imageNamed:[NSString stringWithFormat:@"recruit_ic_conditions_%@", preCondition.preferenceConditionCd]];
        if ([preCondition.preferenceConditionCd isEqualToString:@"12"]) {
            imv.image = [UIImage imageNamed:@"signup_ic_conditions_mini_02"];
            [imageArray addObject:imv];
        }
        if ([preCondition.preferenceConditionCd isEqualToString:@"00"]) {
            imv.image = [UIImage imageNamed:@"signup_ic_conditions_mini_01"];
            [imageArray addObject:imv];
        }
        [tempView addSubview:imv];
        
        if (x > 0) {
            x = x - imageWitdh - 5.0;
            
        }
        //            x = x + imageWitdh + 5.0;
    }
    CGRect tempViewFrame = tempView.frame;
    tempViewFrame.size.width = x;
    tempViewFrame.origin.x = CGRectGetWidth(self.preConditionsView.frame) - x;
    [self.preConditionsView addSubview:tempView];
    CGRect frame = self.preConditionsView.frame;
    frame.size.height = y + imageHeight;
    self.preConditionsView.frame = frame;
}

@end

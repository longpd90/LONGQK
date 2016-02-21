//
//  QKSubcriedTableViewCell.m
//  quicker-cs-ios
//
//  Created by LongPD-PC on 6/9/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKSubcriedTableViewCell.h"
#import "QKConst.h"

@implementation QKSubcriedTableViewCell

- (void)awakeFromNib {
    
    CAShapeLayer * maskLayer = [CAShapeLayer layer];
    maskLayer.path = [UIBezierPath bezierPathWithRoundedRect: _callView.bounds byRoundingCorners: UIRectCornerTopLeft | UIRectCornerBottomLeft cornerRadii: (CGSize){3.0, 3.0}].CGPath;
    _callView.layer.mask = maskLayer;
    
    maskLayer = [CAShapeLayer layer];
    maskLayer.path = [UIBezierPath bezierPathWithRoundedRect: _mapView.bounds byRoundingCorners: UIRectCornerTopRight | UIRectCornerBottomRight cornerRadii: (CGSize){3.0, 3.0}].CGPath;
    _mapView.layer.mask = maskLayer;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setRecruitmentAppiled:(QKRecruitmentModel *)recruitmentAppiled {
    _recruitmentAppiled = recruitmentAppiled;
    self.nameLabel.text = recruitmentAppiled.shopInfo.name;
    self.typeLabel.text = recruitmentAppiled.jobTypeSName;
    _appliCantStatusLabel.text = [[QKConst APPLI_CANT_STATUS_MAP] objectForKey:recruitmentAppiled.applicantStatus];
   
    if ([recruitmentAppiled.applicantStatus isEqualToString:@"10"]) {
        self.statusImageView.image = [UIImage imageNamed:@"recruit_ic_review_adoption"];
    } else {
        self.statusImageView.image = [UIImage imageNamed:@"recruit_ic_review_stop"];
    }
    
    if ([recruitmentAppiled.workActualStatus isEqualToString:@"00"]) {
        self.countDownLabel.text = [[QKConst WORK_STATUS_MAP] objectForKey:@"20"];
        self.clockView.hidden = YES;
    } else {
        self.countDownLabel.text = [[QKConst WORK_STATUS_MAP] objectForKey:recruitmentAppiled.workStatus];
        if ([recruitmentAppiled.workStatus isEqualToString:@"00"] ) {
            self.clockView.hidden = NO;
        } else {
            self.clockView.hidden = YES;
        }
    }
    
    if ([recruitmentAppiled.workStatus isEqualToString:@"00"] ||
        [recruitmentAppiled.workStatus isEqualToString:@"10"]) {
        self.expandView.hidden = NO;
    } else {
        self.expandView.hidden = YES;
    }
    [self drawClock:recruitmentAppiled.closingDt];
}

- (IBAction)phoneNumberClicked:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(gotoCallWithRecruitment:)]) {
        [self.delegate gotoCallWithRecruitment:_recruitmentAppiled];
    }
}

- (IBAction)messegeButtonClicked:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(gotoMessengerWithRecruitment:)]) {
        [self.delegate gotoMessengerWithRecruitment:_recruitmentAppiled];
    }
}

- (IBAction)mapButtonClicked:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(gotoMapWithRecruitment:)]) {
        [self.delegate gotoMapWithRecruitment:_recruitmentAppiled];
    }
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

@end

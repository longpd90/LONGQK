//
//  QKConfirmApplyRecAlertView.m
//  quicker-cs-ios
//
//  Created by Nguyen Huu Anh on 7/10/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKConfirmApplyRecAlertView.h"

@implementation QKConfirmApplyRecAlertView

- (instancetype)initConfirmApplyRecAlertView {
    self = [[[NSBundle mainBundle] loadNibNamed:@"QKConfirmApplyRecAlertView" owner:self options:nil] firstObject];
    if (self) {
        self.frame = self.keyWindow.frame;
    }
    return self;
}

- (void)setClosingDate:(NSDate *)closingDate {
    _closingDate = closingDate;
    [self countDownLabelUpdate];
    [NSTimer scheduledTimerWithTimeInterval:60 target:self selector:@selector(countDownLabelUpdate) userInfo:nil repeats:YES];
}

- (void)countDownLabelUpdate {
    NSTimeInterval diff = [_closingDate timeIntervalSinceDate:[NSDate date]];
    if (diff < 0) {
        diff = 0;
    }
    int hours = lround(floor(diff / 3600.)) % 100;
    int minutes = lround(floor(diff / 60.)) % 60;
    self.messageLabel.text = [NSString stringWithFormat:@"今応募すると、%d時間%d分以内に\n採用/不採用が決まります。\n 結果発表前ならキャンセルが可能です。",  hours, minutes];
}

- (void)showAlert {
    [self.keyWindow addSubview:self];
    self.transform = CGAffineTransformMakeScale(1.1, 1.1);
    self.alpha = 0;
    [UIView animateWithDuration:.2 animations: ^{
        self.alpha = 1;
        self.transform = CGAffineTransformMakeScale(1, 1);
    }];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self hideAlert];
}
- (IBAction)clickButton:(id)sender {
    [self hideAlert];
}

@end

//
//  QKTipSearchJobView.m
//  quicker-cs-ios
//
//  Created by LongPD-PC on 5/28/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKTipSearchJobView.h"

@implementation QKTipSearchJobView

- (void)awakeFromNib {
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self hide];
}

- (void)show {
    UIWindow *window =[[UIApplication sharedApplication] keyWindow];
    self.frame = window.frame;
    
    [UIView animateWithDuration:0.3
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations: ^{
                         [window addSubview:self];
                     }
                     completion: ^(BOOL finished) {
                     }];
}

- (void)hide {
    [UIView animateWithDuration:0.3
                          delay:0.0
                        options:UIViewAnimationOptionAutoreverse
                     animations: ^{
                         [self removeFromSuperview];
                     }
                     completion: ^(BOOL finished) {
                     }];
}

@end

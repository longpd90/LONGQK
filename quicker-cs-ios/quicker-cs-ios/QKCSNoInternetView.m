//
//  QKNoInternetView.m
//  quicker-cs-ios
//
//  Created by Nguyen Huu Anh on 6/1/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCSNoInternetView.h"

@implementation QKCSNoInternetView

- (instancetype)initWithTarget:(id)target selector:(SEL)action {
    CGRect frame = [UIApplication sharedApplication].keyWindow.frame;
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:245.0 / 255.0
                                               green:250.0 / 255.0
                                                blue:250.0 / 255.0
                                               alpha:1];
        
        float centerX = CGRectGetMidX(frame);
        float centerY = CGRectGetMidY(frame);
        
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(centerX - 50.0, centerY - 100.0, 100.0, 100.0)];
        self.imageView.image = [UIImage imageNamed:@"error_pic_offline_02"];
        
        self.messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(centerX - 80.0, centerY + 20.0, 160.0, 50.0)];
        self.messageLabel.text = @"インターネット接続がオフラインのようです";
        self.messageLabel.textAlignment = NSTextAlignmentCenter;
        self.messageLabel.font = [UIFont systemFontOfSize:13.0];
        self.messageLabel.numberOfLines = 2;
        
        self.retryButton = [[QKGlobalSecondaryButton alloc] initWithFrame:CGRectMake(40.0, CGRectGetMaxY(self.messageLabel.frame) + 30.0, CGRectGetWidth(frame) - 80.0, 35.0)];
        [self.retryButton setTitle:@"もう一度読み込む" forState:UIControlStateNormal];
        [self.retryButton addTarget:target
                             action:action
                   forControlEvents:UIControlEventTouchUpInside];
        [self.retryButton addTarget:self
                             action:@selector(hide)
                   forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:self.imageView];
        [self addSubview:self.messageLabel];
        [self addSubview:self.retryButton];
    }
    return self;
}

- (void)show {
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    [keyWindow addSubview:self];
    self.transform = CGAffineTransformMakeScale(1.1, 1.1);
    self.alpha = 0;
    [UIView animateWithDuration:.2 animations: ^{
        self.alpha = 1;
        self.transform = CGAffineTransformMakeScale(1, 1);
    }];
}

- (void)hide {
    [UIView animateWithDuration:.2 animations: ^{
        self.transform = CGAffineTransformMakeScale(1.1, 1.1);
        self.alpha = 0.0;
    } completion: ^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
        }
    }];
}

@end

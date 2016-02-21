//
//  QKStatusView.m
//  quicker-cl-ios
//
//  Created by Nguyen Huu Anh on 6/16/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKStatusView.h"
#import "QKF40Label.h"

@interface QKStatusView ()

@property (strong, nonatomic) QKF40Label *firstLabel;
@property (strong, nonatomic) QKF40Label *secondLabel;
@property (strong, nonatomic) QKF40Label *lastLabel;
@property (strong, nonatomic) UIImageView *firstImv;
@property (strong, nonatomic) UIImageView *secondImv;
@property (strong, nonatomic) UIImageView *lastImv;
@property (strong, nonatomic) UIView *lineView;

@end

@implementation QKStatusView

- (void)layoutSubviews {
    [super layoutSubviews];
    [self setupInterface];
}

- (void)setupInterface {
    [self drawGrayLine];
    [self setupImageStatusViews];
    [self setupStatusLabels];
}

- (void)drawGrayLine {
    self.lineView = [[UIView alloc] initWithFrame:CGRectMake((CGRectGetWidth(self.frame) - 220.0)/2.0, 31.0, 220.0, 1.0)];
    self.lineView.backgroundColor = [UIColor colorWithHexString:@"#CCCCCC"];
    [self addSubview:self.lineView];
    UIView *bottonLine = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.frame) - 1, CGRectGetWidth(self.frame), 1.0)];
    bottonLine.backgroundColor = [UIColor colorWithHexString:@"#CCCCCC"];
    [self addSubview:bottonLine];
    
}

- (void)setupImageStatusViews {
    int step = self.tag % 10;
    float sizeImv = 10.0;
    
    UIImage *doneImage = [UIImage imageNamed:@"signup_ic_done"];
    UIImage *yetImage = [UIImage imageNamed:@"signup_ic_yet"];
    UIImage *doingImage = [UIImage imageNamed:@"signup_ic_doing"];
    
    self.secondImv = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, sizeImv, sizeImv)];
    self.secondImv.center = self.lineView.center;
    [self addSubview:self.secondImv];
    
    self.firstImv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, sizeImv, sizeImv)];
    self.firstImv.center = CGPointMake(self.secondImv.center.x - CGRectGetWidth(self.lineView.frame)/2, self.secondImv.center.y);
    [self addSubview:self.firstImv];
    
    self.lastImv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, sizeImv, sizeImv)];
    self.lastImv.center = CGPointMake(self.secondImv.center.x + CGRectGetWidth(self.lineView.frame)/2, self.secondImv.center.y);
    [self addSubview:self.lastImv];
    
    switch (step) {
        case 1:
            self.firstImv.image = doingImage;
            self.secondImv.image = yetImage;
            self.lastImv.image = yetImage;
            break;
        case 2:
            self.firstImv.image = doneImage;
            self.secondImv.image = doingImage;
            self.lastImv.image = yetImage;
            break;
        case 3:
            self.firstImv.image = doneImage;
            self.secondImv.image = doneImage;
            self.lastImv.image = doingImage;
            break;
        default:
            break;
    }
}

- (void)setupStatusLabels {
    float witdhLabel = 75.0;
    self.firstLabel = [[QKF40Label alloc] initWithFrame:CGRectMake(0, 13.0, witdhLabel, 14.0)];
    self.secondLabel = [[QKF40Label alloc] initWithFrame:CGRectMake(0, 13.0, witdhLabel, 14.0)];
    self.lastLabel = [[QKF40Label alloc] initWithFrame:CGRectMake(0, 13.0, witdhLabel, 14.0)];
    
    self.firstLabel.center  = CGPointMake(self.firstImv.center.x, self.firstLabel.center.y);
    self.secondLabel.center  = CGPointMake(self.secondImv.center.x, self.secondLabel.center.y);
    self.lastLabel.center  = CGPointMake(self.lastImv.center.x, self.lastLabel.center.y);
    
    self.firstLabel.textAlignment = NSTextAlignmentCenter;
    self.secondLabel.textAlignment = NSTextAlignmentCenter;
    self.lastLabel.textAlignment = NSTextAlignmentCenter;
    
    [self addSubview:self.firstLabel];
    [self addSubview:self.secondLabel];
    [self addSubview: self.lastLabel];
    
    int caseSignup = (int)(self.tag / 10);
    
    switch (caseSignup) {
        case 1:
            self.firstLabel.text = @"店舗情報の入力";
            self.secondLabel.text = @"店舗写真の撮影";
            self.lastLabel.text = @"申請完了";
            break;
        case 2:
            self.firstLabel.text = @"申請完了";
            self.secondLabel.text = @"店舗情報の入力";
            self.lastLabel.text = @"店舗写真の撮影";
            break;
        default:
            break;
    }
}

@end

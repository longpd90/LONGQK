//
//  QKLoadingHUDView.m
//  quicker-cl-ios
//
//  Created by Nguyen Huu Anh on 6/15/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCSBigLoadingView.h"

@interface QKCSBigLoadingView ()

@property (strong, nonatomic) UIWindow *keyWindow;
@property (strong, nonatomic) UIImageView *indicatorImageView;

@end

@implementation QKCSBigLoadingView

- (instancetype)initHUDView {
    _keyWindow = [[UIApplication sharedApplication] keyWindow];
    self = [super initWithFrame:_keyWindow.frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.5];
        self.indicatorImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40.0, 40.0)];
        self.indicatorImageView.center = self.center;
        self.indicatorImageView.backgroundColor = [UIColor clearColor];
        NSMutableArray *imageArray = [[NSMutableArray alloc] init];
        for (int i = 1; i < 33; i++) {
            NSString *imageName = [NSString stringWithFormat:@"common_loader_small_000%d", i];
            if (i > 9) {
                imageName = [NSString stringWithFormat:@"common_loader_small_00%d", i];
            }
            [imageArray addObject:[UIImage imageNamed:imageName]];
        }
        
        self.indicatorImageView.animationImages = imageArray;
        self.indicatorImageView.animationDuration = 1.0;
        [self.indicatorImageView startAnimating];
        [self addSubview:self.indicatorImageView];
    }
    return self;
}

- (void)showIndicator {
    [_keyWindow addSubview:self];
    self.transform = CGAffineTransformMakeScale(1.1, 1.1);
    self.alpha = 0;
    [UIView animateWithDuration:.2 animations: ^{
        self.alpha = 1;
        self.transform = CGAffineTransformMakeScale(1, 1);
    }];
}

- (void)hideIndicator {
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

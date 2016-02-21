//
//  QKNoInternetView.h
//  quicker-cl-ios
//
//  Created by Nguyen Huu Anh on 6/1/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QKGlobalButton.h"

@interface QKCSNoInternetView : UIView

@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UILabel *messageLabel;
@property (strong, nonatomic) QKGlobalButton *retryButton;

- (instancetype)initWithTarget:(id)target selector:(SEL)action;
- (void)show;
- (void)hide;

@end

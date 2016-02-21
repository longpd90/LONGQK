//
//  QKLoadingHUDView.h
//  quicker-cl-ios
//
//  Created by Nguyen Huu Anh on 6/15/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QKCLBigLoadingView : UIView
@property (strong, nonatomic) UIImageView *indicatorImageView;
- (instancetype)initHUDView;
- (void)showIndicator;
- (void)hideIndicator;

@end

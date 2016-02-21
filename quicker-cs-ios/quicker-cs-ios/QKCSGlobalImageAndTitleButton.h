//
//  QKCSGlobalImageAndTitleButton.h
//  quicker-cs-ios
//
//  Created by C Anh on 8/24/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QKGlobalDefines.h"
#import "chiase-ios-core/LocalizedButton.h"
#import "QKConst.h"
#import "chiase-ios-core/UIView+Extra.h"
#import "QKF1Label.h"
#import "QKF51Label.h"
@interface QKCSGlobalImageAndTitleButton : LocalizedButton
@property (strong, nonatomic) UIImage *image;
@property (strong, nonatomic) NSString *title;

@property (strong, nonatomic) UILabel *decriptionTitleLabel;
@property (strong, nonatomic) UIImageView *imageViewButton;

@end

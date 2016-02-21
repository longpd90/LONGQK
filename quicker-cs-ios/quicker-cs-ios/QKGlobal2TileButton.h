//
//  QKGlobal2TileButton.h
//  quicker-cs-ios
//
//  Created by LongPD-PC on 6/19/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QKGlobalDefines.h"
#import "chiase-ios-core/LocalizedButton.h"
#import "QKConst.h"
#import "chiase-ios-core/UIView+Extra.h"
#import "QKF1Label.h"
#import "QKF51Label.h"

@interface QKGlobal2TileButton : LocalizedButton

@property (strong, nonatomic) NSString *bigTile;
@property (strong, nonatomic) NSString *smallTile;
@property (strong, nonatomic) UILabel *bigTitleLabel;
@property (strong, nonatomic) UILabel *smallTitleLabel;

@end

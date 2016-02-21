//
//  QKGlobal2TileButton.h
//  quicker-cs-ios
//
//  Created by LongPD-PC on 6/19/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QKCLGlobalDefines.h"
#import "chiase-ios-core/LocalizedButton.h"
#import "QKCLConst.h"
#import "chiase-ios-core/UIView+Extra.h"
#import "QKF2Label.h"
#import "QKF20Label.h"

@interface QKGlobal2TileButton : LocalizedButton

@property (strong, nonatomic) NSString *bigTile;
@property (strong, nonatomic) NSString *smallTile;
@property (strong, nonatomic) UILabel *bigTitleLabel;
@property (strong, nonatomic) UILabel *smallTitleLabel;

@end

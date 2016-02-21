//
//  QKCSServiceDetailCell.h
//  quicker-cs-ios
//
//  Created by C Anh on 8/26/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QKF33Label.h"
#import "QKF35Label.h"
@interface QKCSServiceDetailCell : UITableViewCell
@property (weak, nonatomic) IBOutlet QKF33Label *titleLabel;
@property (weak, nonatomic) IBOutlet QKF35Label *valueLabel;

@end

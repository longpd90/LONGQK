//
//  QKCLPhoneNumTableViewCell.h
//  quicker-cl-ios
//
//  Created by VietND on 8/24/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QKF12Label.h"

@interface QKCLPhoneNumTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *phoneImageView;
@property (weak, nonatomic) IBOutlet QKF12Label *phoneNumLabel;

@end

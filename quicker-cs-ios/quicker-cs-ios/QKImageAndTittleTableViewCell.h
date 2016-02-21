//
//  QKImageAndTittleTableViewCell.h
//  quicker-cs-ios
//
//  Created by Viet on 6/26/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QKF33Label.h"

@interface QKImageAndTittleTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *qkImageView;
@property (weak, nonatomic) IBOutlet QKF33Label *qkTittleLabel;

@end

//
//  QKCLShowShopImageTableViewCell.h
//  quicker-cl-ios
//
//  Created by VietND on 8/24/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QKImageView.h"
#import "QKF2Label.h"

@interface QKCLShowShopImageTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet QKImageView *mainImageView;
@property (weak, nonatomic) IBOutlet QKImageView *leftSubImageView;
@property (weak, nonatomic) IBOutlet QKImageView *rightSubImageView;
@property (weak, nonatomic) IBOutlet QKF2Label *shopNameLabel;

-(CGFloat)getCellHeight;
@end

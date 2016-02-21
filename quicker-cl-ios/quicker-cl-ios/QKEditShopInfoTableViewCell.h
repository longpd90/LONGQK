//
//  QKEditShopInfoTableViewCell.h
//  quicker-cl-ios
//
//  Created by Quy on 5/14/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QKF2Label.h"
#import "QKImageView.h"
@interface QKEditShopInfoTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet QKF2Label *shopNameLabel;
@property (weak, nonatomic) IBOutlet QKImageView *mainImage;
@property (weak, nonatomic) IBOutlet QKImageView *subLeftImage;
@property (weak, nonatomic) IBOutlet QKImageView *subRightImage;

@property (weak, nonatomic) IBOutlet UIImageView *mainAddPhotoImage;
@property (weak, nonatomic) IBOutlet UIImageView *leftAddPhotoImage;
@property (weak, nonatomic) IBOutlet UIImageView *rightAddPhotoImage;

@property (weak, nonatomic) IBOutlet UIImageView *crossMainImage;
@property (weak, nonatomic) IBOutlet UIImageView *crossLeftImage;
@property (weak, nonatomic) IBOutlet UIImageView *crossRightImage;

@property (weak, nonatomic) IBOutlet UIButton *mainButton;
@property (weak, nonatomic) IBOutlet UIButton *leftButton;
@property (weak, nonatomic) IBOutlet UIButton *rightButton;

-(CGFloat)getCellHeight;
@end

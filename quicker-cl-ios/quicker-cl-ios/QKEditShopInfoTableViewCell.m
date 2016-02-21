//
//  QKEditShopInfoTableViewCell.m
//  quicker-cl-ios
//
//  Created by Quy on 5/14/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKEditShopInfoTableViewCell.h"

@implementation QKEditShopInfoTableViewCell

- (void)awakeFromNib {
    [self.shopNameLabel setPreferredMaxLayoutWidth:self.frame.size.width -20.0f];
    self.mainImage.contentMode= UIViewContentModeScaleAspectFit;
    self.subLeftImage.contentMode= UIViewContentModeScaleAspectFit;
    self.subRightImage.contentMode= UIViewContentModeScaleAspectFit;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
-(CGFloat)getCellHeight {
    [self.shopNameLabel setPreferredMaxLayoutWidth:self.frame.size.width -20.0f];
    [self.shopNameLabel sizeToFit];
    CGFloat height = CGRectGetHeight(self.shopNameLabel.frame);
    height =20.0 + height + 20.0 +(CGRectGetWidth(self.frame) -20)*2/3 +5.0 + (CGRectGetWidth(self.frame) -20.0 - 5.0)/3 + 10.0;
    return height;
}

@end

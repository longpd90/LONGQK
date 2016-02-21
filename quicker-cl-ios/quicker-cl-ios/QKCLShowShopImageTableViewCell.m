//
//  QKCLShowShopImageTableViewCell.m
//  quicker-cl-ios
//
//  Created by VietND on 8/24/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLShowShopImageTableViewCell.h"

@implementation QKCLShowShopImageTableViewCell
- (void)awakeFromNib {
    [super awakeFromNib];
    [self.shopNameLabel setPreferredMaxLayoutWidth:self.frame.size.width -20.0f];
    self.mainImageView.contentMode= UIViewContentModeScaleAspectFit;
    self.leftSubImageView.contentMode= UIViewContentModeScaleAspectFit;
    self.rightSubImageView.contentMode= UIViewContentModeScaleAspectFit;
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

//
//  QKCSFavoriteCell.m
//  quicker-cs-ios
//
//  Created by C Anh on 8/12/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCSImageView.h"
#import "QKCSFavoriteCell.h"
#import "UIImageView+AFNetworking.h"

@implementation QKCSFavoriteCell

- (void)awakeFromNib {
    self.avatarImageView.layer.cornerRadius = self.avatarImageView.frame.size.width/2;
    self.avatarImageView.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setShopModel:(QKRecruitmentModel *)shopModel {
    _shopModel = shopModel;
    self.nameShopLabel.text = shopModel.personInChargeFirstName;
    self.decriptionLabel.text = shopModel.personInChargeFirstName;
    [self.avatarImageView setImageWithQKURL:shopModel.personInChargeImageUrl placeholderImage:[UIImage imageNamed:@"account_pic_blankprofile"] withCache:YES];
    
}
@end

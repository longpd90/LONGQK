//
//  QKShopDescriptionTableViewCell.m
//  quicker-cs-ios
//
//  Created by LongPD-PC on 6/11/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKShopDescriptionTableViewCell.h"

@implementation QKShopDescriptionTableViewCell

- (void)awakeFromNib {
	// Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
	[super setSelected:selected animated:animated];

	// Configure the view for the selected state
}

- (void)setJobEntity:(QKRecruitmentModel *)jobEntity {
	self.shopDescriptionLabel.text = jobEntity.shopInfo.shopDescription;
}

@end

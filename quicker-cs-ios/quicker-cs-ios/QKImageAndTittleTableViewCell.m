//
//  QKImageAndTittleTableViewCell.m
//  quicker-cs-ios
//
//  Created by Viet on 6/26/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKImageAndTittleTableViewCell.h"
#import "chiase-ios-core/UIColor+Extra.h"

@implementation QKImageAndTittleTableViewCell

- (void)awakeFromNib {
	[super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
	[super setSelected:selected animated:animated];

	// Configure the view for the selected state
	if (selected) {
		self.backgroundColor = [UIColor colorWithHexString:@"#F7F7F7"];
	}
	else {
		self.backgroundColor = [UIColor whiteColor];
	}
}

@end

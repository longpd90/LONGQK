//
//  QKJobDescriptionTableViewCell.m
//  quicker-cs-ios
//
//  Created by LongPD-PC on 6/11/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKJobDescriptionTableViewCell.h"

@implementation QKJobDescriptionTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)setJobEntity:(QKRecruitmentModel *)jobEntity {
	[self.personAvatarImageView setImageWithURL:jobEntity.personInChargeImageUrl placeholderImage:[UIImage imageNamed:@"account_pic_blankprofile"]];
    self.personNameLabel.text = @"採用担当者";
	self.jobDescription.text = jobEntity.recruitmentDescription;
	self.apliQualitionLabel.text = jobEntity.applicantqualification;
}

@end

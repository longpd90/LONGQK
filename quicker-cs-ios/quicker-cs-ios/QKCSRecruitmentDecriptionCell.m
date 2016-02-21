//
//  QKCSRecruitmentDecriptionCell.m
//  quicker-cs-ios
//
//  Created by C Anh on 8/19/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCSRecruitmentDecriptionCell.h"
#import "QKCSFreeItemShopModel.h"
@implementation QKCSRecruitmentDecriptionCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setRecruitmentModel:(QKRecruitmentModel *)recruitmentModel {
    [self.personAvatarImageView setImageWithURL:recruitmentModel.personInChargeImageUrl placeholderImage:[UIImage imageNamed:@"account_pic_blankprofile"]];
    self.personNameLabel.text = NSLocalizedString(@"採用担当者", nil);
//    self.jobDecriptionLabel.text = recruitmentModel.shopInfo.shopDescription;
//    self.applicantqualificationLabel.text = recruitmentModel.applicantqualification;
}
- (void)setShopInfoModel:(QKShopInfoModel *)shopInfoModel {
    for ( QKCSFreeItemShopModel *freeItem in self.shopInfoModel.freeItemList)   {
        self.jobDecriptionLabel.text = freeItem.freeItemJobTypeLName;
        self.applicantqualificationLabel.text = freeItem.freeItemJobTypeLValue;
    }
}
@end

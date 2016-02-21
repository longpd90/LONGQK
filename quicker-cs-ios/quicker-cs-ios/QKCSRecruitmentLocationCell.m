//
//  QKCSRecruitmentLocationCell.m
//  quicker-cs-ios
//
//  Created by C Anh on 8/19/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCSRecruitmentLocationCell.h"
#import "UIImageView+AFNetworking.h"

@implementation QKCSRecruitmentLocationCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setRecruitmentModel:(QKRecruitmentModel *)recruitmentModel {
    _recruitmentModel = recruitmentModel;
    self.shopAddressLabel.text = [NSString stringWithFormat:@"%@ %@ %@ %@", recruitmentModel.addressPrfName, recruitmentModel.addressCityName, recruitmentModel.address1, recruitmentModel.address2];
    
    NSString *url = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/staticmap?center=%@&zoom=14&size=512x512&maptype=roadmap\
                     &markers=size:mid|color:red|%@", recruitmentModel.latLng, recruitmentModel.latLng];
    
    [self.mapImageView setImageWithURL:[NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    self.waySide1Label.text = recruitmentModel.shopInfo.wayside1;
    self.waySide2Label.text = recruitmentModel.shopInfo.wayside2;
    self.waySide3Label.text = recruitmentModel.shopInfo.wayside3;
    self.accessWayLabel.text = recruitmentModel.accessWay;
}

@end

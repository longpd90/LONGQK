//
//  QKJobLocationTableViewCell.m
//  quicker-cs-ios
//
//  Created by LongPD-PC on 6/11/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKJobLocationTableViewCell.h"
#import "UIImageView+AFNetworking.h"

@implementation QKJobLocationTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setJobEntity:(QKRecruitmentModel *)jobEntity {
    _jobEntity = jobEntity;
    self.shopAddressLabel.text = [NSString stringWithFormat:@"%@ %@ %@ %@", jobEntity.addressPrfName, jobEntity.addressCityName, jobEntity.address1, jobEntity.address2];
    
     NSString *url = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/staticmap?center=%@&zoom=14&size=512x512&maptype=roadmap\
                                                                                                      &markers=size:mid|color:red|%@", jobEntity.latLng, jobEntity.latLng];
    
    [self.mapImageView setImageWithURL:[NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    self.waySide1Label.text = jobEntity.shopInfo.wayside1;
    self.waySide2Label.text = jobEntity.shopInfo.wayside2;
    self.waySide3Label.text = jobEntity.shopInfo.wayside3;
    self.accessWayLabel.text = jobEntity.accessWay;
}

@end

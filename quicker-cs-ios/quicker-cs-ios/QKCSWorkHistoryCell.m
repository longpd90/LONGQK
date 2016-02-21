//
//  QKCSWorkHistoryCell.m
//  quicker-cs-ios
//
//  Created by C Anh on 8/13/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCSWorkHistoryCell.h"

@implementation QKCSWorkHistoryCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}
- (void)setWorkHistoryModel:(QKCSWorkHistoryModel *)workHistoryModel {
    _workHistoryModel = workHistoryModel;
    self.tranferDateLAbel.text = workHistoryModel.tranferStatus;
    self.addressShopLabel.text = workHistoryModel.addressShop;
    self.serviceLabel.text = workHistoryModel.service;
    self.totalSalary.text = workHistoryModel.totalSalary;
}

- (void)setShopModel:(QKRecruitmentModel *)shopModel {
    _shopModel = shopModel;
    self.tranferDateLAbel.text = shopModel.personInChargeFirstName;
    self.addressShopLabel.text = shopModel.accessWay;
    self.serviceLabel.text = shopModel.personInChargeFirstName;
    self.totalSalary.text = [NSString stringWithFormat:@"%@円", shopModel.salaryTotal];
}

@end

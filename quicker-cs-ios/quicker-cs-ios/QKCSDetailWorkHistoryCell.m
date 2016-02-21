//
//  QKCSDetailWorkHistoryCell.m
//  quicker-cs-ios
//
//  Created by C Anh on 8/19/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCSDetailWorkHistoryCell.h"
#import "chiase-ios-core/UIColor+Extra.h"

@implementation QKCSDetailWorkHistoryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellAccessoryNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    if (selected) {
        [self.cellTableView setBackgroundColor:[UIColor colorWithRed:217.0/255.0 green:217.0/255.0 blue:217.0/255.0 alpha:1]];
    }else {
        [self.cellTableView setBackgroundColor:[UIColor clearColor]];
    }
}
-(void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    [super setHighlighted:highlighted animated:animated];
    if (highlighted) {
        [self.cellTableView setBackgroundColor:[UIColor colorWithRed:217.0/255.0 green:217.0/255.0 blue:217.0/255.0 alpha:1]];
    }else {
        [self.cellTableView setBackgroundColor:[UIColor clearColor]];
    }
}

- (void)setRecruitmentModel:(QKRecruitmentModel *)recruitmentModel {
    _recruitmentModel = recruitmentModel;
    self.tranferDateLabel.text = recruitmentModel.personInChargeFirstName;
    self.addressShop.text = recruitmentModel.accessWay;
    self.serviceLabel.text = recruitmentModel.personInChargeFirstName;
}

@end

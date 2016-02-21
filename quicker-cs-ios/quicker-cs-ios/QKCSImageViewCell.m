//
//  QKCSImageViewCell.m
//  quicker-cs-ios
//
//  Created by C Anh on 8/20/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCSImageViewCell.h"
#import "UIImageView+AFNetworking.h"
@implementation QKCSImageViewCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
    UIColor *labelColor = [UIColor whiteColor];
    self.label1.textColor = labelColor;
    self.label2.textColor = labelColor;
    self.label3.textColor = labelColor;
    [self.imageView1 addSubview:self.viewLabel];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setRecruitmentModel:(QKRecruitmentModel *)recruitmentModel {
    _recruitmentModel = recruitmentModel;
    self.label1.text = recruitmentModel.jobTypeMName;
    self.label2.text = recruitmentModel.shopInfo.name;
    self.label3.text = [NSString stringWithFormat:@"採用実績：%@人", recruitmentModel.adoptionRecord];
    
}
@end

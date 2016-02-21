//
//  QKCareerCell.m
//  quicker-cl-ios
//
//  Created by Nguyen Huu Anh on 7/29/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCareerCell.h"
#import "QKF20Label.h"

@implementation QKCareerCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)setCareerModel:(QKCLCareerModel *)careerModel {
    _careerModel = careerModel;
    self.jobTypeLMNmLabel.text = careerModel.jobTypeLName;
    self.jobTypeSNmLabel.text = [careerModel.jobTypeSNm firstObject];
    self.workCountLabel.text = [NSString stringWithFormat:@"勤務年数:%@年", careerModel.servicePeriod];
    float witdh = [[UIApplication sharedApplication] keyWindow].frame.size.width;
    QKF20Label *label = [[QKF20Label alloc] initWithFrame:CGRectMake(25, 10, witdh - 50, 10.0)];
    label.numberOfLines = 0;
    label.text = careerModel.freeText;
    [label sizeToFit];
    CGRect frame = label.frame;
    frame.size.width = witdh - 50;
    label.frame = frame;
    [self.shkCareerListView addSubview:label];
    self.heightOfCareerListView.constant = CGRectGetHeight(label.frame) + 20.0;
}

@end

//
//  QKRecruitmentStatusJobCell.m
//  quicker-cl-ios
//
//  Created by Nguyen Huu Anh on 7/15/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKRecruitmentStatusJobCell.h"

@implementation QKRecruitmentStatusJobCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)setRecruitmentModel:(QKCLRecruitmentModel *)recruitmentModel {
    _recruitmentModel = recruitmentModel;
    self.jobNameLabel.text = _recruitmentModel.jobTypeSName;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"MM月dd日 HH:mm"];
    NSString *startDate = [dateFormatter stringFromDate:recruitmentModel.startDt];
    [dateFormatter setDateFormat:@"HH:mm"];
    NSString *endDate = [dateFormatter stringFromDate:recruitmentModel.endDt];
    self.dateTimeJobLabel.text = [NSString stringWithFormat:@"%@~%@", startDate, endDate];
    self.adoptionAlreadyLabel.text = [NSString stringWithFormat:@"%d", recruitmentModel.adoptionList.count];
    self.remainPeopleLabel.text = [NSString stringWithFormat:@"(残り%d名)", recruitmentModel.employmentNum - recruitmentModel.adoptionList.count];
}

@end

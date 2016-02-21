//
//  QKRecruitmentQuestionTableViewCell.m
//  quicker-cl-ios
//
//  Created by Quy on 7/21/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKRecruitmentQuestionTableViewCell.h"

@implementation QKRecruitmentQuestionTableViewCell

- (void)awakeFromNib {
    [self setupQuestion];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setupQuestion{
    [self.questionLabel setNumberOfLines:0];
}
@end

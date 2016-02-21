//
//  QKSHKCareerCell.m
//  quicker-cl-ios
//
//  Created by Nguyen Huu Anh on 7/29/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKSHKCareerCell.h"

@implementation QKSHKCareerCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setupInterfaceWith:(QKCLShkCareerCategoryModel *)categoryModel andCareerList:(NSArray *)careerList {
    _categoryModel = categoryModel;
    _shkCareerList = careerList;
    self.jobTypeLMNmLabel.text = categoryModel.jobTypeLMNm;
    self.jobTypeSNmLabel.text = categoryModel.jobTypeSNm;
    self.workCountLabel.text = [NSString stringWithFormat:@"勤務回数:%d回", categoryModel.workCount];
    [self getListCareer];
    
    float x = 25.0;
    float y = 10.0;
    
    for (NSString *shopNm in self.careerListInCategory) {
        QKF20Label *shopNmLabel = [[QKF20Label alloc] initWithFrame:CGRectMake(x, y, 300.0, 12.0)];
        [self.shkCareerListView addSubview:shopNmLabel];
        shopNmLabel.text = shopNm;
        y += 22.0;
    }
    self.heightOfCareerListView.constant = y;
}

- (void)getListCareer {
    self.careerListInCategory = [[NSMutableArray alloc] init];
    for (QKCLShkCareerModel *career in self.shkCareerList) {
        if ([career.jobTypeSCd isEqualToString:_categoryModel.jobTypeSCd] &&
            [career.jobTypeLCd isEqualToString:_categoryModel.jobTypeLCd] &&
            [career.jobTypeMCd isEqualToString:_categoryModel.jobTypeMCd]) {
            [self.careerListInCategory addObject:career.shopNm];
        }
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end

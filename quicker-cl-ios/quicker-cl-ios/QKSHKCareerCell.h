//
//  QKSHKCareerCell.h
//  quicker-cl-ios
//
//  Created by Nguyen Huu Anh on 7/29/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QKCLShkCareerCategoryModel.h"
#import "QKCLShkCareerModel.h"
#import "QKF20Label.h"

@interface QKSHKCareerCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *jobTypeLMNmLabel;
@property (weak, nonatomic) IBOutlet UILabel *jobTypeSNmLabel;
@property (weak, nonatomic) IBOutlet UILabel *workCountLabel;
@property (weak, nonatomic) IBOutlet UIView *shkCareerListView;
@property (weak, nonatomic) IBOutlet UIImageView *iconAccordionImv;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightOfCareerListView;

@property (strong, nonatomic) QKCLShkCareerCategoryModel *categoryModel;
@property (strong, nonatomic) NSArray *shkCareerList;
@property (strong, nonatomic) NSMutableArray *careerListInCategory;

- (void)setupInterfaceWith:(QKCLShkCareerCategoryModel *)categoryModel andCareerList:(NSArray *)careerList;

@end

//
//  QKCareerCell.h
//  quicker-cl-ios
//
//  Created by Nguyen Huu Anh on 7/29/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QKCLCareerModel.h"

@interface QKCareerCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *jobTypeLMNmLabel;
@property (weak, nonatomic) IBOutlet UILabel *jobTypeSNmLabel;
@property (weak, nonatomic) IBOutlet UILabel *workCountLabel;
@property (weak, nonatomic) IBOutlet UIView *shkCareerListView;
@property (weak, nonatomic) IBOutlet UIImageView *iconAccordionImv;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightOfCareerListView;

@property (strong, nonatomic) QKCLCareerModel *careerModel;

@end

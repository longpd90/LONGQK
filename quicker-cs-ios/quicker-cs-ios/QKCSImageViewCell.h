//
//  QKCSImageViewCell.h
//  quicker-cs-ios
//
//  Created by C Anh on 8/20/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QKF1Label.h"
#import "QKF58Label.h"
#import "QKRecruitmentModel.h"
@interface QKCSImageViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageView1;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;
@property (weak, nonatomic) IBOutlet UIView *viewLabel;

@property (strong, nonatomic) QKRecruitmentModel *recruitmentModel;
@end

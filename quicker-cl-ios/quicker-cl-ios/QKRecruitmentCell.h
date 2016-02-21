//
//  QKRecruitmentCell.h
//  quicker-cl-ios
//
//  Created by Nguyen Huu Anh on 6/25/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "QKF53Label.h"

@interface QKRecruitmentCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *accountAvatar;
@property (weak, nonatomic) IBOutlet UITextView *recruitmentDesTextView;
@property (weak, nonatomic) IBOutlet UITextView *applicantQualificationTextView;
@property (weak, nonatomic) IBOutlet UIImageView *personInChangeImageView;
@property (weak, nonatomic) IBOutlet UILabel *personInChargeNameLabel;

@end

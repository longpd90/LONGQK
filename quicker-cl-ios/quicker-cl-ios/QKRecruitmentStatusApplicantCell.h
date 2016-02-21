//
//  QKRecruitmentStatusApplicantCell.h
//  quicker-cl-ios
//
//  Created by Nguyen Huu Anh on 7/15/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QKRecruitmentStatusApplicantCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *applicantImageView;
@property (weak, nonatomic) IBOutlet UILabel *applicantNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *applicantAgeAndGenderLabel;
@property (weak, nonatomic) IBOutlet UIImageView *favoriteImageView;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;

@end

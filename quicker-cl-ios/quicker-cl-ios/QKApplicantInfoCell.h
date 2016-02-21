//
//  QKApplicantInfoCell.h
//  quicker-cl-ios
//
//  Created by Nguyen Huu Anh on 7/24/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QKImageView.h"

@interface QKApplicantInfoCell : UITableViewCell
@property (weak, nonatomic) IBOutlet QKImageView *applicantImageView;

@property (weak, nonatomic) IBOutlet UIImageView *favoriteImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameApplicant;
@property (weak, nonatomic) IBOutlet UILabel *ageAndGenderLabel;


@end

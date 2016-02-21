//
//  QKCSRecruitmentLocationCell.h
//  quicker-cs-ios
//
//  Created by C Anh on 8/19/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QKF33Label.h"
#import "QKRecruitmentModel.h"
@interface QKCSRecruitmentLocationCell : UITableViewCell
@property (weak, nonatomic) IBOutlet QKF33Label *shopAddressLabel;
@property (weak, nonatomic) IBOutlet UIImageView *mapImageView;
@property (weak, nonatomic) IBOutlet QKF33Label *waySide1Label;
@property (weak, nonatomic) IBOutlet QKF33Label *waySide2Label;
@property (weak, nonatomic) IBOutlet QKF33Label *waySide3Label;
@property (weak, nonatomic) IBOutlet QKF33Label *accessWayLabel;

@property (strong, nonatomic) QKRecruitmentModel *recruitmentModel;
@end

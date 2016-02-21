//
//  QKJobLocationTableViewCell.h
//  quicker-cs-ios
//
//  Created by LongPD-PC on 6/11/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QKRecruitmentModel.h"
#import "QKF33Label.h"

@interface QKJobLocationTableViewCell : UITableViewCell
@property (strong, nonatomic) QKRecruitmentModel *jobEntity;
@property (weak, nonatomic) IBOutlet UILabel *shopAddressLabel;
@property (weak, nonatomic) IBOutlet UIImageView *mapImageView;
@property (weak, nonatomic) IBOutlet UILabel *accessWayLabel;
@property (weak, nonatomic) IBOutlet QKF33Label *waySide1Label;
@property (weak, nonatomic) IBOutlet QKF33Label *waySide2Label;
@property (weak, nonatomic) IBOutlet QKF33Label *waySide3Label;

@end

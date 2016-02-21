//
//  QKCSRecruitmentDecriptionCell.h
//  quicker-cs-ios
//
//  Created by C Anh on 8/19/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QKRecruitmentModel.h"
#import "UIImageView+AFNetworking.h"
#import "QKF33Label.h"
#import "QKF53Label.h"
#import "QKShopInfoModel.h"
@interface QKCSRecruitmentDecriptionCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *jobDecriptionLabel;
@property (weak, nonatomic) IBOutlet UIImageView *personAvatarImageView;
@property (weak, nonatomic) IBOutlet QKF53Label *personNameLabel;
@property (weak, nonatomic) IBOutlet QKF33Label *applicantqualificationLabel;

@property (strong, nonatomic) QKShopInfoModel *shopInfoModel;
@property (strong, nonatomic) QKRecruitmentModel *recruitmentModel;
@end

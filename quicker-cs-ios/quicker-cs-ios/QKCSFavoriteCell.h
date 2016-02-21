//
//  QKCSFavoriteCell.h
//  quicker-cs-ios
//
//  Created by C Anh on 8/12/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QKF42Label.h"
#import "QKF53Label.h"
#import "QKShopInfoModel.h"
#import "QKRecruitmentModel.h"
@interface QKCSFavoriteCell : UITableViewCell
@property (weak, nonatomic) IBOutlet QKCSImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet QKF42Label *nameShopLabel;
@property (weak, nonatomic) IBOutlet QKF53Label *decriptionLabel;

@property (strong, nonatomic) QKRecruitmentModel *shopModel;

@end

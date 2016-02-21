//
//  QKJobDescriptionTableViewCell.h
//  quicker-cs-ios
//
//  Created by LongPD-PC on 6/11/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QKRecruitmentModel.h"
#import "UIImageView+AFNetworking.h"

@interface QKJobDescriptionTableViewCell : UITableViewCell
@property (strong, nonatomic) QKRecruitmentModel *jobEntity;
@property (weak, nonatomic) IBOutlet UILabel *jobDescription;
@property (weak, nonatomic) IBOutlet UILabel *personNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *personAvatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *apliQualitionLabel;

@end

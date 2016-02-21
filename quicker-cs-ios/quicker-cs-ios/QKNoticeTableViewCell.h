//
//  QKNoticeTableViewCell.h
//  quicker-cs-ios
//
//  Created by Nguyen Huu Anh on 5/11/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QKCSNoticeModel.h"
#import "UIImageView+AFNetworking.h"

@interface QKNoticeTableViewCell : UITableViewCell
@property (strong, nonatomic) QKCSNoticeModel *noticeEntity;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UIView *statusIconView;
@property (weak, nonatomic) IBOutlet UIImageView *loadMoreImageView;



@end

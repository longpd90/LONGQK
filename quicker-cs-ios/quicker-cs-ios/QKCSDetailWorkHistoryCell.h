//
//  QKCSDetailWorkHistoryCell.h
//  quicker-cs-ios
//
//  Created by C Anh on 8/19/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QKRecruitmentModel.h"
#import "QKGlobalSecondaryButton.h"
#import "QKF33Label.h"
#import "QKF58Label.h"

@interface QKCSDetailWorkHistoryCell : UITableViewCell
@property (weak, nonatomic) IBOutlet QKGlobalSecondaryButton *favoriteButton;
@property (weak, nonatomic) IBOutlet UIView *cellTableView;
@property (weak, nonatomic) IBOutlet QKF33Label *addressShop;
@property (weak, nonatomic) IBOutlet QKF58Label *serviceLabel;
@property (weak, nonatomic) IBOutlet QKF33Label *tranferDateLabel;

@property (weak, nonatomic) IBOutlet UIView *buttonView;

@property (weak, nonatomic) IBOutlet UIView *allView;
@property (strong, nonatomic) QKRecruitmentModel *recruitmentModel;
@end

//
//  QKCalendarTableViewCell.h
//  quicker-cs-ios
//
//  Created by LongPD-PC on 6/4/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSDate+Extra.h"
#import "QKGlobalDefines.h"
#import "QKConst.h"

@interface QKCalendarTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *labelText;
@property (weak, nonatomic) IBOutlet UILabel *weekDayName;
@property (weak, nonatomic) IBOutlet UIView *backGroundView;
@property (strong, nonatomic) NSDate *dateInput;
@property (weak, nonatomic) IBOutlet UILabel *todayLabel;
@property (assign, nonatomic) BOOL haveRecruitment;
- (void)deselectedCell ;

@end

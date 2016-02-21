//
//  QKCLWorkerTimeTableViewCell.h
//  quicker-cl-ios
//
//  Created by Quy on 8/11/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QKGlobalTextButton.h"
@interface QKCLWorkerTimeTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *totalTime;
@property (weak, nonatomic) IBOutlet QKGlobalTextButton *startTimeOutletButton;
@property (weak, nonatomic) IBOutlet QKGlobalTextButton *endTimeOutletButton;
@property (weak, nonatomic) IBOutlet QKGlobalTextButton *breakeTimeOutletButton;

@end

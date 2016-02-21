//
//  QKMessageAlertTableViewCell.h
//  quicker-cl-ios
//
//  Created by Viet on 7/7/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QKCSMessageModel.h"

@interface QKCSMessageAlertTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet UILabel *subMessageLabel;

- (void)setData:(QKCSMessageModel *)model;
@end

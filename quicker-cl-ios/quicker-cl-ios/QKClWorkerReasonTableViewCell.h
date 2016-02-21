//
//  QKClWorkerReasonTableViewCell.h
//  quicker-cl-ios
//
//  Created by Quy on 8/17/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QKImageView.h"
#import "QKGlobalNoBorderTextField.h"
@interface QKClWorkerReasonTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet QKImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *reasonLabel;
@property (weak, nonatomic) IBOutlet QKGlobalNoBorderTextField *reasonTextField;

@end

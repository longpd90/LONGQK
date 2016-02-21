//
//  QKCLApplicantTableViewCell.h
//  quicker-cl-ios
//
//  Created by Quy on 7/31/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QKImageView.h"
@interface QKCLApplicantTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet QKImageView *avartarImageView;
@property (weak, nonatomic) IBOutlet UILabel *workerName;
@property (weak, nonatomic) IBOutlet UILabel *workerAge;
@property (weak, nonatomic) IBOutlet QKImageView *ratingWorkerIcon;
@property (weak, nonatomic) IBOutlet UILabel *hiddenWorkerLabel;

@end

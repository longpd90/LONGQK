//
//  QKCloseViewController.h
//  quicker-cl-ios
//
//  Created by Vietnd on 6/13/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLBaseViewController.h"
#import "QKCLConst.h"
#import "QKF2Label.h"

@interface QKCLCloseViewController : QKCLBaseViewController
@property (nonatomic) QKType type;
@property (nonatomic) QKStoreImageTye state;
@property (weak, nonatomic) IBOutlet QKF2Label *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *slideMenuButtonOutlet;

@end

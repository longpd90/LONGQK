//
//  QKStopViewController.h
//  quicker-cl-ios
//
//  Created by Vietnd on 6/13/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCSBaseViewController.h"
#import "QKConst.h"

@interface QKCSStopViewController : QKCSBaseViewController <CCAlertViewDelegate>
@property (nonatomic) QKType type;
- (IBAction)callCenterClicked:(id)sender;
@end

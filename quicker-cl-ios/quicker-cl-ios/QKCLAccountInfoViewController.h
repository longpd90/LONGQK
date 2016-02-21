//
//  QKAccountInfoViewController.h
//  quicker-cl-ios
//
//  Created by LongPD-PC on 4/21/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLBaseTableViewController.h"
#import "QKCLAccountCameraHintViewController.h"

@interface QKCLAccountInfoViewController : QKCLBaseTableViewController <UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, CCAlertViewDelegate>

enum AccountInfomation {
    kFirstNames = 0,
    kLastNames,
    kFirstNameKanas,
    kLastNameKanas,
    kMails,
    kCounts
};

@end

//
//  QKEditAccountInfoViewController.h
//  quicker-cl-ios
//
//  Created by Nguyen Huu Anh on 5/27/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLBaseViewController.h"
#import "QKCLProfileDetailModel.h"
#import "QKImageView.h"
enum AccountInfo {
    kLastName= 0,
    kFirstName,
    kLastNameKana,
    kFirstNameKana,
    kMail,
    kPassword,
    kCount
};

@interface QKCLEditAccountInfoViewController : QKCLBaseViewController
@property (weak, nonatomic) IBOutlet UITableView *accountTableView;
@property (weak, nonatomic) IBOutlet UIButton *buttonAvata;
@property (strong, nonatomic) QKCLProfileDetailModel *profileDetail;
@property (weak, nonatomic) IBOutlet QKImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UIImageView *editImageView;
@property (nonatomic,strong)NSString *thisPassWord;
- (IBAction)avatarButtonClicked:(id)sender;
- (IBAction)btnDeleteClick:(id)sender;
@end

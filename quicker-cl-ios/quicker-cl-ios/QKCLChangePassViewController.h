//
//  QKChangePassViewController.h
//  quicker-cl-ios
//
//  Created by Viet on 6/17/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//


#import "QKCLBaseViewController.h"

#import "QKTextFieldTableViewCell.h"
@interface QKCLChangePassViewController : QKCLBaseViewController <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topContraintButton;
@property (weak, nonatomic) IBOutlet QKGlobalButton *changPassButton;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)changPassButtonClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *warningLabel;
@property (strong, nonatomic) QKGlobalTextField *oldPassWord;

@property (strong, nonatomic) QKGlobalTextField *theNewPassWord;

@property (strong, nonatomic) QKGlobalTextField *confirmPassWord;
@end

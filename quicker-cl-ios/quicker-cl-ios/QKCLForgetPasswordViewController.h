//
//  QKForgetPasswordViewController.h
//  quicker-cl-ios
//
//  Created by LongPD-PC on 5/4/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLBaseViewController.h"

@interface QKCLForgetPasswordViewController : QKCLBaseViewController <UITableViewDataSource, UITableViewDelegate, CCAlertViewDelegate>

@property (weak, nonatomic) QKGlobalTextField *emailTextField;
@property (weak, nonatomic) QKGlobalTextField *firstNameTextField;
@property (weak, nonatomic) QKGlobalTextField *lastNameTextField;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet QKGlobalButton *sendButton;

- (IBAction)btnSendClick:(id)sender;

@end

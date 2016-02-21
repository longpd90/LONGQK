//
//  QKChangeMailViewController.h
//  quicker-cl-ios
//
//  Created by LongPD-PC on 4/21/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLBaseViewController.h"
#import "QKGlobalErrorLabel.h"
@interface QKCLChangeMailViewController : QKCLBaseViewController <CCAlertViewDelegate, UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic)  QKGlobalTextField *firstName;
@property (strong, nonatomic)  QKGlobalTextField *lastName;
@property (strong, nonatomic) QKGlobalTextField *changeMailTextField;
@property (strong, nonatomic)  QKGlobalTextField *passwordTextField;
@property (weak, nonatomic) IBOutlet QKGlobalButton *changeMailButton;
- (IBAction)changeMailFinish:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *warningLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

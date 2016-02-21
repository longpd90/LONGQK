//
//  QKJobListViewController.h
//  quicker-cs-ios
//
//  Created by LongPD-PC on 5/11/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCSBaseViewController.h"

@interface QKJobListViewController : QKCSBaseViewController
@property (weak, nonatomic) IBOutlet UIButton *dismissButton;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
- (IBAction)dismissButtonClicked:(id)sender;
- (IBAction)signupButtonClicked:(id)sender;

@end

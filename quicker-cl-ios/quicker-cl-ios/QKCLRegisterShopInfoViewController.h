//
//  QKAccountJudgeViewController.h
//  quicker-cl-ios
//
//  Created by Viet on 4/15/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "QKCLBaseTableViewController.h"
#import "QKGlobalButton.h"
#import "QKGlobalMinButton.h"
#import "QKCLShopInfoModel.h"

@interface QKCLRegisterShopInfoViewController : QKCLBaseTableViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet QKGlobalButton *nextButton;
@property (strong, nonatomic) QKGlobalMinButton *btnSearch;

@property (nonatomic) BOOL isPresented;
- (IBAction)goToConfirmScreenClicked:(id)sender;


//param
@property (strong, nonatomic)    QKCLShopInfoModel *shopInfoModel;
@end

//
//  QKBankTransferMethodViewController.h
//  quicker-cl-ios
//
//  Created by Nguyen Huu Anh on 5/5/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLBaseViewController.h"

@interface QKCLPaymentMethodViewController : QKCLBaseViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet QKCLTableView *tableView;
@property (weak, nonatomic) IBOutlet UITextView *noteView;

//param
@property (strong,nonatomic) NSString*paymentSystemTypeCd;
@property (strong,nonatomic) NSString*paymentSystemTypeName;
@property (strong,nonatomic) NSString*paymentAddress;
@end

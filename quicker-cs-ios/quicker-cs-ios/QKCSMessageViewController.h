//
//  QKMessageViewController.h
//  quicker-cl-ios
//
//  Created by Viet on 7/6/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCSBaseViewController.h"
#import "QKGlobalTextView.h"

@interface QKCSMessageViewController : QKCSBaseViewController <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *toolbar;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraint;

@property (weak, nonatomic) IBOutlet QKGlobalTextView *textView;
@property (weak, nonatomic) IBOutlet QKGlobalSecondaryButton *sendButton;
- (IBAction)sendButtonClicked:(id)sender;


//Params
@property (strong, nonatomic) NSString *recruimentId;
@property (strong, nonatomic) NSString *qaId;
@property (strong, nonatomic) NSString *autoroadCd;
@property (nonatomic) NSInteger totalNum;

@end

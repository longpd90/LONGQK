//
//  QKMessageViewController.m
//  quicker-cl-ios
//
//  Created by Viet on 7/6/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLMessageViewController.h"
#import "QKCLMessageModel.h"
#import "QKCLMessageAlertTableViewCell.h"
#import "QKCLMessageAutoTableViewCell.h"
#import "QKCLMessageDateTableViewCell.h"
#import "QKCLMessageOutGoingTableViewCell.h"
#import "QKCLMessageIncomingTableViewCell.h"
#import "chiase-ios-core/CCKeyboardHandler.h"
#import "AppDelegate.h"

@interface QKCLMessageViewController () <
CCKeyboardHandlerDelegate, UITextViewDelegate, UIGestureRecognizerDelegate>
@property (strong, nonatomic)
NSMutableArray *messageArrays; // arrays of QKMessageModel
@property (strong, nonatomic) NSDateFormatter *dateFormatter;
@property (strong, nonatomic) CCKeyboardHandler *keyboardHandler;
@property (strong, nonatomic) UIRefreshControl *refreshControl;
@property (strong, nonatomic) NSTimer *timer;
@property (nonatomic) BOOL isLoading;
@property (nonatomic) BOOL isScrollToBottom;

@end

static NSString *messageAlertCell = @"QKMessageAlertCell";
static NSString *messageAutoCell = @"QKMessageAutoCell";
static NSString *messageDateCell = @"QKMessageDateCell";
static NSString *messageOutGoingCell = @"QKMessageOutGoingCell";
static NSString *messageIncomingCell = @"QKMessageIncomingCell";

@implementation QKCLMessageViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // custom back on navigation
    [self setAngleLeftBarButton];
    
    // get message list
    _messageArrays = [[NSMutableArray alloc] init];
    _autoroadCd = @"";
    _dateFormatter = [[NSDateFormatter alloc] init];
    
    
    // keyboard
    _keyboardHandler = [[CCKeyboardHandler alloc] init];
    _keyboardHandler.delegate = self;
    
    // tapGestureRecognizer
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc]
                                                    initWithTarget:self
                                                    action:@selector(dismissKeyboard:)];
    tapGestureRecognizer.delegate = self;
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
    // toolbar
    _toolbar.layer.borderWidth = 1.0f;
    _toolbar.layer.borderColor = [UIColor colorWithHexString:@"#CCCCCC"].CGColor;
    _textView.layer.borderWidth = 1.0f;
    _textView.layer.borderColor = [UIColor colorWithHexString:@"#CCCCCC"].CGColor;
    _textView.layer.cornerRadius = 3.0f;
    _textView.font = [UIFont systemFontOfSize:12.0f];
    _textView.delegate = self;
    _textView.textContainerInset = UIEdgeInsetsMake(10, 0, 10, 0);
    [_textView setPlaceholder:NSLocalizedString(@"メッセージを入力", nil)];
    
    // send Button
    [_sendButton setEnabled:NO];
    
    // refresh
    _refreshControl = [[UIRefreshControl alloc] init];
    [_refreshControl addTarget:self
                        action:@selector(getOlderMessageList)
              forControlEvents:UIControlEventValueChanged];
    //[self.tableView addSubview:_refreshControl];
    
    //timer
    _timer = [NSTimer scheduledTimerWithTimeInterval:10.0 target:self selector:@selector(timerFired:) userInfo:nil repeats:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _isScrollToBottom = YES;
    _isLoading = YES;
    [self getMessageList];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self scrollToBottom];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [QKCLAccessUserDefaults setShowAutoMessage:@"1"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - API
- (void)getMessageList {
    if ([self connected]) {
        NSMutableDictionary *params = [NSMutableDictionary initWithApiKeyAndToken];
        [params setObject:[QKCLAccessUserDefaults getUserId] forKey:@"userId"];
        [params setObject:_recruimentId forKey:@"recruitmentId"];
        [params setObject:[QKCLEncryptUtil encyptBlowfish:_customerUserId] forKey:@"customerUserId"];
        [params setObject:@"" forKey:@"autoroadCd"];
        [params setObject:[NSString stringFromConst:QK_READ_FLG_DONE] forKey:@"notRead"];
        
        [[QKCLRequestManager sharedManager]
         asyncGET:[NSString stringFromConst:qkUrlMessageList]
         parameters:params showLoading:_isLoading showError:YES
         success: ^(AFHTTPRequestOperation *operation, id responseObject) {
             if ([responseObject[QK_API_STATUS_CODE] isEqualToString:[NSString stringFromConst:QK_STT_CODE_SUCCESS]]) {
                 _totalNum = [responseObject intForKey:@"totalNum"];
                 NSString*customerLastName = [responseObject stringForKey:@"customerUserLastName"];
                 NSString*customerFirstName = [responseObject stringForKey:@"customerUserFirstName"];
                 self.navigationItem.title = [NSString stringWithFormat:@"%@ %@",customerLastName,customerFirstName];
                 //_autoroadCd = [responseObject stringForKey:@"autoroadCd"];
                 NSMutableArray *tmp  = [[NSMutableArray alloc]init];
                 // get message list
                 NSArray *messageList = responseObject[@"messageList"];
                 NSArray *reversedArray = [[messageList reverseObjectEnumerator] allObjects];
                 for (NSDictionary *dic in reversedArray) {
                     QKCLMessageModel *model = [[QKCLMessageModel alloc] initWithResponse:dic];
                     if (tmp.count == 0) {
                         QKCLMessageModel *dateModel = [[QKCLMessageModel alloc] init];
                         dateModel.isDate = YES;
                         dateModel.createDt = model.createDt;
                         [tmp addObject:dateModel];
                     }
                     else {
                         [_dateFormatter setDateFormat:@"yyyy-MM-dd"];
                         NSString *newDate = [_dateFormatter stringFromDate:model.createDt];
                         QKCLMessageModel *lastMessage = (QKCLMessageModel *)[tmp lastObject];
                         NSString *oldDate = [_dateFormatter stringFromDate:lastMessage.createDt];
                         if (![newDate isEqualToString:oldDate]) {
                             QKCLMessageModel *dateModel = [[QKCLMessageModel alloc] init];
                             dateModel.isDate = YES;
                             dateModel.createDt = model.createDt;
                             [tmp addObject:dateModel];
                         }
                     }
                     
                     [tmp addObject:model];
                 }
                 
                 //add date label
                 if (tmp.count == 0) {
                     QKCLMessageModel *dateModel = [[QKCLMessageModel alloc] init];
                     dateModel.isDate = YES;
                     dateModel.createDt = [NSDate date];
                     [tmp addObject:dateModel];
                 }
                 
                 //add automessage
                 if ([[QKCLAccessUserDefaults getShowAutoMessage] isEqualToString:@""]) {
                     QKCLMessageModel *autoModel = [[QKCLMessageModel alloc] init];
                     autoModel.isDate = NO;
                     autoModel.messageType = [NSString stringFromConst:QK_MESSAGE_TYPE_AUTO];
                     
                     NSMutableArray *tmpArrays = [NSMutableArray arrayWithObject:tmp[0]];
                     [tmpArrays addObject:autoModel];
                     [tmp removeObjectAtIndex:0];
                     [tmpArrays addObjectsFromArray:tmp];
                     tmp = tmpArrays;
                     tmpArrays = nil;
                 }
                 
                 _messageArrays = tmp;
                 tmp =nil;
                 
                 //reload tableView
                 [self.tableView reloadData];
                 
                 if (_isScrollToBottom) {
                     [self scrollToBottom];
                 }
             }
             else {
                 [self stopTimer];
             }
         }
         failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"Error:%@", error);
         }];
    }
    else {
        [self showNoInternetViewWithSelector:@selector(getMessageList)];
    }
}

- (void)getOlderMessageList {
    if ([self connected]) {
        NSMutableDictionary *params = [NSMutableDictionary initWithApiKeyAndToken];
        [params setObject:[QKCLAccessUserDefaults getUserId] forKey:@"userId"];
        [params setObject:_recruimentId forKey:@"recruitmentId"];
        [params setObject:_customerUserId forKey:@"customerUserId"];
        [params setObject:_autoroadCd forKey:@"autoroadCd"];
        [params setObject:@"1" forKey:@"notRead"];
        
        [[QKCLRequestManager sharedManager]
         asyncGET:[NSString stringFromConst:qkUrlMessageList]
         parameters:params showLoading:YES showError:YES
         success: ^(AFHTTPRequestOperation *operation, id responseObject) {
             if ([responseObject[QK_API_STATUS_CODE]
                  isEqualToString:[NSString
                                   stringFromConst:QK_STT_CODE_SUCCESS]]) {
                      _autoroadCd = [responseObject stringForKey:@"autoroadCd"];
                      
                      // get message list
                      NSMutableArray *olderMessageArrays = [[NSMutableArray alloc] init];
                      for (NSDictionary *dic in responseObject[@"messageList"]) {
                          QKCLMessageModel *model = [[QKCLMessageModel alloc] initWithResponse:dic];
                          if (olderMessageArrays.count == 0) {
                              QKCLMessageModel *dateModel = [[QKCLMessageModel alloc] init];
                              dateModel.isDate = YES;
                              dateModel.createDt = model.createDt;
                              [olderMessageArrays addObject:dateModel];
                          }
                          else {
                              [_dateFormatter setDateFormat:@"yyyy-MM-dd"];
                              NSString *newDate = [_dateFormatter stringFromDate:model.createDt];
                              QKCLMessageModel *lastMessage = (QKCLMessageModel *)[olderMessageArrays lastObject];
                              NSString *oldDate = [_dateFormatter stringFromDate:lastMessage.createDt];
                              if (![newDate isEqualToString:oldDate]) {
                                  QKCLMessageModel *dateModel = [[QKCLMessageModel alloc] init];
                                  dateModel.isDate = YES;
                                  dateModel.createDt = model.createDt;
                                  [olderMessageArrays addObject:dateModel];
                              }
                          }
                          
                          [olderMessageArrays addObject:model];
                      }
                      
                      //add to messagearrays
                      if (olderMessageArrays.count > 0 && _messageArrays.count > 0) {
                          QKCLMessageModel *oldLastMessage = [olderMessageArrays lastObject];
                          [_dateFormatter setDateFormat:@"yyyy-MM-dd"];
                          NSString *oldDate = [_dateFormatter stringFromDate:oldLastMessage.createDt];
                          
                          QKCLMessageModel *firstMessage = [_messageArrays firstObject];
                          [_dateFormatter setDateFormat:@"yyyy-MM-dd"];
                          NSString *firstDate = [_dateFormatter stringFromDate:firstMessage.createDt];
                          
                          if ([oldDate isEqualToString:firstDate]) {
                              [_messageArrays removeObject:firstMessage];
                          }
                      }
                      [olderMessageArrays addObjectsFromArray:_messageArrays];
                      _messageArrays = olderMessageArrays;
                      [self.tableView reloadData];
                  }
             else {
                 [_refreshControl endRefreshing];
             }
         }
         failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"Error:%@", error);
             [_refreshControl endRefreshing];
         }];
    }
    else {
        [self showNoInternetViewWithSelector:@selector(getOlderMessageList)];
    }
}

#pragma mark - TableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)   tableView:(UITableView *)tableView
    numberOfRowsInSection:(NSInteger)section {
    return [_messageArrays count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QKCLMessageModel *model = [_messageArrays objectAtIndex:indexPath.row];
    if (model.isDate) {
        // Show date
        QKCLMessageDateTableViewCell *cell = (QKCLMessageDateTableViewCell *)
        [tableView dequeueReusableCellWithIdentifier:messageDateCell
		                                      forIndexPath:indexPath];
        if (cell == nil) {
            cell = [[QKCLMessageDateTableViewCell alloc]
                    initWithStyle:UITableViewCellStyleDefault
                    reuseIdentifier :messageDateCell];
        }
        [_dateFormatter setDateFormat:@"MM月dd日"];
        cell.dateLabel.text = [_dateFormatter stringFromDate:model.createDt];
        return cell;
    }
    else {
        //auto alert
        if ([model.messageType
             isEqualToString:[NSString stringFromConst:QK_MESSAGE_TYPE_AUTO]]) {
            QKCLMessageAutoTableViewCell *cell = (QKCLMessageAutoTableViewCell *)
            [tableView dequeueReusableCellWithIdentifier:messageAutoCell
                                            forIndexPath:indexPath];
            if (cell == nil) {
                cell = [[QKCLMessageAutoTableViewCell alloc]
                        initWithStyle:UITableViewCellStyleDefault
                        reuseIdentifier :messageAutoCell];
            }
            [cell setData:model];
            return cell;
        }
        else if ([model.messageType
                  isEqualToString:
                  [NSString stringFromConst:QK_MESSAGE_TYPE_ALERT]]) {
            QKCLMessageAlertTableViewCell *cell = (QKCLMessageAlertTableViewCell *)
            [tableView dequeueReusableCellWithIdentifier:messageAlertCell
                                            forIndexPath:indexPath];
            if (cell == nil) {
                cell = [[QKCLMessageAlertTableViewCell alloc]
                        initWithStyle:UITableViewCellStyleDefault
                        reuseIdentifier :messageAlertCell];
            }
            [cell setData:model];
            return cell;
        }
        else {
            // Normal message
            // OutGoing message
            if ([model.fromUserId isEqualToString:[QKCLAccessUserDefaults getUserId]]) {
                QKCLMessageOutGoingTableViewCell *cell =
                (QKCLMessageOutGoingTableViewCell *)
                [tableView dequeueReusableCellWithIdentifier:messageOutGoingCell
                                                forIndexPath:indexPath];
                if (cell == nil) {
                    cell = [[QKCLMessageOutGoingTableViewCell alloc]
                            initWithStyle:UITableViewCellStyleDefault
                            reuseIdentifier :messageOutGoingCell];
                }
                [cell setData:model dateFormatter:_dateFormatter];
                return cell;
            }
            else {
                QKCLMessageIncomingTableViewCell *cell =
                (QKCLMessageIncomingTableViewCell *)
                [tableView dequeueReusableCellWithIdentifier:messageIncomingCell
                                                forIndexPath:indexPath];
                if (cell == nil) {
                    cell = [[QKCLMessageIncomingTableViewCell alloc]
                            initWithStyle:UITableViewCellStyleDefault
                            reuseIdentifier :messageIncomingCell];
                }
                
                [cell setData:model dateFormatter:_dateFormatter];
                return cell;
            }
        }
    }
}

- (CGFloat)       tableView:(UITableView *)tableView
    heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    QKCLMessageModel *model = [_messageArrays objectAtIndex:indexPath.row];
    if (model.isDate) {
        return 30;
    }
    else {
        if ([model.messageType
             isEqualToString:[NSString stringFromConst:QK_MESSAGE_TYPE_AUTO]]) {
            QKCLMessageAutoTableViewCell *cell = (QKCLMessageAutoTableViewCell *)
            [tableView dequeueReusableCellWithIdentifier:messageAutoCell];
            if (cell == nil) {
                cell = [[QKCLMessageAutoTableViewCell alloc]
                        initWithStyle:UITableViewCellStyleDefault
                        reuseIdentifier :messageAutoCell];
            }
            [cell setData:model];
            return [self calculateHeightForConfiguredSizingCell:cell
                                                    inTableView:tableView];
        }
        else if ([model.messageType
                  isEqualToString:
                  [NSString stringFromConst:QK_MESSAGE_TYPE_ALERT]]) {
            QKCLMessageAlertTableViewCell *cell = (QKCLMessageAlertTableViewCell *)
            [tableView dequeueReusableCellWithIdentifier:messageAlertCell];
            if (cell == nil) {
                cell = [[QKCLMessageAlertTableViewCell alloc]
                        initWithStyle:UITableViewCellStyleDefault
                        reuseIdentifier :messageAlertCell];
            }
            [cell setData:model];
            return [self calculateHeightForConfiguredSizingCell:cell
                                                    inTableView:tableView];
        }
        else {
            // Normal message
            // OutGoing message
            if ([model.fromUserId isEqualToString:[QKCLAccessUserDefaults getUserId]]) {
                QKCLMessageOutGoingTableViewCell *cell =
                (QKCLMessageOutGoingTableViewCell *)[tableView
                                                     dequeueReusableCellWithIdentifier:messageOutGoingCell];
                if (cell == nil) {
                    cell = [[QKCLMessageOutGoingTableViewCell alloc]
                            initWithStyle:UITableViewCellStyleDefault
                            reuseIdentifier :messageOutGoingCell];
                }
                return [cell getCellHeight:model dateFormatter:_dateFormatter];
            }
            else {
                QKCLMessageIncomingTableViewCell *cell =
                (QKCLMessageIncomingTableViewCell *)[tableView
                                                     dequeueReusableCellWithIdentifier:messageIncomingCell];
                if (cell == nil) {
                    cell = [[QKCLMessageIncomingTableViewCell alloc]
                            initWithStyle:UITableViewCellStyleDefault
                            reuseIdentifier :messageIncomingCell];
                }
                return [cell getCellHeight:model dateFormatter:_dateFormatter];
            }
        }
    }
}

- (void)scrollToBottom {
    if (_messageArrays.count > 0) {
        NSIndexPath *lastIndexPath =
        [NSIndexPath indexPathForRow:(_messageArrays.count - 1) inSection:0];
        [self.tableView scrollToRowAtIndexPath:lastIndexPath
                              atScrollPosition:UITableViewScrollPositionBottom
                                      animated:YES];
    }
}

#pragma mark -Keyboardhandler
- (void)keyboardSizeChanged:(CGSize)delta {
    _bottomConstraint.constant += delta.height;
    [UIView animateWithDuration:2.0
                     animations: ^{
                         [self.view layoutIfNeeded];
                     }
                     completion: ^(BOOL finished) {
                         if (delta.height > 0) {
                             [self scrollToBottom];
                         }
                     }];
}

- (void)dismissKeyboard:(UITapGestureRecognizer *)tap {
    [self.view endEditing:YES];
}

#pragma mark - UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView {
    if ([textView.text isEqualToString:@""]) {
        [_sendButton setEnabled:NO];
    }
    else {
        [_sendButton setEnabled:YES];
    }
}

#pragma mark -IBActions
- (IBAction)sendButtonClicked:(id)sender {
    if ([self connected]) {
        NSString *message = _textView.text;
        NSMutableDictionary *params = [NSMutableDictionary initWithApiKeyAndToken];
        [params setObject:[QKCLAccessUserDefaults getUserId] forKey:@"userId"];
        [params setObject:_recruimentId forKey:@"recruitmentId"];
        [params setObject:[QKCLEncryptUtil encyptBlowfish:_customerUserId] forKey:@"toUserId"];
        [params setObject:message forKey:@"message"];
        [[QKCLRequestManager sharedManager]
         asyncPOST:[NSString stringFromConst:qkUrlMessageRegist]
         parameters:params showLoading:NO showError:YES
         success: ^(AFHTTPRequestOperation *operation, id responseObject) {
             if ([responseObject[QK_API_STATUS_CODE]
                  isEqualToString:[NSString
                                   stringFromConst:QK_STT_CODE_SUCCESS]]) {
                      QKCLMessageModel *newModel = [[QKCLMessageModel alloc] init];
                      newModel.messageId = responseObject[@"messageId"];
                      newModel.isDate = NO;
                      newModel.message = message;
                      newModel.messageType =
                      [NSString stringFromConst:QK_MESSAGE_TYPE_NORMAL];
                      newModel.fromUserId = [QKCLAccessUserDefaults getUserId];
                      newModel.createDt = [responseObject dateForKey:@"createDt" format:@"yyyy-MM-dd HH:mm:ss"];
                      [_messageArrays addObject:newModel];
                      NSIndexPath *indexPath =
                      [NSIndexPath indexPathForRow:(_messageArrays.count - 1)
                                         inSection:0];
                      [self.tableView
                       insertRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil]
                       withRowAnimation:UITableViewRowAnimationBottom];
                      [self scrollToBottom];
                  }
             else {
                 [self stopTimer];
             }
         }
         failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"Error:%@", error);
         }];
        
        _textView.text = @"";
        [self textViewDidChange:_textView];
    }
    else {
        [self showNoInternetViewWithSelector:nil];
    }
}

#pragma mark -Touch
// override super
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
}

#pragma mark -UIGestureReconizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
       shouldReceiveTouch:(UITouch *)touch {
    if ([touch.view isDescendantOfView:_toolbar]) {
        return NO;
    }
    return YES;
}

#pragma mark -Timer
- (void)timerFired:(id)sender {
    _isScrollToBottom = NO;
    if (_messageArrays.count > 0) {
        NSIndexPath *lastIndexPath =
        [NSIndexPath indexPathForRow:(_messageArrays.count - 1) inSection:0];
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:lastIndexPath];
        if ([self.tableView.visibleCells containsObject:cell]) {
            _isScrollToBottom = YES;
        }
    }
    _isLoading = NO;
    [self getMessageList];
}

- (void)stopTimer {
    if (_timer) {
        if ([_timer isValid]) {
            [_timer invalidate];
            _timer = nil;
        }
    }
}

@end

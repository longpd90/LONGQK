//
//  QKCSMessageViewController.m
//  quicker-cl-ios
//
//  Created by Viet on 7/6/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCSMessageViewController.h"
#import "QKCSMessageModel.h"
#import "QKCSMessageAlertTableViewCell.h"
#import "QKCSMessageAutoTableViewCell.h"
#import "QKCSMessageDateTableViewCell.h"
#import "QKCSMessageOutGoingTableViewCell.h"
#import "QKCSMessageIncomingTableViewCell.h"
#import "chiase-ios-core/CCKeyboardHandler.h"
#import "AppDelegate.h"

@interface QKCSMessageViewController () <
CCKeyboardHandlerDelegate, UITextViewDelegate, UIGestureRecognizerDelegate>
@property(strong, nonatomic)
NSMutableArray *messageArrays; // arrays of QKCSMessageModel
@property(strong, nonatomic) NSDateFormatter *dateFormatter;
@property(strong, nonatomic) CCKeyboardHandler *keyboardHandler;
@property(strong, nonatomic) UIRefreshControl *refreshControl;
@property (strong,nonatomic) NSTimer *timer;
@property (nonatomic) BOOL isLoading;
@property (nonatomic) BOOL isScrollToBottom;

@end

static NSString *messageAlertCell = @"QKCSMessageAlertCell";
static NSString *messageAutoCell = @"QKCSMessageAutoCell";
static NSString *messageDateCell = @"QKCSMessageDateCell";
static NSString *messageOutGoingCell = @"QKCSMessageOutGoingCell";
static NSString *messageIncomingCell = @"QKCSMessageIncomingCell";

@implementation QKCSMessageViewController
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
    [_messageArrays removeAllObjects];
    _isScrollToBottom = YES;
    _isLoading = YES;
    [self getMessageList];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self scrollToBottom];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [QKAccessUserDefaults setShowAutoMessage:@"1"];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - API
- (void)getMessageList {
    if ([self connected]) {
        NSMutableDictionary *params = [NSMutableDictionary initWithApiKeyAndToken];
        [params setObject:[QKAccessUserDefaults getUserId] forKey:@"userId"];
        [params setObject:_recruimentId forKey:@"recruitmentId"];
        //[params setObject:@"" forKey:@"autoroadCd"];
        [params setObject:[NSString stringFromConst:QK_READ_FLG_DONE] forKey:@"notRead"];
        
        [[QKRequestManager sharedManager]
         asyncGET:[NSString stringFromConst:qkCSUrlMessageList] parameters:params showLoading:_isLoading showError:YES success:^(AFHTTPRequestOperation *operation, id responseObject) {
             if ([responseObject[QK_API_STATUS_CODE]
                  isEqualToString:[NSString
                                   stringFromConst:QK_STT_CODE_SUCCESS]]) {
                      _totalNum = [responseObject intForKey:@"totalNum"];
                      self.navigationItem.title =responseObject[@"customerUserName"];
                      //_autoroadCd = [responseObject stringForKey:@"autoroadCd"];
                      NSMutableArray *tmp = [[NSMutableArray alloc] init];
                      // get message list
                      NSArray *messageList =responseObject[@"messageList"];
                      NSArray* reversedArray = [[messageList reverseObjectEnumerator] allObjects];
                      for (NSDictionary *dic in reversedArray) {
                          
                          QKCSMessageModel *model =[[QKCSMessageModel alloc] initWithResponse:dic];
                          if (tmp.count == 0) {
                              QKCSMessageModel *dateModel = [[QKCSMessageModel alloc] init];
                              dateModel.isDate = YES;
                              dateModel.createDt =model.createDt;
                              [tmp addObject:dateModel];
                          }else{
                              [_dateFormatter setDateFormat:@"yyyy-MM-dd"];
                              NSString *newDate = [_dateFormatter stringFromDate:model.createDt];
                              QKCSMessageModel*lastMessage = (QKCSMessageModel*)[tmp lastObject];
                              NSString *oldDate = [_dateFormatter stringFromDate:lastMessage.createDt];
                              if (![newDate isEqualToString:oldDate]) {
                                  QKCSMessageModel *dateModel = [[QKCSMessageModel alloc] init];
                                  dateModel.isDate = YES;
                                  dateModel.createDt =model.createDt;
                                  [tmp addObject:dateModel];
                              }
                          }
                          
                          [tmp addObject:model];
                      }
                      
                      //add date label
                      if (tmp.count == 0) {
                          QKCSMessageModel *dateModel = [[QKCSMessageModel alloc] init];
                          dateModel.isDate = YES;
                          dateModel.createDt = [NSDate date];
                          [tmp addObject:dateModel];
                      }
                      
                      //add automessage
                      if ([[QKAccessUserDefaults getShowAutoMessage] isEqualToString:@""]) {
                          QKCSMessageModel *autoModel = [[QKCSMessageModel alloc] init];
                          autoModel.isDate = NO;
                          autoModel.messageType = [NSString stringFromConst:QK_MESSAGE_TYPE_AUTO];
                          
                          NSMutableArray *tmpArrays = [NSMutableArray arrayWithObject:tmp[0]];
                          [tmpArrays addObject:autoModel];
                          [tmp removeObjectAtIndex:0];
                          [tmpArrays addObjectsFromArray:tmp];
                          tmp = tmpArrays;
                          tmpArrays = nil;
                      }
                      
                      _messageArrays =tmp;
                      tmp = nil;
                      
                      //reload tableView
                      [self.tableView reloadData];
                      
                      if (_isScrollToBottom) {
                          [self scrollToBottom];
                      }
                      
                  }else{
                      [self stopTimer];
                  }
         }
         
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"Error:%@", error);
         }];
    } else {
        [self showNoInternetViewWithSelector:@selector(getMessageList)];
    }
}

- (void)getOlderMessageList {
    if ([self connected]) {
        NSMutableDictionary *params = [NSMutableDictionary initWithApiKeyAndToken];
        [params setObject:[QKAccessUserDefaults getUserId] forKey:@"userId"];
        [params setObject:_recruimentId forKey:@"recruitmentId"];
        [params setObject:_autoroadCd forKey:@"autoroadCd"];
        [params setObject:@"1" forKey:@"notRead"];
        
        [[QKRequestManager sharedManager]
         GET:[NSString stringFromConst:qkCSUrlMessageList]
         parameters:params
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             if ([responseObject[QK_API_STATUS_CODE]
                  isEqualToString:[NSString
                                   stringFromConst:QK_STT_CODE_SUCCESS]]) {
                      _autoroadCd = [responseObject stringForKey:@"autoroadCd"];
                      
                      // get message list
                      NSMutableArray *olderMessageArrays = [[NSMutableArray alloc] init];
                      for (NSDictionary *dic in responseObject[@"messageList"]) {
                          
                          QKCSMessageModel *model =[[QKCSMessageModel alloc] initWithResponse:dic];
                          if (olderMessageArrays.count == 0) {
                              QKCSMessageModel *dateModel = [[QKCSMessageModel alloc] init];
                              dateModel.isDate = YES;
                              dateModel.createDt =model.createDt;
                              [olderMessageArrays addObject:dateModel];
                          }else{
                              [_dateFormatter setDateFormat:@"yyyy-MM-dd"];
                              NSString *newDate = [_dateFormatter stringFromDate:model.createDt];
                              QKCSMessageModel*lastMessage = (QKCSMessageModel*)[olderMessageArrays lastObject];
                              NSString *oldDate = [_dateFormatter stringFromDate:lastMessage.createDt];
                              if (![newDate isEqualToString:oldDate]) {
                                  QKCSMessageModel *dateModel = [[QKCSMessageModel alloc] init];
                                  dateModel.isDate = YES;
                                  dateModel.createDt =model.createDt;
                                  [olderMessageArrays addObject:dateModel];
                              }
                          }
                          
                          [olderMessageArrays addObject:model];
                      }
                      
                      //add to messagearrays
                      if (olderMessageArrays.count >0 && _messageArrays.count >0) {
                          QKCSMessageModel *oldLastMessage = [olderMessageArrays lastObject];
                          [_dateFormatter setDateFormat:@"yyyy-MM-dd"];
                          NSString *oldDate = [_dateFormatter stringFromDate:oldLastMessage.createDt];
                          
                          QKCSMessageModel *firstMessage = [_messageArrays firstObject];
                          [_dateFormatter setDateFormat:@"yyyy-MM-dd"];
                          NSString *firstDate = [_dateFormatter stringFromDate:firstMessage.createDt];
                          
                          if ([oldDate isEqualToString:firstDate]) {
                              [_messageArrays removeObject:firstMessage];
                              
                          }
                          
                      }
                      [olderMessageArrays addObjectsFromArray:_messageArrays];
                      _messageArrays = olderMessageArrays;
                      [self.tableView reloadData];
                  } else {
                      NSString *errorString = [NSString
                                               stringWithFormat:@"%@:%@", responseObject[QK_API_STATUS_CODE],
                                               responseObject[@"msg"]];
                      UIAlertView *alertView =
                      [[UIAlertView alloc] initWithTitle:@"Error"
                                                 message:errorString
                                                delegate:nil
                                       cancelButtonTitle:@"OK"
                                       otherButtonTitles:nil];
                      [alertView show];
                      [_refreshControl endRefreshing];
                  }
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"Error:%@", error);
             [_refreshControl endRefreshing];
             
         }];
    } else {
        [self showNoInternetViewWithSelector:@selector(getOlderMessageList)];
    }
}

#pragma mark - TableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    return [_messageArrays count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QKCSMessageModel *model = [_messageArrays objectAtIndex:indexPath.row];
    if (model.isDate) {
        // Show date
        QKCSMessageDateTableViewCell *cell = (QKCSMessageDateTableViewCell *)
        [tableView dequeueReusableCellWithIdentifier:messageDateCell
		                                      forIndexPath:indexPath];
        if (cell == nil) {
            cell = [[QKCSMessageDateTableViewCell alloc]
                    initWithStyle:UITableViewCellStyleDefault
                    reuseIdentifier:messageDateCell];
        }
        [_dateFormatter setDateFormat:@"MM月dd日"];
        cell.dateLabel.text = [_dateFormatter stringFromDate:model.createDt];
        return cell;
    } else {
        if ([model.messageType
             isEqualToString:[NSString stringFromConst:QK_MESSAGE_TYPE_AUTO]]) {
            QKCSMessageAutoTableViewCell *cell = (QKCSMessageAutoTableViewCell *)
            [tableView dequeueReusableCellWithIdentifier:messageAutoCell
                                            forIndexPath:indexPath];
            if (cell == nil) {
                cell = [[QKCSMessageAutoTableViewCell alloc]
                        initWithStyle:UITableViewCellStyleDefault
                        reuseIdentifier:messageAutoCell];
            }
            [cell setData:model];
            return cell;
        } else if ([model.messageType
                    isEqualToString:
                    [NSString stringFromConst:QK_MESSAGE_TYPE_ALERT]]) {
            QKCSMessageAlertTableViewCell *cell = (QKCSMessageAlertTableViewCell *)
            [tableView dequeueReusableCellWithIdentifier:messageAlertCell
                                            forIndexPath:indexPath];
            if (cell == nil) {
                cell = [[QKCSMessageAlertTableViewCell alloc]
                        initWithStyle:UITableViewCellStyleDefault
                        reuseIdentifier:messageAlertCell];
            }
            [cell setData:model];
            return cell;
        } else {
            // Normal message
            // OutGoing message
            if ([model.fromUserId isEqualToString:[QKAccessUserDefaults getUserId]]) {
                QKCSMessageOutGoingTableViewCell *cell =
                (QKCSMessageOutGoingTableViewCell *)
                [tableView dequeueReusableCellWithIdentifier:messageOutGoingCell
                                                forIndexPath:indexPath];
                if (cell == nil) {
                    cell = [[QKCSMessageOutGoingTableViewCell alloc]
                            initWithStyle:UITableViewCellStyleDefault
                            reuseIdentifier:messageOutGoingCell];
                }
                [cell setData:model dateFormatter:_dateFormatter];
                return cell;
            } else {
                QKCSMessageIncomingTableViewCell *cell =
                (QKCSMessageIncomingTableViewCell *)
                [tableView dequeueReusableCellWithIdentifier:messageIncomingCell
                                                forIndexPath:indexPath];
                if (cell == nil) {
                    cell = [[QKCSMessageIncomingTableViewCell alloc]
                            initWithStyle:UITableViewCellStyleDefault
                            reuseIdentifier:messageIncomingCell];
                }
                
                [cell setData:model dateFormatter:_dateFormatter];
                return cell;
            }
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    QKCSMessageModel *model = [_messageArrays objectAtIndex:indexPath.row];
    if (model.isDate) {
        return 30;
    } else {
        if ([model.messageType
             isEqualToString:[NSString stringFromConst:QK_MESSAGE_TYPE_AUTO]]) {
            QKCSMessageAutoTableViewCell *cell = (QKCSMessageAutoTableViewCell *)
            [tableView dequeueReusableCellWithIdentifier:messageAutoCell];
            if (cell == nil) {
                cell = [[QKCSMessageAutoTableViewCell alloc]
                        initWithStyle:UITableViewCellStyleDefault
                        reuseIdentifier:messageAutoCell];
            }
            [cell setData:model];
            return [self calculateHeightForConfiguredSizingCell:cell
                                                    inTableView:tableView];
        } else if ([model.messageType
                    isEqualToString:
                    [NSString stringFromConst:QK_MESSAGE_TYPE_ALERT]]) {
            QKCSMessageAlertTableViewCell *cell = (QKCSMessageAlertTableViewCell *)
            [tableView dequeueReusableCellWithIdentifier:messageAlertCell];
            if (cell == nil) {
                cell = [[QKCSMessageAlertTableViewCell alloc]
                        initWithStyle:UITableViewCellStyleDefault
                        reuseIdentifier:messageAlertCell];
            }
            [cell setData:model];
            return [self calculateHeightForConfiguredSizingCell:cell
                                                    inTableView:tableView];
        } else {
            // Normal message
            // OutGoing message
            if ([model.fromUserId isEqualToString:[QKAccessUserDefaults getUserId]]) {
                QKCSMessageOutGoingTableViewCell *cell =
                (QKCSMessageOutGoingTableViewCell *)[tableView
                                                     dequeueReusableCellWithIdentifier:messageOutGoingCell];
                if (cell == nil) {
                    cell = [[QKCSMessageOutGoingTableViewCell alloc]
                            initWithStyle:UITableViewCellStyleDefault
                            reuseIdentifier:messageOutGoingCell];
                }
                return [cell getCellHeight:model dateFormatter:_dateFormatter];
            } else {
                QKCSMessageIncomingTableViewCell *cell =
                (QKCSMessageIncomingTableViewCell *)[tableView
                                                     dequeueReusableCellWithIdentifier:messageIncomingCell];
                if (cell == nil) {
                    cell = [[QKCSMessageIncomingTableViewCell alloc]
                            initWithStyle:UITableViewCellStyleDefault
                            reuseIdentifier:messageIncomingCell];
                }
                return [cell getCellHeight:model dateFormatter:_dateFormatter];
            }
        }
    }
}

- (void)scrollToBottom {
    if (_messageArrays.count >0) {
        
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
                     animations:^{
                         [self.view layoutIfNeeded];
                     }
                     completion:^(BOOL finished) {
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
    } else {
        [_sendButton setEnabled:YES];
    }
}

#pragma mark -IBActions
- (IBAction)sendButtonClicked:(id)sender {
    if ([self connected]) {
        NSString *message = _textView.text;
        NSMutableDictionary *params = [NSMutableDictionary initWithApiKeyAndToken];
        [params setObject:[QKAccessUserDefaults getUserId] forKey:@"userId"];
        [params setObject:_recruimentId forKey:@"recruitmentId"];
        [params setObject:message forKey:@"message"];
        [[QKRequestManager sharedManager]
         asyncPOST:[NSString stringFromConst:qkCSUrlMessageRegist]
         parameters:params showLoading:NO showError:YES
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             if ([responseObject[QK_API_STATUS_CODE]
                  isEqualToString:[NSString
                                   stringFromConst:QK_STT_CODE_SUCCESS]]) {
                      QKCSMessageModel *newModel = [[QKCSMessageModel alloc] init];
                      newModel.messageId = responseObject[@"messageId"];
                      newModel.createDt = [responseObject dateForKey:@"createDt" format:@"yyyy-MM-dd HH:mm:ss"];
                      newModel.isDate = NO;
                      newModel.message = message;
                      newModel.messageType =
                      [NSString stringFromConst:QK_MESSAGE_TYPE_NORMAL];
                      newModel.fromUserId = [QKAccessUserDefaults getUserId];
                      [_messageArrays addObject:newModel];
                      NSIndexPath *indexPath =
                      [NSIndexPath indexPathForRow:(_messageArrays.count - 1)
                                         inSection:0];
                      [self.tableView
                       insertRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil]
                       withRowAnimation:UITableViewRowAnimationBottom];
                      [self scrollToBottom];
                      
                      
                  }
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"Error:%@", error);
         }];
        
        _textView.text = @"";
        [self textViewDidChange:_textView];
    } else {
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
-(void)timerFired:(id)sender {
    _isScrollToBottom = NO;
    if (_messageArrays.count > 0) {
        NSIndexPath *lastIndexPath =
        [NSIndexPath indexPathForRow:(_messageArrays.count - 1) inSection:0];
        UITableViewCell*cell = [self.tableView cellForRowAtIndexPath:lastIndexPath];
        if ([self.tableView.visibleCells containsObject:cell]) {
            _isScrollToBottom = YES;
        }
    }
    _isLoading = NO;
    [self getMessageList];
}
-(void)stopTimer {
    if (_timer) {
        if ([_timer isValid]) {
            [_timer invalidate];
            _timer = nil;
        }
    }
}
@end

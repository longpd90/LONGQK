//
//  QKSelectPreferenceConditionViewController.h
//  quicker-cl-ios
//
//  Created by Vietnd on 6/13/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "QKCSTableViewController.h"


@protocol QKSelectPreferenceConditionDelegate <NSObject>
- (void)preferenceConditionSelected:(NSMutableArray *)selectedConditionArrays;
@end


@interface QKSelectPreferenceConditionTableViewController : QKCSTableViewController

//@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *currentConditionCdArrays;
@property (strong, nonatomic) id <QKSelectPreferenceConditionDelegate> delegate;

@end

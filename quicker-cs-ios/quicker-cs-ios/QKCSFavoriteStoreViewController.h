//
//  QKCSFavoriteStoreViewController.h
//  quicker-cs-ios
//
//  Created by C Anh on 8/12/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCSBaseViewController.h"

@interface QKCSFavoriteStoreViewController : QKCSBaseViewController <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *nothingView;

@end

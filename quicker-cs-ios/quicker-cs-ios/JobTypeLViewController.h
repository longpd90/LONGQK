//
//  JobTypeLViewController.h
//  quicker-cs-ios
//
//  Created by LongPD-PC on 5/25/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCSBaseViewController.h"
#import "QKJobTileModel.h"

@interface JobTypeLViewController : QKCSBaseViewController
@property (weak, nonatomic) IBOutlet UITableView *jobTypeLTableView;
@property(strong, nonatomic) NSArray *jobtiles;
@end

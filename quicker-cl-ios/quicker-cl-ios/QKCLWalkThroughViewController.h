//
//  QKWalkThroughViewController.h
//  quicker-cl-ios
//
//  Created by Viet on 5/8/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLBaseViewController.h"
#import "QKCLWalkThroughBaseViewController.h"
@interface QKCLWalkThroughViewController : QKCLBaseViewController <QKWalkThroughDelegate, UIPageViewControllerDataSource>
@property (strong, nonatomic) UIPageViewController *pageViewController;
@end

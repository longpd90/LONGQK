//
//  QKWalkThroughBaseViewController.h
//  quicker-cl-ios
//
//  Created by Nguyen Huu Anh on 5/28/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLBaseViewController.h"
@protocol QKWalkThroughDelegate <NSObject>
@optional

- (void)skip;
- (void)nextPage;

@end
@interface QKCLWalkThroughBaseViewController : QKCLBaseViewController
@property (weak, nonatomic) id <QKWalkThroughDelegate> walkThroughDelegate;
@end

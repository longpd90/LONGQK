//
//  QKAboutAppViewController.h
//  quicker-cs-ios
//
//  Created by Quy on 7/1/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCSBaseViewController.h"

@interface QKCSAboutAppViewController : QKCSBaseViewController
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

- (void)configView;
@end

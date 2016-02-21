//
//  QKF14Label.m
//  quicker-cl-ios
//
//  Created by Nguyen Huu Anh on 6/5/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKF14Label.h"

@implementation QKF14Label

- (void)awakeFromNib {
    [super awakeFromNib];
    self.textColor = [UIColor colorWithHexString:@"#fff"];
    self.font = [UIFont boldSystemFontOfSize:14.0];
}

@end

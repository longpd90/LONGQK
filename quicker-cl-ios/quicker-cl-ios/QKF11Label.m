//
//  QKF11Label.m
//  quicker-cl-ios
//
//  Created by Nguyen Huu Anh on 6/5/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKF11Label.h"

@implementation QKF11Label

- (void)awakeFromNib {
    [super awakeFromNib];
    self.textColor = [UIColor colorWithHexString:@"#444"];
    self.font = [UIFont boldSystemFontOfSize:14.0];
}

@end
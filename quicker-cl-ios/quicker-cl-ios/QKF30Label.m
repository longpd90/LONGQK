//
//  QKF30Label.m
//  quicker-cl-ios
//
//  Created by Nguyen Huu Anh on 6/5/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKF30Label.h"

@implementation QKF30Label

- (void)awakeFromNib {
    [super awakeFromNib];
    self.textColor = [UIColor colorWithHexString:@"#c94152"];
    self.font = [UIFont boldSystemFontOfSize:11.0];
}

@end

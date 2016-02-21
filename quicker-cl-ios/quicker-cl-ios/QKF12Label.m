//
//  QKF12Label.m
//  quicker-cl-ios
//
//  Created by Nguyen Huu Anh on 6/5/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKF12Label.h"

@implementation QKF12Label

- (void)awakeFromNib {
    [super awakeFromNib];
    self.textColor = [UIColor colorWithHexString:@"#888"];
    self.font = [UIFont systemFontOfSize:14.0];
}

@end

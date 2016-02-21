//
//  QKF13Label.m
//  quicker-cl-ios
//
//  Created by Nguyen Huu Anh on 6/5/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKF13Label.h"

@implementation QKF13Label

- (void)awakeFromNib {
    [super awakeFromNib];
    self.textColor = [UIColor colorWithHexString:@"#ccc"];
    self.font = [UIFont systemFontOfSize:14.0];
}

@end

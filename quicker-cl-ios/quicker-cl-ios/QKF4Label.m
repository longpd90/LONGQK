//
//  QKF4Label.m
//  quicker-cl-ios
//
//  Created by Nguyen Huu Anh on 6/5/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKF4Label.h"

@implementation QKF4Label

- (void)awakeFromNib {
    [super awakeFromNib];
    self.textColor = [UIColor colorWithHexString:@"#fff"];
    self.font = [UIFont boldSystemFontOfSize:17.0];
}

@end

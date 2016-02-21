//
//  QKF3Label.m
//  quicker-cl-ios
//
//  Created by Nguyen Huu Anh on 6/5/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKF3Label.h"

@implementation QKF3Label

- (void)awakeFromNib {
    [super awakeFromNib];
    self.textColor = [UIColor colorWithHexString:@"#fff"];
    self.font = [UIFont systemFontOfSize:17.0];
}

@end

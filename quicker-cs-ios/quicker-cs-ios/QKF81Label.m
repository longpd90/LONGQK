//
//  QKF81Label.m
//  quicker-cs-ios
//
//  Created by Viet on 6/23/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKF81Label.h"

@implementation QKF81Label

- (void)awakeFromNib {
    [super awakeFromNib];
    self.textColor = [UIColor colorWithHexString:@"#000"];
    self.font = [UIFont systemFontOfSize:7.0];
}

@end

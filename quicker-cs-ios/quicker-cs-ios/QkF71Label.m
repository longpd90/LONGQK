//
//  QkF71Label.m
//  quicker-cs-ios
//
//  Created by Viet on 6/23/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QkF71Label.h"

@implementation QkF71Label

- (void)awakeFromNib {
    [super awakeFromNib];
    self.textColor = [UIColor colorWithHexString:@"#333"];
    self.font = [UIFont systemFontOfSize:8.0];
}

@end

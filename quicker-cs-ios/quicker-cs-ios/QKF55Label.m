//
//  QKF55Label.m
//  quicker-cs-ios
//
//  Created by Viet on 6/23/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKF55Label.h"

@implementation QKF55Label

- (void)awakeFromNib {
    [super awakeFromNib];
    self.textColor = [UIColor colorWithHexString:@"#A3A3A3"];
    self.font = [UIFont systemFontOfSize:10.0];
}
@end

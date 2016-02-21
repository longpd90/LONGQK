//
//  QKF43Label.m
//  quicker-cl-ios
//
//  Created by Nguyen Huu Anh on 6/5/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKF43Label.h"

@implementation QKF43Label

- (void)awakeFromNib {
    [super awakeFromNib];
    self.textColor = [UIColor colorWithHexString:@"#fff"];
    self.font = [UIFont systemFontOfSize:10.0];
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.textColor = [UIColor colorWithHexString:@"#fff"];
        self.font = [UIFont systemFontOfSize:10.0];
    }
    return self;
}

- (id)init {
    self = [super init];
    if (self) {
        self.textColor = [UIColor colorWithHexString:@"#fff"];
        self.font = [UIFont systemFontOfSize:10.0];
    }
    return self;
}

@end

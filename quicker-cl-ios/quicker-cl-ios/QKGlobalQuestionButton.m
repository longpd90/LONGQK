//
//  QKGlobalQuestionButton.m
//  quicker-cl-ios
//
//  Created by Quy on 7/6/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKGlobalQuestionButton.h"

@implementation QKGlobalQuestionButton
- (void)awakeFromNib {
    [super awakeFromNib];
   }

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
       
    }
    return self;
}





- (void)setEnabled:(BOOL)enabled {
    [super setEnabled:enabled];
    if (enabled) {
    
        [self setTitleColor:[UIColor colorWithHexString:@"#58979A"] forState:UIControlStateNormal];
       
        
    }
    else {
         [self setTitleColor:[UIColor colorWithHexString:@"#444444"] forState:UIControlStateNormal];

    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

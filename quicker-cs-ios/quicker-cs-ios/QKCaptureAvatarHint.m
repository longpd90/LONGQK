//
//  QKCaptureAvatarHint.m
//  quicker-cl-ios
//
//  Created by Nguyen Huu Anh on 6/5/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCaptureAvatarHint.h"

@implementation QKCaptureAvatarHint


- (instancetype)initWithXibAndFrame:(CGRect)frame {
    self = [[[NSBundle mainBundle] loadNibNamed:@"QKCaptureAvatarHint" owner:self options:nil] lastObject];
    self.frame = frame;
    return self;
}

- (IBAction)hiddenAvatarHint:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(hiddenAvatarGuide:)]) {
        [self.delegate hiddenAvatarGuide:self];
    }
}

- (IBAction)hiddenButtonClicked:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(hiddenAvatarGuide:)]) {
        [self.delegate hiddenAvatarGuide:self];
    }
}

#pragma mark - Handle Action In View

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if (self.delegate && [self.delegate respondsToSelector:@selector(hiddenAvatarGuide:)]) {
        [self.delegate hiddenAvatarGuide:self];
    }
}

@end

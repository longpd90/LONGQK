//
//  QKTextViewTableViewCell.m
//  quicker-cl-ios
//
//  Created by Quy on 6/12/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKTextViewTableViewCell.h"
#import "chiase-ios-core/NSString+Extra.h"
#import "chiase-ios-core/UIColor+Extra.h"
@implementation QKTextViewTableViewCell {
    long remain_lenght;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (void)layoutSubviews {
    self.contentTextView.delegate = self;
    self.contentTextView.layer.borderWidth = 0.0;
    self.contentTextView.layer.borderColor = [UIColor clearColor].CGColor;
}

- (void)setCVInterFace {
    self.jobLabel.hidden = NO;
    self.textViewContraintToTop.constant = 23;
    self.contentTextView.textView.placeholder = @"詳しい仕事内容や働いていたお店について";
    self.layer.borderWidth = 1.0;
    self.layer.borderColor = [UIColor colorWithRed:204.0 / 255.0 green:204.0 / 255.0 blue:204.0 / 255.0 alpha:1].CGColor;
    
}

#pragma mark -Action

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

#pragma mark - textview

- (void)editingChanged:(UITextView *)textView {
    if (self.delegate &&[self.delegate respondsToSelector:@selector(editingTextChanged:)]) {
        [self.delegate editingTextChanged:textView.text];
    }
    
}

- (void)setText:(NSString *)text {
    [self.contentTextView setText:text];
}

@end

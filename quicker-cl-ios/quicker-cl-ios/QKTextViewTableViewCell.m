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
    [self setupGlobal];
    if (_max == 0) {
        _max = 100;
    }
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupGlobal];
        if (_max == 0) {
            _max = 100;
        }
    }
    return self;
}

- (void)setupGlobal {
    [self.textView setTextColor:[UIColor colorWithHexString:@"#444"]];
    [self.textView setFont:[UIFont systemFontOfSize:14]];
    _lengthText.textColor = [UIColor colorWithHexString:@"#444"];
    [_lengthText setFont:[UIFont systemFontOfSize:10.0f]];
    self.textView.delegate = self;
    self.textView.textContainerInset = UIEdgeInsetsMake(0, 0, 0, 0);
}

- (void)checkLengthTextPositive {
    if (remain_lenght < 0) {
        [self.lengthText setTextColor:[UIColor colorWithHexString:@"#C9283B"]];
    }
    else {
        [self.lengthText setTextColor:[UIColor colorWithHexString:@"#444"]];
    }
}

- (void)textViewDidChange:(UITextView *)textView {
    remain_lenght = _max - (long)textView.text.length;
    [self.lengthText setText:[NSString stringWithFormat:@"%ld", remain_lenght]];
    [self.lengthText sizeToFit];
    [self checkLengthTextPositive];
    if ([self.delegate respondsToSelector:@selector(editingChanged:)]) {
        [self.delegate editingChanged:textView];
    }
}

#pragma mark -Action
- (NSString *)getText {
    return self.textView.text;
}

- (void)setText:(NSString *)text {
    [self.textView setText:text];
    remain_lenght = _max - (long)text.length;
    [self.lengthText setText:[NSString stringWithFormat:@"%ld", remain_lenght]];
    [self.lengthText sizeToFit];
    [self checkLengthTextPositive];
}

- (void)setMaxLength:(NSInteger)max {
    _max = max;
    self.lengthText.text = [NSString stringWithFormat:@"%ld", (long)max];
}

- (void)setPlaceHolder:(NSString *)placeholder {
    self.textView.placeholder = placeholder;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

#pragma mark - Override

- (void)setEditable:(BOOL)editable {
    [self.textView setEditable:editable];
    if (editable) {
        //self.textView.scrollEnabled = YES;
        self.lengthText.hidden = NO;
        self.bottomConstraint.constant = 38.0;
        [self layoutIfNeeded];
    }
    else {
        //self.textView.scrollEnabled = NO;
        self.lengthText.hidden = YES;
        [self.lengthText removeFromSuperview];
        self.bottomConstraint.constant = 20.0;
        [self layoutIfNeeded];
    }
}

-(CGFloat)getCellHeight {
    CGSize textSize = { self.frame.size.width - 30.0, FLT_MAX };
    CGSize newSize = [self.textView sizeThatFits:textSize];
    CGFloat height= 20 + newSize.height + self.bottomConstraint.constant;
    return height;
}
@end

//
//  QKTextView.m
//  quicker-cs-ios
//
//  Created by LongPD-PC on 6/25/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKTextView.h"
#import "chiase-ios-core/NSString+Extra.h"
#import "chiase-ios-core/UIColor+Extra.h"

@implementation QKTextView


- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupGlobal];
    if (_max == 0) {
        _max = 200;
    }
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupGlobal];
        if (_max == 0) {
            _max = 200;
        }
    }
    return self;
}

- (void)setupGlobal {
    self.lengthText = [[QKF40Label alloc] init];
    self.lengthText.text = @"200";
    [self addSubview:self.lengthText];
    
    self.textView = [[QKGlobalTextView alloc] init];
    [self addSubview:self.textView];
    [self.textView setTextColor:[UIColor colorWithHexString:@"#444"]];
    [self.textView setFont:[UIFont systemFontOfSize:14]];
    _lengthText.textColor = [UIColor colorWithHexString:@"#444"];
    [_lengthText setFont:[UIFont systemFontOfSize:10.0f]];
    [_lengthText setTextAlignment:NSTextAlignmentRight];
    self.textView.delegate = self;
}

- (void)layoutSubviews {
    self.lengthText.frame = CGRectMake(self.width - self.lengthText.width - 15, self.height - self.lengthText.height - 20, 40, 15);    
    self.textView.frame = CGRectMake(10, 10, self.width - 20, self.height - 30 - self.lengthText.height);
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
    [self checkLengthTextPositive];
}

- (void)setMaxLength:(NSInteger)max {
    _max = max;
    self.lengthText.text = [NSString stringWithFormat:@"%ld", (long)max];
}

#pragma mark - UITextInputMode override
- (UITextInputMode *)textInputMode {
    NSString *userDefinedKeyboardLanguage;
    switch (_inputMode) {
        case InputModeJapanse:
            userDefinedKeyboardLanguage = @"ja";//default
            break;
            
        case InputModeEnglish:
            userDefinedKeyboardLanguage = @"en";
            break;
            
        default:
            break;
    }
    if (userDefinedKeyboardLanguage && ![userDefinedKeyboardLanguage isEqualToString:@""]) {
        for (UITextInputMode *tim in[UITextInputMode activeInputModes]) {
            if ([[NSString langFromLocale:userDefinedKeyboardLanguage] isEqualToString:[NSString langFromLocale:tim.primaryLanguage]]) {
                return tim;
            }
        }
    }
    return [super textInputMode];
}

@end

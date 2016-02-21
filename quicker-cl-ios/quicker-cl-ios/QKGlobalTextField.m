//
//  QKGlobalTextField.m
//  quicker-cl-ios
//
//  Created by LongPD-PC on 4/14/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKGlobalTextField.h"
#import "chiase-ios-core/UIColor+Extra.h"
@interface QKGlobalTextField ()
@property (nonatomic) BOOL isCurrency;
@property (strong,nonatomic) NSNumberFormatter *numberFormatter;
@end

@implementation QKGlobalTextField

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupGlobal];
    if (!_padding) {
        _padding = 15;
    }
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupGlobal];
        if (!_padding) {
            _padding = 15;
        }
    }
    return self;
}

- (void)setupGlobal {
    self.borderStyle = UITextBorderStyleNone;
    self.layer.cornerRadius = 3;
    self.layer.borderWidth = 0.5;
    self.layer.borderColor = [UIColor colorWithHexString:@"#AEAFAF"].CGColor;
    self.backgroundColor = [UIColor whiteColor];
    self.layer.masksToBounds = YES;
    [self addTarget:self action:@selector(textChanged:) forControlEvents:UIControlEventEditingChanged];
    
}

- (CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectInset(bounds, _padding, _padding);
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    return [self textRectForBounds:bounds];
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

-(void)setCurrencyValue:(NSInteger) value {
    _isCurrency = YES;
    _numberFormatter = [[NSNumberFormatter alloc] init];
    _numberFormatter.numberStyle = NSNumberFormatterCurrencyStyle;
    _numberFormatter.currencyCode = @"JPY";
    [_numberFormatter setCurrencySymbol:@""];
    self.text = [_numberFormatter stringFromNumber:[NSNumber numberWithInteger:value]];
    
}
-(NSInteger)getCurrencyValue {
    NSString *str = [self.text stringByReplacingOccurrencesOfString:@"," withString:@""];
    return [str integerValue];
}

-(void)textChanged:(id)sender {
    if (sender == self && _isCurrency) {
        [self setCurrencyValue:[self getCurrencyValue]];
        
    }
}
@end

//
//  QKGlobalTextView.m
//  quicker-cl-ios
//
//  Created by VietND on 6/9/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKGlobalTextView.h"
#import "chiase-ios-core/NSString+Extra.h"
#import "chiase-ios-core/UIColor+Extra.h"

@interface QKGlobalTextView ()

@property (nonatomic)  BOOL shouldDrawPlaceholder;

- (void)_updateShouldDrawPlaceholder;
- (void)_textChanged:(NSNotification *)notification;
@end


@implementation QKGlobalTextView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupGlobal];
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupGlobal];
    }
    return self;
}

- (void)setupGlobal {
    [self setTextContainerInset: UIEdgeInsetsMake(0, 0, 0, 0)];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_textChanged:) name:UITextViewTextDidChangeNotification object:self];
    
    self.placeholderTextColor = [UIColor colorWithHexString:@"#ccc"];
    _shouldDrawPlaceholder = NO;
    self.backgroundColor = [UIColor whiteColor];
}

- (void)setText:(NSString *)string {
    [super setText:string];
    [self _updateShouldDrawPlaceholder];
}

- (void)setPlaceholder:(NSString *)string {
    if ([string isEqual:_placeholder]) {
        return;
    }
    
    _placeholder = string;
    [self _updateShouldDrawPlaceholder];
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    if (_shouldDrawPlaceholder) {
        [_placeholderTextColor set];
        
        NSDictionary *dictionary = [[NSDictionary alloc] initWithObjectsAndKeys:[UIFont systemFontOfSize:14.0f], NSFontAttributeName,self.placeholderTextColor,NSForegroundColorAttributeName
                                    , nil];
        UIEdgeInsets inset = [self textContainerInset];
        [_placeholder drawInRect:CGRectMake(inset.left, inset.top, self.frame.size.width - inset.left - inset.right, self.frame.size.height - inset.bottom - inset.top) withAttributes:dictionary];
    }
}

#pragma mark - NSObject

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidChangeNotification object:self];
}

- (void)_updateShouldDrawPlaceholder {
    BOOL prev = _shouldDrawPlaceholder;
    _shouldDrawPlaceholder = self.placeholder && self.placeholderTextColor && self.text.length == 0;
    
    if (prev != _shouldDrawPlaceholder) {
        [self setNeedsDisplay];
    }
}

- (void)_textChanged:(NSNotification *)notification {
    [self _updateShouldDrawPlaceholder];
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

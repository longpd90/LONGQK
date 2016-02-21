//
//  QKGlobalTextField.m
//  quicker-cl-ios
//
//  Created by LongPD-PC on 4/14/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKGlobalTextField.h"
#import "QKConst.h"
#import "chiase-ios-core/UIColor+Extra.h"

@implementation QKGlobalTextField

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
    self.borderStyle= UITextBorderStyleNone;
	self.layer.cornerRadius = 4;
	self.layer.borderWidth = 0.5;
	self.layer.borderColor = [UIColor colorWithRed:204.0 / 255.0 green:204.0 / 255.0 blue:204.0 / 255.0 alpha:1].CGColor;
	self.backgroundColor = kQKColorWhite;
	self.layer.masksToBounds = YES;
	[self setValue:[UIColor colorWithHexString:@"#ccc"] forKeyPath:@"_placeholderLabel.textColor"];
	[self setFont:[UIFont systemFontOfSize:14.0f]];
}

// placeholder position
- (CGRect)textRectForBounds:(CGRect)bounds {
	return CGRectInset(bounds, 10, 10);
}

// text position
- (CGRect)editingRectForBounds:(CGRect)bounds {
	return CGRectInset(bounds, 10, 10);
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

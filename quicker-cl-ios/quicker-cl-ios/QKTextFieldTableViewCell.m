//
//  QKTextFieldTableViewCell.m
//  quicker-cl-ios
//
//  Created by Quy on 6/16/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKTextFieldTableViewCell.h"

@implementation QKTextFieldTableViewCell

- (void)awakeFromNib {
	[super awakeFromNib];
    self.textField.delegate =self;
	self.textField.borderStyle = UITextBorderStyleNone;
	[self.textField setValue:[UIColor colorWithHexString:@"#ccc"] forKeyPath:@"_placeholderLabel.textColor"];
	self.textField.font = [UIFont systemFontOfSize:14.0];
   
    
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
    self.textField.text = textField.text;
    if ([self.delegate respondsToSelector:@selector(textFieldEditingChanged:)]) {
        [self.delegate textFieldEditingChanged: self.textField];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
	[super setSelected:selected animated:animated];
   
    // Configure the view for the selected state
}

@end

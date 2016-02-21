//
//  QKTextFieldTableViewCell.h
//  quicker-cl-ios
//
//  Created by Quy on 6/16/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QKGlobalNoBorderTextField.h"
#import "chiase-ios-core/UIColor+Extra.h"
@protocol QKTextFieldTableViewCellDelegate <NSObject>
- (void)textFieldEditingChanged:(UITextField *)textField;
@end
@interface QKTextFieldTableViewCell : UITableViewCell<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet QKGlobalNoBorderTextField *textField;
@property id<QKTextFieldTableViewCellDelegate> delegate;
@end

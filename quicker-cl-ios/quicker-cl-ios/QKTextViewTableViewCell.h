//
//  QKTextViewTableViewCell.h
//  quicker-cl-ios
//
//  Created by Quy on 6/12/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QKCLGlobalDefines.h"
#import "QKGlobalTextView.h"

@protocol QKTextViewCellDelegate <NSObject>
- (void)editingChanged:(UITextView *)textView;
@end

@interface QKTextViewTableViewCell : UITableViewCell <UITextViewDelegate>
@property id <QKTextViewCellDelegate> delegate;
@property (weak, nonatomic) IBOutlet QKGlobalTextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *lengthText;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraint;
@property (assign, nonatomic) NSInteger max;

@property InputMode inputMode;
- (NSString *)getText;
- (void)setText:(NSString *)text;
- (void)setMaxLength:(NSInteger)max;
- (void)setPlaceHolder:(NSString *)placeholder;
- (void)setEditable:(BOOL)editable;
- (CGFloat)getCellHeight;
@end

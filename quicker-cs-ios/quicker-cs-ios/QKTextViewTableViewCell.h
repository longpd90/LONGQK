//
//  QKTextViewTableViewCell.h
//  quicker-cl-ios
//
//  Created by Quy on 6/12/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QKGlobalDefines.h"
#import "QKGlobalTextView.h"
#import "QKTextView.h"

@protocol QKTextViewCellDelegate <NSObject>
- (void)editingTextChanged:(NSString *)textContent;
@end

@interface QKTextViewTableViewCell : UITableViewCell <QKTextViewDelegate>
@property id <QKTextViewCellDelegate> delegate;
@property InputMode inputMode;
@property (strong, nonatomic) NSString *text;
@property (weak, nonatomic) IBOutlet QKTextView *contentTextView;
@property (weak, nonatomic) IBOutlet QKGlobalLabel *jobLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textViewContraintToTop;
- (void)setCVInterFace;

@end

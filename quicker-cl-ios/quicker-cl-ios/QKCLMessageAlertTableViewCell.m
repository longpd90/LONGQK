//
//  QKMessageAlertTableViewCell.m
//  quicker-cl-ios
//
//  Created by Viet on 7/7/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLMessageAlertTableViewCell.h"

@implementation QKCLMessageAlertTableViewCell

- (void)setData:(QKCLMessageModel *)model {
    self.messageLabel.text = model.message;
    self.messageLabel.preferredMaxLayoutWidth = self.frame.size.width - 55.0 * 2 - 10.0 * 2;
    [self.messageLabel sizeToFit];
    self.subMessageLabel.text = NSLocalizedString(@"(住所や連絡先など個人情報のやりとりはしないでください)", nil);
    self.subMessageLabel.preferredMaxLayoutWidth = self.frame.size.width - 10.0 * 2;
    [self.subMessageLabel sizeToFit];
}

@end

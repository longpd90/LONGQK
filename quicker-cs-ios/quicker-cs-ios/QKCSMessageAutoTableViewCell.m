//
//  QKMessageAutoTableViewCell.m
//  quicker-cl-ios
//
//  Created by Viet on 7/7/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCSMessageAutoTableViewCell.h"

@implementation QKCSMessageAutoTableViewCell
- (void)setData:(QKCSMessageModel *)model {
    if (model.message) {
        self.messageLabel.text = model.message;
    }else{
        self.messageLabel.text = NSLocalizedString(@"勤務に関する質問や確認事項について\nやりとりすることができます", nil);
    }
    self.messageLabel.preferredMaxLayoutWidth = self.frame.size.width - 55.0 * 2 - 10.0 * 2;
    [self.messageLabel sizeToFit];
    self.subMessageLabel.text = NSLocalizedString(@"(住所や連絡先など個人情報のやりとりはしないでください)", nil);
    self.subMessageLabel.preferredMaxLayoutWidth = self.frame.size.width - 10.0 * 2;
    [self.subMessageLabel sizeToFit];
}

@end

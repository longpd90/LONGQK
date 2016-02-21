//
//  QKMessageIncomingTableViewCell.m
//  quicker-cl-ios
//
//  Created by Viet on 7/7/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCSMessageIncomingTableViewCell.h"


@implementation QKCSMessageIncomingTableViewCell

- (void)setData:(QKCSMessageModel *)model dateFormatter:(NSDateFormatter*)dateFormatter {
    self.messageTextView.text = model.message;
    self.messageTextView.textContainerInset = UIEdgeInsetsMake(15, 15, 15, 15);
    self.messageTextView.layer.cornerRadius = 15.0f;
    [self.messageTextView sizeToFit];
    if (dateFormatter && model.createDt) {
        [dateFormatter setDateFormat:@"HH:mm"];
        self.timeLabel.text = [dateFormatter stringFromDate:model.createDt];
        [self.timeLabel sizeToFit];
    }else{
        self.timeLabel.text=@"00:00";
        [self.timeLabel sizeToFit];
    }
    
    [self.profileImageView setImageWithQKURL:model.fromUserImagePath placeholderImage:[UIImage imageNamed:@"accounnt_pic_blankprofile"] withCache:YES];
}

- (CGFloat)getCellHeight:(QKCSMessageModel *)model dateFormatter:(NSDateFormatter*)dateFormatter {
    [self setData:model dateFormatter:dateFormatter];
    
    CGSize messageSize = { self.frame.size.width - 48.0, FLT_MAX };
    
    //	NSAttributedString *attributedText = [[NSAttributedString alloc] initWithString:model.message
    //	                                                                     attributes:@{ NSFontAttributeName: [UIFont systemFontOfSize:14.0f] }];
    //	CGRect rect = [attributedText boundingRectWithSize:messageSize
    //	                                           options:NSStringDrawingUsesLineFragmentOrigin
    //	                                           context:nil];
    //
    CGSize newSize = [self.messageTextView sizeThatFits:messageSize];
    CGFloat height;
    
    height = newSize.height  + 10 + self.timeLabel.frame.size.height + 15;
    
    return height;
}

@end

//
//  QKMessageOutGoingTableViewCell.m
//  quicker-cl-ios
//
//  Created by Viet on 7/7/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCSMessageOutGoingTableViewCell.h"

@implementation QKCSMessageOutGoingTableViewCell

- (void)setData:(QKCSMessageModel *)model dateFormatter:(NSDateFormatter*)dateFormatter {
    self.messageTextView.text = model.message;
    self.messageTextView.textContainerInset = UIEdgeInsetsMake(15, 15, 15, 15);
    self.messageTextView.layer.cornerRadius = 15.0f;
    [self.messageTextView sizeToFit];
    if (dateFormatter &&model.createDt) {
        [dateFormatter setDateFormat:@"HH:mm"];
        self.seenTimeLabel.text = [dateFormatter stringFromDate:model.createDt];
        [self.seenTimeLabel sizeToFit];
    }else{
        self.seenTimeLabel.text = @"00:00";
        [self.seenTimeLabel sizeToFit];
        
    }
    if (model.readF) {
        self.seenLabel.hidden = NO;
    }else{
        self.seenLabel.hidden = YES;
    }
}

- (CGFloat)getCellHeight:(QKCSMessageModel *)model dateFormatter:(NSDateFormatter*)dateFormatter {
    [self setData:model dateFormatter:dateFormatter];
    
    CGSize messageSize = { self.frame.size.width - 80.0, FLT_MAX };
    
    //	NSAttributedString *attributedText = [[NSAttributedString alloc] initWithString:model.message
    //	                                                                     attributes:@{ NSFontAttributeName: [UIFont systemFontOfSize:14.0f] }];
    //	CGRect rect = [attributedText boundingRectWithSize:messageSize
    //	                                           options:NSStringDrawingUsesLineFragmentOrigin
    //	                                           context:nil];
    
    CGSize newSize = [self.messageTextView sizeThatFits:messageSize];
    CGFloat height;
    
    height = newSize.height  + 10 + self.seenTimeLabel.frame.size.height + 15;
    
    
    return height;
}

@end

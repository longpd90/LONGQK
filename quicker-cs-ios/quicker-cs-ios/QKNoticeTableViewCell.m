//
//  QKNoticeTableViewCell.m
//  quicker-cs-ios
//
//  Created by Nguyen Huu Anh on 5/11/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKNoticeTableViewCell.h"
#import "QKConst.h"

@implementation QKNoticeTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

- (void)setNoticeEntity:(QKCSNoticeModel *)noticeEntity {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    self.timeLabel.text =[dateFormatter stringFromDate: noticeEntity.noticeDt];
    dateFormatter = nil;
    [self.iconImageView setImageWithURL:noticeEntity.imagePath placeholderImage:nil];
    self.titleLabel.text = noticeEntity.noticeType;
    self.detailTextLabel.text = noticeEntity.noticeDetail;
    [self.statusIconView setBackgroundColor:[UIColor redColor]];
    if ([QK_READ_FLG_DONE isEqualToString:noticeEntity.readF]) {
        [self.statusIconView setHidden:YES];
    }
    
}
@end

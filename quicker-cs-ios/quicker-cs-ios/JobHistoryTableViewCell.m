//
//  JobHistoryTableViewCell.m
//  quicker-cs-ios
//
//  Created by LongPD-PC on 5/19/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "JobHistoryTableViewCell.h"

@implementation JobHistoryTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (void)setdeleteLabelNumber:(NSInteger )section {
    self.deleteLabel.text = [NSString stringWithFormat:@"バイト歴%dを削除",section];
}

@end

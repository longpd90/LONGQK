//
//  QKCSWorkHistoryTranferCell.m
//  quicker-cs-ios
//
//  Created by C Anh on 8/14/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCSWorkHistoryTranferCell.h"

@implementation QKCSWorkHistoryTranferCell

- (void)awakeFromNib {
    // Initialization code
    
    [super awakeFromNib];
    self.noteView.layer.cornerRadius = 3.0;
    self.noteView.backgroundColor = [UIColor colorWithRed:110.0/255.0 green:189.0/255.0 blue:193.0/255.0 alpha:1];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end

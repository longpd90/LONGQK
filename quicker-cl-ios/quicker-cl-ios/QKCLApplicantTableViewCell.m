//
//  QKCLApplicantTableViewCell.m
//  quicker-cl-ios
//
//  Created by Quy on 7/31/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLApplicantTableViewCell.h"

@implementation QKCLApplicantTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [self.hiddenWorkerLabel setHidden:YES];
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end

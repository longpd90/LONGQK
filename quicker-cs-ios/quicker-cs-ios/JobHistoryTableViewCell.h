//
//  JobHistoryTableViewCell.h
//  quicker-cs-ios
//
//  Created by LongPD-PC on 5/19/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JobHistoryTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *deleteLabel;
- (void)setdeleteLabelNumber:(NSInteger )section;
@end

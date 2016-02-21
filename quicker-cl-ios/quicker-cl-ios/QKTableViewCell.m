//
//  QKTableViewCell.m
//  quicker-cl-ios
//
//  Created by Nguyen Viet Thang on 6/8/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKTableViewCell.h"
#import "chiase-ios-core/UIColor+Extra.h"

@implementation QKTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
    [self setGlobal];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setGlobal];
    }
    
    return self;
}

- (void)setGlobal {
    //modify font and color for cell
    [self.textLabel setTextColor:[UIColor colorWithHexString:@"#444"]];
    self.textLabel.font = [UIFont systemFontOfSize:14.0];
    self.detailTextLabel.textColor = [UIColor colorWithHexString:@"#ccc"];
    [self.detailTextLabel setHighlightedTextColor:[UIColor colorWithHexString:@"#666"]];
    self.detailTextLabel.font = [UIFont systemFontOfSize:14.0];
    
    //set background when selected
    UIView *bg = [[UIView alloc]init];
    [bg setBackgroundColor:[UIColor colorWithHexString:@"#F7F7F7"]];
    self.selectedBackgroundView =  bg;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    //[self.contentView setBackgroundColor:[UIColor whiteColor]];
    // Configure the view for the selected state
}

@end

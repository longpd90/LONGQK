//
//  QKListQACell.h
//  quicker-cs-ios
//
//  Created by Nguyen Huu Anh on 7/2/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QKListQACell : UITableViewCell
@property (strong, nonatomic) NSArray *listQA;
@property (weak, nonatomic) IBOutlet UIView *qaListView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topContrain;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightQAListViewContrain;
@end

//
//  QKGenderTableViewCell.h
//  quicker-cs-ios
//
//  Created by LongPD-PC on 7/1/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QKConst.h"

@protocol QKGenderTableViewCellDelegate <NSObject>
- (void)genderChanged:(NSInteger )gender;
@end

@interface QKGenderTableViewCell : UITableViewCell
@property (assign, nonatomic) id <QKGenderTableViewCellDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIButton *manButton;
@property (weak, nonatomic) IBOutlet UIButton *womanButton;
@property (weak, nonatomic) IBOutlet UIView *placeView;
@property (assign, nonatomic) BOOL disableGender;
- (IBAction)genderSelected:(id)sender;
- (void)changeGender;
@property (assign, nonatomic) NSInteger gender;
@end

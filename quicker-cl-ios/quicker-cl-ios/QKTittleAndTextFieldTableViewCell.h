//
//  QKTitleAndTextFieldTableViewCell.h
//  quicker-cl-ios
//
//  Created by Viet on 6/17/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QKF10Label.h"
#import "QKGlobalNoBorderTextField.h"
#import "QKF12Label.h"

@interface QKTittleAndTextFieldTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet QKF10Label *titleLabel;
@property (weak, nonatomic) IBOutlet QKGlobalNoBorderTextField *textField;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *traillingContrainst;
@property (weak, nonatomic) IBOutlet QKF12Label *currencyLabel;

-(void)setCurrency:(BOOL)isCurrency;
@end

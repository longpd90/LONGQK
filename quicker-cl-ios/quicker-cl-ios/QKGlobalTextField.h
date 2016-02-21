//
//  QKGlobalTextField.h
//  quicker-cl-ios
//
//  Created by LongPD-PC on 4/14/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//
//

#import <UIKit/UIKit.h>
#import "QKCLGlobalDefines.h"
#import "chiase-ios-core/NSString+Extra.h"

@interface QKGlobalTextField : UITextField
@property InputMode inputMode;
@property (nonatomic) IBInspectable CGFloat padding;

-(void)setCurrencyValue:(NSInteger) value;
-(NSInteger)getCurrencyValue;
@end

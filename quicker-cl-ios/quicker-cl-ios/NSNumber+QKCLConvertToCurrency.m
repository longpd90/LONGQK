//
//  NSNumberFormatter+QKCLExtra.m
//  quicker-cl-ios
//
//  Created by VietND on 8/14/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "NSNumber+QKCLConvertToCurrency.h"

@implementation NSNumber (QKCLConvertToCurrency)
-(NSString*)convertToCurrency {
    NSNumberFormatter *fmt = [[NSNumberFormatter alloc] init];
    fmt.numberStyle = NSNumberFormatterCurrencyStyle;
    fmt.currencyCode = @"JPY";
    [fmt setCurrencySymbol:@""];
    return [fmt stringFromNumber:self];
}
@end

//
//  NSNumberFormatter+QKCLExtra.m
//  quicker-cl-ios
//
//  Created by VietND on 8/14/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "NSNumber+QKCSConvertToCurrency.h"

@implementation NSNumber (QKCSConvertToCurrency)
-(NSString*)convertToCurrency {
    NSNumberFormatter *fmt = [[NSNumberFormatter alloc] init];
    fmt.numberStyle = NSNumberFormatterCurrencyStyle;
    fmt.currencyCode = @"JPY";
    [fmt setCurrencySymbol:@""];
    return [fmt stringFromNumber:self];
}
@end

//
//  NSString+QKCLConvertToURL.m
//  quicker-cl-ios
//
//  Created by VietND on 8/11/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "NSString+QKCLConvertToURL.h"
#import "QKCLConst.h"

@implementation NSString (QKCLConvertToURL)
- (NSURL *)convertToURL {
    if (self && ![self isEqualToString:@""]) {
        NSMutableString *imageURLString = [NSMutableString stringWithString:self];
        NSString *http = [self componentsSeparatedByString:@"//"][0];
        [imageURLString insertString:kQKBasicAuthString atIndex:http.length + 2];
        return [NSURL URLWithString:imageURLString];
    }
    else {
        return nil;
    }
}

@end

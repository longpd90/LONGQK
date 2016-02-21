//
//  NSString+QKCLConvertToURL.m
//  quicker-cl-ios
//
//  Created by VietND on 8/11/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "NSString+QKCSConvertToURL.h"
#import "QKConst.h"

@implementation NSString (QKCSConvertToURL)
-(NSURL*)convertToURL {
    if (self && ![self isEqualToString:@""]) {
        NSMutableString *imageURLString = [NSMutableString stringWithString:self];
        NSString *http = [self componentsSeparatedByString:@"//"][0];
        [imageURLString insertString:kQKBasicAuthString atIndex: http.length + 2];
        return [NSURL URLWithString:imageURLString];
    }
    else{
        return nil;
    }
}

+ (NSString *)stringFromConst:(NSString const *)constValue {
    return [NSString stringWithFormat:@"%@",constValue];
}

@end

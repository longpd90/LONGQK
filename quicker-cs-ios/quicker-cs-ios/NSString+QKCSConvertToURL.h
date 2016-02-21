//
//  NSString+QKCLConvertToURL.h
//  quicker-cl-ios
//
//  Created by VietND on 8/11/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (QKCSConvertToURL)
-(NSURL*)convertToURL;
+ (NSString *)stringFromConst:(NSString const *)constValue ;
@end

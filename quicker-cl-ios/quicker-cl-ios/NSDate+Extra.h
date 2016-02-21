//
//  NSDate+Extra.h
//  quicker-cl-ios
//
//  Created by VietND on 7/16/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Extra)
- (NSDate *)earlierDateWithTimeInterval:(NSTimeInterval)interval;
- (BOOL)isLaterThanDate:(NSDate *)date;
- (NSString *)longDateString;
- (NSString *)longDateStringJapanes;
- (NSString*)convertToAge;
- (BOOL)isSameDayWithDate:(NSDate*)date2;

+ (NSString *)calculateWorkTime:(NSDate *)startTime endTime:(NSDate *)endTime;
@end

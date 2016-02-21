//
//  QKEncryptUtil.h
//  quicker-cl-ios
//
//  Created by Vietnd on 5/16/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCrypto.h>
@interface QKEncryptUtil : NSObject
+ (NSString *)encyptBlowfish:(NSString *)str;
+ (NSString *)decryptBlowfish:(NSString *)str;
@end

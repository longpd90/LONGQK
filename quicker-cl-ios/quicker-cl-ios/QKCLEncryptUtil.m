//
//  QKEncryptUtil.m
//  quicker-cl-ios
//
//  Created by Vietnd on 5/16/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLEncryptUtil.h"
#import "QKCLConst.h"

@implementation QKCLEncryptUtil
+ (NSString *)encyptBlowfish:(NSString *)str {
    NSData *myKey = [kQKBlowfishKey dataUsingEncoding:NSUTF8StringEncoding];
    NSData *myData2 = [str dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableData *myEnc = [NSMutableData dataWithLength:kCCKeySizeMaxBlowfish + str.length];
    
    size_t wSize = ((myEnc.length + kCCBlockSizeBlowfish - 1) / kCCBlockSizeBlowfish) * kCCBlockSizeBlowfish;
    char v[wSize];
    
    CCCrypt(kCCEncrypt,
            kCCAlgorithmBlowfish,
            kCCOptionPKCS7Padding | kCCOptionECBMode,
            myKey.bytes,
            myKey.length,
            NULL,
            myData2.bytes,
            myData2.length,
            v,
            wSize,
            &wSize);
    
    NSData *data =  [NSData dataWithBytes:v length:wSize];
    //return [data base64EncodedStringWithOptions:0];
    return [self serializeData:data];
}

+ (NSString *)serializeData:(NSData *)data {
    NSMutableString *str = [NSMutableString stringWithCapacity:64];
    NSUInteger length = [data length];
    char *bytes = malloc(sizeof(char) * length);
    
    [data getBytes:bytes length:length];
    
    for (int i = 0; i < length; i++) {
        [str appendFormat:@"%02.2hhX", bytes[i]];
    }
    free(bytes);
    
    return [str lowercaseString];
}

+ (NSString *)decryptBlowfish:(NSString *)str {
    NSData *myKey = [kQKBlowfishKey dataUsingEncoding:NSUTF8StringEncoding];
    NSData *myData2 = [[NSData alloc] initWithBase64EncodedString:str options:0];
    //NSData *myData2= [NSData dataFromBase64String:str];
    
    NSMutableData *myEnc = [NSMutableData dataWithLength:kCCKeySizeMaxBlowfish + str.length];
    
    size_t wsize = ((myEnc.length + kCCBlockSizeBlowfish - 1) / kCCBlockSizeBlowfish) * kCCBlockSizeBlowfish;
    char v[wsize];
    
    CCCrypt(kCCDecrypt,
            kCCAlgorithmBlowfish,
            kCCOptionPKCS7Padding | kCCOptionECBMode,
            myKey.bytes,
            myKey.length,
            NULL,
            myData2.bytes,
            myData2.length,
            v,
            wsize,
            &wsize);
    return [[NSString alloc] initWithData:[NSData dataWithBytes:v length:wsize] encoding:NSUTF8StringEncoding];
}

@end

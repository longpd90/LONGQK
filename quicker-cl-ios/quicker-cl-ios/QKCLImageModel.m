//
//  QKImageModel.m
//  quicker-cl-ios
//
//  Created by Quy on 5/18/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLImageModel.h"
#import "chiase-ios-core/NSDictionary+ParseResult.h"
#import "NSString+QKCLConvertToURL.h"

@implementation QKCLImageModel

- (instancetype)initWithImageData:(NSDictionary *)imageData {
    self = [super init];
    if (self) {
        [self setImageId:[imageData stringForKey:@"imageId"]];
        [self setImageUrl:[[imageData stringForKey:@"imagePath"] convertToURL]];
        self.imageType = [imageData stringForKey:@"imageType"];
    }
    return self;
}

@end

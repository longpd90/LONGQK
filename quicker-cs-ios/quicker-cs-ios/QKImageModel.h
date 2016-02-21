//
//  QKImageModel.h
//  quicker-cl-ios
//
//  Created by Quy on 5/18/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QKImageModel : NSObject

@property (strong, nonatomic) NSString *imageId;
@property (strong, nonatomic) NSURL *imageUrl;
@property (strong, nonatomic) NSString *imageStatus;
@property (strong, nonatomic) NSString *imageType;
- (instancetype)initWithImageData:(NSDictionary *)imageData;

@end

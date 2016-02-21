//
//  QKJobTileModel.h
//  quicker-cs-ios
//
//  Created by LongPD-PC on 6/30/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QKJobTileModel : NSObject
@property (strong, nonatomic) NSString *jobTile;
@property (strong, nonatomic) NSString *jobName;

- (instancetype)initWithResponseJobTileL:(NSDictionary *)response;
- (instancetype)initWithResponseJobTileM:(NSDictionary *)response;
- (instancetype)initWithResponseJobTileS:(NSDictionary *)response;
- (instancetype)initWithArrayJobTileS:(NSDictionary *)response ;

@end

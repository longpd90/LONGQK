//
//  QKNoticeListModel.h
//  quicker-cl-ios
//
//  Created by Quy on 6/8/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QKImageView.h"

@interface QKCLNoticeModel : NSObject


@property (nonatomic, strong) NSString *noticeId;
@property (strong, nonatomic) NSString *fromUserId;
@property (nonatomic, strong) NSURL *imagePath;
@property (nonatomic, strong) NSString *noticeDetail;
@property (nonatomic, strong) NSString *readF;
@property (nonatomic, strong) NSString *listReadF;
@property (nonatomic, strong) NSDate *noticeDt;
@property (nonatomic, strong) NSString *shopId;
@property (nonatomic, strong) NSString *shopName;
@property (nonatomic, strong) NSString *recruitmentId;
@property (nonatomic, strong) NSString *qaId;


- (instancetype)initWithResponse:(NSDictionary *)noticeData;
@end

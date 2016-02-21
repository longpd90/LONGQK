//
//  QKNoticeListModel.m
//  quicker-cl-ios
//
//  Created by Quy on 6/8/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCSNoticeModel.h"
#import "chiase-ios-core/NSDictionary+ParseResult.h"
#import "NSString+QKCSConvertToURL.h"

@implementation QKCSNoticeModel

- (instancetype)initWithResponse:(NSDictionary *)noticeData {
    self = [super init];
    if (self) {
        [self setNoticeId:[noticeData stringForKey:@"noticeId"]];
        [self setNoticeType:[noticeData stringForKey:@"noticeType"]];
        [self setFromUserId:[noticeData stringForKey:@"fromUserId"]];
        [self setImagePath:[[noticeData stringForKey:@"imagePath"] convertToURL]];
        [self setNoticeDetail:[noticeData stringForKey:@"noticeDetail"]];
        [self setReadF:[noticeData stringForKey:@"readF"]];
        [self setNoticeDt:[noticeData dateForKey:@"noticeDt" format:@"yyyy-MM-dd HH:mm"]];
        [self setShopId:[noticeData stringForKey:@"shopId"]];
        [self setShopName:[noticeData stringForKey:@"shopName"]];
        [self setRecruitmentId:[noticeData stringForKey:@"recruitmentId"]];
        [self setQaId:[noticeData stringForKey:@"qaId"]];
    }
    return self;
}

@end

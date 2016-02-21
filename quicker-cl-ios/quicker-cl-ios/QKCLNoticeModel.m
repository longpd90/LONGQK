//
//  QKNoticeListModel.m
//  quicker-cl-ios
//
//  Created by Quy on 6/8/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLNoticeModel.h"
#import "chiase-ios-core/NSDictionary+ParseResult.h"
@implementation QKCLNoticeModel

- (instancetype)initWithResponse:(NSDictionary *)noticeData {
    self = [super init];
    if (self) {
        [self setNoticeId:[noticeData stringForKey:@"noticeId"]];
        [self setFromUserId:[noticeData stringForKey:@"fromUserId"]];
        
        NSMutableString *imageURLString = [NSMutableString stringWithString:[noticeData stringForKey:@"imagePath"]];
        if (imageURLString.length > 6) {
            [imageURLString insertString:@"shk:258456" atIndex:6];
            [self setImagePath:[NSURL URLWithString:imageURLString]];
        }
        [self setNoticeDetail:[noticeData stringForKey:@"noticeDetail"]];
        [self setReadF:[noticeData stringForKey:@"readF"]];
        [self setListReadF:[noticeData stringForKey:@"listReadF"]];
        [self setNoticeDt:[noticeData dateForKey:@"noticeDt" format:@"yyyy-MM-dd HH:mm"]];
        [self setShopId:[noticeData stringForKey:@"shopId"]];
        [self setShopName:[noticeData stringForKey:@"shopName"]];
        [self setRecruitmentId:[noticeData stringForKey:@"recruitmentId"]];
        [self setQaId:[noticeData stringForKey:@"qaId"]];
    }
    return self;
}

@end

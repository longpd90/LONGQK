//
//  QKSlideMenuCell.m
//  quicker-cl-ios
//
//  Created by Nguyen Huu Anh on 5/22/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKSlideMenuCell.h"
#import "QKCLConst.h"
#import "chiase-ios-core/NSString+Extra.h"
#import "QKCLAccessUserDefaults.h"

@implementation QKSlideMenuCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    if (selected) {
        //		self.backgroundColor = [UIColor colorWithRed:79.0 / 255.0 green:88.0 / 255.0 blue:105.0 / 255.0 alpha:1.0];
    }
    else {
        //		self.backgroundColor = [UIColor colorWithRed:45.0 / 255.0 green:62.0 / 255.0 blue:80.0 / 255.0 alpha:1.0];
    }
}

- (void)setupInterfaceWithData:(QKCLShopInfoModel *)shopInfoModel {
    NSLog(@" shop status%@", shopInfoModel.shopStatus);
    if ([shopInfoModel.shopStatus isEqualToString:[NSString stringFromConst:QK_SHOP_STATUS_PUBLIC]]) {
        QKCLImageModel *firstImageModel;
        if ([shopInfoModel.imageFileList count] > 0) {
            firstImageModel = (QKCLImageModel *)[shopInfoModel.imageFileList firstObject];
        }
        if (firstImageModel) {
            [self.shopImage setImageWithURL:firstImageModel.imageUrl placeholderImage:nil];
        }
    }
    else if ([shopInfoModel.shopStatus isEqualToString:[NSString stringFromConst:QK_SHOP_STATUS_EXAMINATING]]) {
        [self.shopImage setImage:[UIImage imageNamed:@"drawer_pic_review"]];
    }
    else if ([shopInfoModel.shopStatus isEqualToString:[NSString stringFromConst:QK_SHOP_STATUS_EXAM_NG]]) {
        [self.shopImage setImage:[UIImage imageNamed:@"drawer_pic_result"]];
    }
    
    self.shopNameLabel.text = shopInfoModel.name;
    if (shopInfoModel.unreadNoticeNum > 0) {
        self.notificationLabel.hidden = NO;
        self.notificationLabel.text = [NSString stringWithFormat:@"%ld", (long)shopInfoModel.unreadNoticeNum];
    }
    else {
        self.notificationLabel.hidden = YES;
    }
    
    if ([[QKCLAccessUserDefaults getActiveShopId] isEqualToString:shopInfoModel.shopId]) {
        self.selected = YES;
        self.backgroundColor = [UIColor colorWithRed:79.0 / 255.0 green:88.0 / 255.0 blue:105.0 / 255.0 alpha:1.0];
    }
    else {
        self.selected = NO;
        self.backgroundColor = [UIColor colorWithRed:45.0 / 255.0 green:62.0 / 255.0 blue:80.0 / 255.0 alpha:1.0];
    }
}

@end

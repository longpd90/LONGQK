//
//  QKSlideMenuCell.h
//  quicker-cl-ios
//
//  Created by Nguyen Huu Anh on 5/22/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+AFNetworking.h"
#import "QKCLImageModel.h"
#import "QKCLShopInfoModel.h"

@interface QKSlideMenuCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *shopImage;
@property (weak, nonatomic) IBOutlet UILabel *shopNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *notificationLabel;

- (void)setupInterfaceWithData:(QKCLShopInfoModel *)shopInfoModel;
@end

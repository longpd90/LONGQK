//
//  MyPageViewController.h
//  quicker-cl-ios
//
//  Created by LongPD-PC on 4/15/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QKCLBaseViewController.h"
#import "QKCLShopInfoModel.h"
#import "QKCLPaymentMethodViewController.h"


enum Sections {
    kSection1 = 0,
    kSection2,
    kSection3,
    kSection4,
    kSection5,
    kSection6,
    kSection7,
    kSectionCount
};

enum Row1 {
    kRow11 = 0,
    kRow1Count
};


enum Row2 {
    kRow21 = 0,
    kRow22,
    kRow2Count
};

enum Row3 {
    kRow31 = 0,
    kRow32,
    kRow3Count
};

enum Row4 {
    kRow4Count = 0
};

enum Row5 {
    kRow51 = 0,
    kRow52 ,
    kRow5Count
};

enum Row6 {
    kRow61 = 0,
    kRow62,
    kRow63,
    kRow64,
    kRow65,
    kRow66,
    kRow67,
    kRow6Count
};

enum Row7 {
    kRow71 = 0,
    kRow7Count
};

typedef  enum qkclWebViewType:NSInteger {
    qkclWebViewTypeTermOfService = 0,
    qkclWebViewTypePolicy,
    qkclWebViewTypeCopyright
}(qkclWebViewType);

@interface QKCLMyPageViewController :QKCLBaseViewController

@property (strong, nonatomic) QKCLShopInfoModel *shopInfo;

@property (weak, nonatomic) IBOutlet UITableView *detailTableView;

@end

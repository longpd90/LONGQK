//
//  QKMyPageTableViewController.h
//  quicker-cs-ios
//
//  Created by LongPD-PC on 5/8/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "QKCSTableViewController.h"

@interface QKMyPageTableViewController : QKCSTableViewController

	enum Sections {
	kSection1 = 0,
	kSection2,
	kSection3,
	kSection4,
	kSection5,
	kSectionCount
};

enum Row1 {
	kRow11 = 0,
    kRow12,
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
	kRow41 = 0,
	kRow42,
	kRow43,
	kRow44,
	kRow4Count
};

enum Row5 {
	kRow51 = 0,
	kRow5Count
};
typedef  enum qkcsWebViewType:NSInteger {
    qkcsWebViewTypeTermOfService = 0,
    qkcsWebViewTypePolicy
}(qkcsWebViewType);

@end

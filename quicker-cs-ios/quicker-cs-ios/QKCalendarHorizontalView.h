//
//  QKCalendarHorizontalView.h
//  quicker-cs-ios
//
//  Created by LongPD-PC on 6/4/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSDate+Extra.h"
#import "chiase-ios-core/UIView+Extra.h"
#import "QKGlobalDefines.h"

@protocol QKCalendarHorizontalViewDelegate <NSObject>
- (void)changeDate:(NSDate *)date bySwipe:(BOOL)isSwipe;
@end

@interface QKCalendarHorizontalView : UIView <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) id <QKCalendarHorizontalViewDelegate> delegate;
@property (strong, nonatomic) UITableView *calendarTableView;
@property (strong, nonatomic) NSCalendar *calendar;
@property (strong, nonatomic) NSMutableArray *months;
@property (strong, nonatomic) NSIndexPath *lastCellSelectedIndexPath;
@property (strong, nonatomic) NSArray *recruitmentPerDays;

- (void)swipeOneDayToLeft;
- (void)swipeOneDayToRight;
@end

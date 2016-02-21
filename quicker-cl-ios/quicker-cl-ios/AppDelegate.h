//
//  AppDelegate.h
//  quicker-cl-ios
//
//  Created by Viet on 4/14/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

- (void)moveToScreen:(NSString *)statusCd shopStatus:(NSString *)shopStatus shopId:(NSString *)shopId;
- (BOOL)checkNotificationSettings;
- (void)showNotificationTips;
- (void)moveToShopAddScreen;
- (void)moveToUpgradeVersionScreen;
@end

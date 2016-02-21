//
//  AppDelegate.h
//  quicker-cs-ios
//
//  Created by Viet on 4/13/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;


- (void)moveToScreen:(NSString *)statusCd;
-(void)moveToUpgradeVersionScreen;

@end

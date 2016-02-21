//
//  LocationService.h
//  ARShop
//
//  Created by Applehouse on 12/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

#define QKLocationChangedNotification			@"QKLocationChangedNotification"
#define QKLocationReceiveDidFailNotification	@"QKLocationReceiveDidFailNotification"

@interface QKLocationService : NSObject<CLLocationManagerDelegate>{
}
@property(nonatomic,retain) CLLocationManager *locationManager;
@property (assign, nonatomic) CLLocationAccuracy accuracy;
@property (nonatomic, readonly) CLLocationCoordinate2D	coordinates;

+ (id)sharedLocation;
- (id)init;
- (void)stopUpdatingLocation;
- (void) updateLocation;
- (NSString *)latitudeStringValue;
- (NSString *)longitudeStringValue;
- (double)latitude;
- (double)longitude;
- (void)updateHeading;
- (void)stopUpdatingHeading;

@end

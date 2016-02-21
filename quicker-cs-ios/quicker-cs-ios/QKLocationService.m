//
//  LocationService.m
//  ARShop
//
//  Created by Applehouse on 12/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "QKLocationService.h"

@implementation QKLocationService
@synthesize coordinates,locationManager;
static QKLocationService *_instance;

- (id)init{
    if (self = [super init]) {
        self.locationManager = [[CLLocationManager alloc]init];
        self.locationManager.delegate = self;
        self.accuracy = kCLLocationAccuracyBest;

    }
    return self;
}

+ (id)sharedLocation{
    @synchronized(self) {
        
        if (_instance == nil) {
            _instance = [[super alloc] init];
        }
    }
    return _instance;
}

#pragma mark Public Methods

- (void)stopUpdatingLocation
{
    [locationManager stopUpdatingLocation];
}

- (void) updateLocation
{
    if (locationManager.desiredAccuracy != self.accuracy) {
        [self.locationManager setDistanceFilter:3];
        [locationManager setDesiredAccuracy:self.accuracy];
    }
    [locationManager startUpdatingLocation];
}

- (NSString *)latitudeStringValue
{
    return [@(coordinates.latitude) stringValue];
}

- (NSString *)longitudeStringValue
{
    return [@(coordinates.longitude) stringValue];
}

- (double)latitude
{
    return coordinates.latitude;
}

- (double)longitude
{
    return coordinates.longitude;
}

- (void)updateHeading
{
    if ([CLLocationManager headingAvailable]) {
        locationManager.headingFilter = 5;
        [locationManager startUpdatingHeading];
    }
}

- (void)stopUpdatingHeading
{
    [locationManager stopUpdatingHeading];
}

#pragma mark CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading
{
    if (newHeading.headingAccuracy < 0) return;
    CLLocationDirection theHeading = ((newHeading.trueHeading > 0) ?
                                      newHeading.trueHeading : newHeading.magneticHeading);
    float oldRad = -manager.heading.trueHeading * M_PI / 180.0f;
    float newRad = -theHeading * M_PI / 180.0f;
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    [userInfo setValue:[NSNumber numberWithFloat:oldRad] forKey:@"oldRad"];
    [userInfo setValue:[NSNumber numberWithFloat:newRad] forKey:@"newRad"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"didUpdateHeading" object:nil userInfo:userInfo];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    [[NSNotificationCenter defaultCenter] postNotificationName:QKLocationReceiveDidFailNotification
                                                        object:self
                                                      userInfo:@{@"error" : error}];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    coordinates = newLocation.coordinate;
    NSDictionary *parameters = [NSDictionary dictionaryWithObject:newLocation forKey:@"location"];
    [[NSNotificationCenter defaultCenter] postNotificationName:QKLocationChangedNotification object:self userInfo:parameters];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *newLocation = [locations lastObject];
    coordinates = newLocation.coordinate;
    NSDictionary *parameters = [NSDictionary dictionaryWithObject:newLocation forKey:@"location"];
    [[NSNotificationCenter defaultCenter] postNotificationName:QKLocationChangedNotification object:self userInfo:parameters];
}

@end

//
//  BeaconLocationManager.h
//  BeaconScanner
//
//  Created by Ralf Bernert on 07.11.13.
//  Copyright (c) 2013 Ralf Bernert. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreLocation;

@protocol BeaconLocationManagerProtocol <NSObject>

@optional
- (void)beaconsAvailableImmediate:(NSArray *)beacons;
- (void)beaconsAvailableNear:(NSArray *)beacons;
- (void)beaconsAvailableFar:(NSArray *)beacons;
- (void)noBeaconsAvailable;

@end

@interface BeaconLocationManager : NSObject <CLLocationManagerDelegate>

@property (strong, nonatomic) id<BeaconLocationManagerProtocol> delegate;

- (void)startMonitoringForRegion:(CLBeaconRegion*)region;
- (void)stopMonitoringForRegion:(CLBeaconRegion*)region;

@end

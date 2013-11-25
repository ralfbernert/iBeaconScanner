//
//  BeaconLocationManager.m
//  BeaconScanner
//
//  Created by Ralf Bernert on 07.11.13.
//  Copyright (c) 2013 Ralf Bernert. All rights reserved.
//

#import "BeaconLocationManager.h"
@import CoreLocation;


@interface BeaconLocationManager()

@property (strong, nonatomic) CLLocationManager *beaconLocationManager;

@end


@implementation BeaconLocationManager


#pragma mark - public methods

- (void)startRangingBeaconsForRegion:(CLBeaconRegion*)region
{
    if (!self.beaconLocationManager) {
        self.beaconLocationManager = [[CLLocationManager alloc] init];
        self.beaconLocationManager.delegate = self;
        self.beaconLocationManager.desiredAccuracy = kCLLocationAccuracyBest;
    }
    
    [self.beaconLocationManager startRangingBeaconsInRegion:region];
}


- (void)stopRangingBeaconsForRegion:(CLBeaconRegion*)region
{
    
    [self.beaconLocationManager stopRangingBeaconsInRegion:region];
    
}


#pragma mark - CLLocationManagerDelegate methods

- (void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region
{
    
    if ([beacons count] > 0) {

        NSLog(@"\nBeacon in region: %@", beacons);
        
        NSArray *immediateBeacons = [beacons filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"proximity = %i", CLProximityImmediate]];
        if (immediateBeacons) {
            [self.delegate beaconsAvailableImmediate:immediateBeacons];
        }
        
        NSArray *nearBeacons = [beacons filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"proximity = %i", CLProximityNear]];
        if (nearBeacons) {
            [self.delegate beaconsAvailableNear:nearBeacons];
        }
        
        NSArray *farBeacons = [beacons filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"proximity = %i", CLProximityFar]];
        if (farBeacons) {
            [self.delegate beaconsAvailableFar:farBeacons];
        }
        
    } else {
        NSLog(@"No beacons in region.");
        
        if ([self.delegate respondsToSelector:@selector(noBeaconsAvailable)]) {
            [self.delegate noBeaconsAvailable];
        }

    }
    
}


- (void)locationManager:(CLLocationManager *)manager
rangingBeaconsDidFailForRegion:(CLBeaconRegion *)region
              withError:(NSError *)error

{
    NSLog(@"Error: %@", error);
}


@end

//
//  BeaconRegion.m
//  BeaconScanner
//
//  Created by Ralf Bernert on 07.11.13.
//  Copyright (c) 2013 Ralf Bernert. All rights reserved.
//

#import "BeaconRegion.h"

static NSString *kBeaconUUID = @"09a8845d-e3d5-48d5-8544-87216d1155d0";
static NSString *kBeaconIdentifier = @"com.bernertmedia.beaconscanner";

static BeaconRegion *_sharedInstance = nil;


@implementation BeaconRegion

+ (instancetype)targetRegion {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[BeaconRegion alloc] init];
    });
    return _sharedInstance;
    
}

- (id)init {
    
    // initialize a new CLBeaconRegion with UUID and human-readable identifier
    self = [super initWithProximityUUID:[[NSUUID alloc] initWithUUIDString:kBeaconUUID]
                             identifier:kBeaconIdentifier];
    if (self) {
        
        self.notifyEntryStateOnDisplay = NO;        // only notify user if app is active
        self.notifyOnEntry = YES;                   // notify user on region entrance
        self.notifyOnExit = YES;                    // notify user on region exit
        
    }
    return self;
}

@end

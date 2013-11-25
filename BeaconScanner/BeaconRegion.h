//
//  BeaconRegion.h
//  BeaconScanner
//
//  Created by Ralf Bernert on 07.11.13.
//  Copyright (c) 2013 Ralf Bernert. All rights reserved.
//

@import CoreLocation;

@interface BeaconRegion : CLBeaconRegion

+ (instancetype)targetRegion;

@end

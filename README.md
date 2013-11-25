# iBeaconScanner

Ralf Bernert

Website: http://www.bernertmedia.com  
Twitter: [@ralfbernert](http://twitter.com/ralfbernert)  
E-Mail: ralfbernert@gmx.de


## What is it?
iBeaconScanner is a simple XCode project for scanning all iBeacons in range.

The simple iPad shows all iBeacons matching a specific UUID ordered by proximity (immediate, near, far). 

## How does it work?
Core of the scanner is the class `BeaconLocationManager` that is scanning for iBeacons matching a specific UDID. If iBeacons within a defined proximity are found one of the `BeaconLocationManagerProtocol` delegate methods is called:

```obj-c
- (void)beaconsAvailableImmediate:(NSArray *)beacons;
- (void)beaconsAvailableNear:(NSArray *)beacons;
- (void)beaconsAvailableFar:(NSArray *)beacons;
- (void)noBeaconsAvailable;
``` 

The implementation is based on CoreLocation's `CLLocationManager`.

Make sure that the scanner and the iBeacons are using the same UUID. The UUID or the identifier can be changed in the `BeaconRegion` class, a sub-class of `CLBeaconRegion` implemented as singleton:

```obj-c
static NSString *kBeaconUUID = @"09a8845d-e3d5-48d5-8544-87216d1155d0";
static NSString *kBeaconIdentifier = @"com.bernertmedia.beaconscanner";
```

Currently only one region specified by a UUID is supported. 


## iBeacon Scanner
Please see another iBeacon project, the [iBeaconSender](https://github.com/ralfbernert/iBeaconSender) for turning any iOS device into an iBeacon sender.


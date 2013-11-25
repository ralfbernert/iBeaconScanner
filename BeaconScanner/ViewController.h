//
//  ViewController.h
//  BeaconScanner
//
//  Created by Ralf Bernert on 06.11.13.
//  Copyright (c) 2013 Ralf Bernert. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BeaconLocationManager.h"

@interface ViewController : UIViewController <UITableViewDataSource, BeaconLocationManagerProtocol>

@end

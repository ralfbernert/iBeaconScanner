//
//  ViewController.m
//  BeaconScanner
//
//  Created by Ralf Bernert on 06.11.13.
//  Copyright (c) 2013 Ralf Bernert. All rights reserved.
//

#import "ViewController.h"
#import "BeaconRegion.h"

@interface ViewController ()

@property (strong, nonatomic) IBOutlet UITableView *immediateTableView;
@property (strong, nonatomic) IBOutlet UITableView *closeTableView;
@property (strong, nonatomic) IBOutlet UITableView *farTableView;

@property (strong, nonatomic) NSMutableArray *dataSourceImmediate;
@property (strong, nonatomic) NSMutableArray *dataSourceNear;
@property (strong, nonatomic) NSMutableArray *dataSourceFar;

@property (strong, nonatomic) BeaconLocationManager *beaconLocationManager;


@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.beaconLocationManager = [[BeaconLocationManager alloc] init];
    
    [self.beaconLocationManager startRangingBeaconsForRegion:[BeaconRegion targetRegion]];
    self.beaconLocationManager.delegate = self;
    
}


#pragma mark - UITableViewDatasource delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger numberOfRows = 0;
    
    if (tableView == self.immediateTableView) {
        numberOfRows = [self.dataSourceImmediate count];
    } else if (tableView == self.closeTableView) {
        numberOfRows = [self.dataSourceNear count];
    } else if (tableView == self.farTableView) {
        numberOfRows = [self.dataSourceFar count];
    }
    
    return numberOfRows;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *dataSource = nil;
    if (tableView == self.immediateTableView) {
        dataSource = self.dataSourceImmediate;
    } else if (tableView == self.closeTableView) {
        dataSource = self.dataSourceNear;
    } else if (tableView == self.farTableView) {
        dataSource = self.dataSourceFar;
    }
    
    
    NSString *identifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    CLBeacon *aBeacon = [dataSource objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"Gruppe %li - %li", (long)[aBeacon.major integerValue], (long)[aBeacon.minor integerValue]];
    
    return cell;
}

#pragma mark - BeaconLocationManager methods

- (void)beaconsAvailableImmediate:(NSArray *)beacons
{
    if (![beacons isEqualToArray:self.dataSourceImmediate]) {
        
        self.dataSourceImmediate = [NSMutableArray arrayWithArray:beacons];
        [self.immediateTableView reloadData];
    }
}


- (void)beaconsAvailableNear:(NSArray *)beacons
{
    if (![beacons isEqualToArray:self.dataSourceNear]) {
        
        self.dataSourceNear = [NSMutableArray arrayWithArray:beacons];
        [self.closeTableView reloadData];
    }
}


- (void)beaconsAvailableFar:(NSArray *)beacons
{
    if (![beacons isEqualToArray:self.dataSourceFar]) {
        
        self.dataSourceFar = [NSMutableArray arrayWithArray:beacons];
        [self.farTableView reloadData];
    }
}

@end

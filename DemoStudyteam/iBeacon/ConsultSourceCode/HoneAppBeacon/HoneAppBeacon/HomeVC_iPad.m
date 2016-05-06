//
//  HomeVC_iPad.m
//  HoneAppBeacon
//
//  Created by Tiep Nguyen on 5/22/15.
//  Copyright (c) 2015 Tiep Nguyen. All rights reserved.
//

#import "HomeVC_iPad.h"

@interface HomeVC_iPad ()
{

}
@property CLBeaconRegion * beaconRegion;
@property CBPeripheralManager * peripheralManager;
@property NSMutableDictionary * peripheralData;

@end

@implementation HomeVC_iPad

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSUUID * uid = [[NSUUID alloc] initWithUUIDString:UUID];
    NSLog(@"IBEACON REGISTER SERVICE ID: %@", @"anhtiepipad");
//    self.beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:uid identifier:@"com.honemobile1111"];
    self.beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:uid major:1 minor:2 identifier:@"anhtiepipad"];
    // When set to YES, the location manager sends beacon notifications when the user turns on the display and the device is already inside the region.
    [self.beaconRegion setNotifyEntryStateOnDisplay:YES];
    [self.beaconRegion setNotifyOnEntry:YES];
    [self.beaconRegion setNotifyOnExit:YES];
    
    [self configureTransmitter];
}

- (void)configureTransmitter {
    
    // The received signal strength indicator (RSSI) value (measured in decibels) for the device. This value represents the measured strength of the beacon from one meter away and is used during ranging. Specify nil to use the default value for the device.
    NSNumber * power = [NSNumber numberWithInt:-63];
    self.peripheralData = [self.beaconRegion peripheralDataWithMeasuredPower:power];
    
    // Get the global dispatch queue.
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    // Create a peripheral manager.
    self.peripheralManager = [[CBPeripheralManager alloc] initWithDelegate:self queue:queue];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - CBPeripheralManagerDelegate methods
-(void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral {
    
    // The peripheral is now active, this means the bluetooth adapter is all good so we can start advertising.
    if (peripheral.state == CBPeripheralManagerStatePoweredOn) {
        NSLog(@"Powered On");
        [self.peripheralManager startAdvertising:self.peripheralData];
    }
    else if (peripheral.state == CBPeripheralManagerStatePoweredOff) {
        NSLog(@"Powered Off");
        [self.peripheralManager stopAdvertising];
    }
}


@end

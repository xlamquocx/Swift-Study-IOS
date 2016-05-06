//
//  TransmitterVC.h
//  iBeaconTransmitter
//
//  Created by Tiep Nguyen on 5/25/15.
//  Copyright (c) 2015 Tiep Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import <CoreLocation/CoreLocation.h>

@interface TransmitterVC : UIViewController
<CBPeripheralManagerDelegate, CLLocationManagerDelegate>
{
    __weak IBOutlet UIImageView *ibEstimote;
}

- (IBAction)ibaSwitch:(id)sender;

@end

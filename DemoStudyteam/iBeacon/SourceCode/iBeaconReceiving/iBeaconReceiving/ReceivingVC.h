//
//  ReceivingVC.h
//  iBeaconReceiving
//
//  Created by Tiep Nguyen on 5/25/15.
//  Copyright (c) 2015 Tiep Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import <CoreLocation/CoreLocation.h>

@interface ReceivingVC : UIViewController
<CLLocationManagerDelegate>
{
    __weak IBOutlet UILabel *statusLabel;
    __weak IBOutlet UITextView *ibLogTv;
}

- (IBAction)ibaTurnOnOffBeacon:(id)sender;

@end

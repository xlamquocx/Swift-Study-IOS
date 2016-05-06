//
//  HomeVC_iPad.h
//  HoneAppBeacon
//
//  Created by Tiep Nguyen on 5/22/15.
//  Copyright (c) 2015 Tiep Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import <CoreLocation/CoreLocation.h>

@interface HomeVC_iPad : UIViewController
<CBPeripheralManagerDelegate, CLLocationManagerDelegate>

@end

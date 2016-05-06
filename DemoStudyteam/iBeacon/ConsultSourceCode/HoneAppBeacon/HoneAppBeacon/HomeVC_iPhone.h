//
//  HomeVC_iPhone.h
//  HoneAppBeacon
//
//  Created by Tiep Nguyen on 5/22/15.
//  Copyright (c) 2015 Tiep Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import <CoreLocation/CoreLocation.h>

@interface HomeVC_iPhone : UIViewController
<CLLocationManagerDelegate>
{
    __weak IBOutlet UILabel *statusLabel;
    __weak IBOutlet UITextField *ibCompanyName;
    __weak IBOutlet UIButton *isSignIn;
}

- (IBAction)ibaSignIn:(id)sender;

@end

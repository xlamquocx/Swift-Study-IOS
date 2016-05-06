//
//  ReceivingVC.m
//  iBeaconReceiving
//
//  Created by Tiep Nguyen on 5/25/15.
//  Copyright (c) 2015 Tiep Nguyen. All rights reserved.
//

#import "ReceivingVC.h"

@interface ReceivingVC ()

@property CLBeaconRegion *beaconRegion;
@property CLLocationManager *locationManager;
@property CLProximity previousProximity;

@end

@implementation ReceivingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSUUID * uid = [[NSUUID alloc] initWithUUIDString:HM_UUID];
    NSLog(@"IBEACON REGISTER SERVICE ID: %@", HM_SERVICE_ID);
    self.beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:uid identifier:HM_SERVICE_ID];
    // When set to YES, the location manager sends beacon notifications when the user turns on the display and the device is already inside the region.
    [self.beaconRegion setNotifyEntryStateOnDisplay:YES];
    [self.beaconRegion setNotifyOnEntry:YES];
    [self.beaconRegion setNotifyOnExit:YES];
    
    [self configureReceiver];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configureReceiver {
    // Location manager.
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    if ([self getCurrentiOSVersion] < 8.0) {
        [self.locationManager startUpdatingLocation];
    } else {
        [self.locationManager requestAlwaysAuthorization];
    }
    [self.locationManager startMonitoringForRegion:self.beaconRegion];
    [self.locationManager startRangingBeaconsInRegion:self.beaconRegion];
}

#pragma mark - CLLocationManagerDelegate methods
-(void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region {
    NSLog(@"Identifier Enter: %@", region.identifier);
    // See if we've entered the region.
    if ([region.identifier isEqualToString:HM_SERVICE_ID]) {
        [self showBannerNotification:@"Do you want to sign in new company?"];
    } else {
        [self showBannerNotification:[NSString stringWithFormat:@"Found other service ID [%@]", region.identifier]];
    }
    
    NSString *iBeaconInfo = [NSString stringWithFormat:@"ServiceID: %@", region.identifier];
    [self showAlertView:iBeaconInfo];
}

-(void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region {
    NSLog(@"Identifier Exit: %@", region.identifier);
    
    // See if we've exited a treasure region.
    if ([region.identifier isEqualToString:HM_SERVICE_ID]) {
        [self showBannerNotification:[NSString stringWithFormat:@"Outsite ServiceID [%@]!!!", region.identifier]];
    } else {
        [self showBannerNotification:[NSString stringWithFormat:@"Outsite ServiceID [%@]!!!", region.identifier]];
    }
    
    NSString *iBeaconInfo = [NSString stringWithFormat:@"Outsite ServiceID [%@]!!!", region.identifier];
    [self showAlertView:iBeaconInfo];
}

- (void)showAlertView:(NSString *)content {
    [[[UIAlertView alloc] initWithTitle:@"" message:content delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil] show];
}

- (void)showBannerNotification:(NSString *)content {
    UILocalNotification * notification = [[UILocalNotification alloc] init];
    notification.alertBody = content;
    notification.soundName = @"arrr.caf";
    [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
}

- (void)showLog:(NSArray *)beacons {
    NSString *log;
    NSString *major, *minor;
    NSInteger rssi;
    
    int i = 0;
    for (CLBeacon *beacon in beacons) {
        major = [beacon.major stringValue];
        minor = [beacon.minor stringValue];
        rssi = beacon.rssi;
        
        log = [NSString stringWithFormat:@"%@\n[%i]->major:%@, minor:%@, rssi:%i", (log)?log:@"", i, major, minor, rssi];
        i++;
        
    }
//    ibLogTv.text = [NSString stringWithFormat:@"%@\n\n%@", ibLogTv.text, log];
    ibLogTv.text = log;

}

- (void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region {
    NSLog(@"------Region: %@------", region);
    
    
    if ([beacons count] == 0)
        return;
    
    
    NSString * message;
    UIColor * bgColor;
    
    CLBeacon * beacon = [beacons lastObject];
    [self showLog:beacons];
    NSLog(@"Identifier Range: %@", beacons);
    NSLog(@"<<<proximityUUID = %@>>>",beacon.proximityUUID.UUIDString);
    switch (beacon.proximity) {
        case CLProximityUnknown:
            message = @"Long distance. There be no iBeacon in me vicinity";
            bgColor = [UIColor blueColor];
            break;
        case CLProximityFar:
            message = @"Far distance. We are dying..";
            bgColor = [UIColor greenColor];
            break;
        case CLProximityNear:
            message = @"Near distance. This is an excellent sign.";
            bgColor = [UIColor orangeColor];
            break;
        case CLProximityImmediate:
        default:
            message = @"Immediate distance. So cool!";
            bgColor = [UIColor redColor];
            break;
    }
    
    if (beacon.proximity != self.previousProximity) {
        [self speak:message];
        [statusLabel setText:message];
        [self.view setBackgroundColor:bgColor];
        self.previousProximity = beacon.proximity;
    }
}

#pragma mark - Speech Methods
- (void)speak:(NSString*)message {
    AVSpeechSynthesizer * synth = [[AVSpeechSynthesizer alloc] init];
    
    AVSpeechUtterance * utterance = [[AVSpeechUtterance alloc] initWithString:message];
    [utterance setRate:AVSpeechUtteranceMaximumSpeechRate *.3f];
    [utterance setVolume:1.0f];
    [utterance setPitchMultiplier:0.7f];
    [utterance setVoice:[AVSpeechSynthesisVoice voiceWithLanguage:@"en-IE"]];
    
    [synth speakUtterance:utterance];
}

#pragma mark - Other -
- (float)getCurrentiOSVersion {
    return [[[UIDevice currentDevice] systemVersion] floatValue];
}


- (IBAction)ibaTurnOnOffBeacon:(id)sender {
    UISwitch *ibSwitch = (UISwitch *)sender;
    
    if (ibSwitch.on) {
        NSLog(@"Turn on");
        [self.locationManager startMonitoringForRegion:self.beaconRegion];
        [self.locationManager startRangingBeaconsInRegion:self.beaconRegion];
    } else {
        NSLog(@"Turn off");
        [self.locationManager stopMonitoringForRegion:self.beaconRegion];
        [self.locationManager stopRangingBeaconsInRegion:self.beaconRegion];
    }
}
@end

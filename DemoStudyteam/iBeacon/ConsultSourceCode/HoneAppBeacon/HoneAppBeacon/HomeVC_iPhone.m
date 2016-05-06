//
//  HomeVC_iPhone.m
//  HoneAppBeacon
//
//  Created by Tiep Nguyen on 5/22/15.
//  Copyright (c) 2015 Tiep Nguyen. All rights reserved.
//

#import "HomeVC_iPhone.h"

@interface HomeVC_iPhone ()
{
}
@property CLBeaconRegion *beaconRegion;
@property CLLocationManager *locationManager;
@property CLProximity previousProximity;

@end

@implementation HomeVC_iPhone

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSUUID * uid = [[NSUUID alloc] initWithUUIDString:UUID];
    NSLog(@"IBEACON REGISTER SERVICE ID: %@", SERVICE_ID);
    self.beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:uid identifier:SERVICE_ID];
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
    if ([region.identifier isEqualToString:SERVICE_ID]) {
        [self showBannerNotification:([self isSignIn])?[NSString stringWithFormat:@"Do you want to sign out from %@ company?", ibCompanyName.text]:@"Do you want to sign in new company?"];
    } else {
        [self showBannerNotification:[NSString stringWithFormat:@"Found other service ID [%@]", region.identifier]];
    }
    
    NSString *iBeaconInfo = [NSString stringWithFormat:@"ServiceID: %@", region.identifier];
    [self showAlertView:iBeaconInfo];
}

-(void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region {
    NSLog(@"Identifier Exit: %@", region.identifier);

    // See if we've exited a treasure region.
    if ([region.identifier isEqualToString:SERVICE_ID]) {
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

- (void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region {
//    NSLog(@"------Manager: %@------", manager);

    NSLog(@"------Region: %@------", region);
    
    
    if ([beacons count] == 0)
        return;
    

    NSString * message;
    UIColor * bgColor;
    
    CLBeacon * beacon = [beacons lastObject];
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

- (IBAction)ibaSignIn:(id)sender {
    UIButton *signInBtn = (UIButton *)sender;
    if ([self isSignIn]) {
        [signInBtn setTitle:@"Sign In on" forState:UIControlStateNormal];
    } else {
        [signInBtn setTitle:@"Sign Out of" forState:UIControlStateNormal];
    }
}

- (BOOL)isSignIn {
    return !([isSignIn.titleLabel.text isEqualToString:@"Sign In on"]);
}
@end

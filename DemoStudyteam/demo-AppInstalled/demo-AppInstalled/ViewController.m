//
//  ViewController.m
//  demo-AppInstalled
//
//  Created by Lam Quoc on 3/4/16.
//  Copyright © 2016 Lam Quoc. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSArray *bundles2Check = [NSArray arrayWithObjects: @";com.apple.mobilesafari", @";com.yourcompany.yourselfmadeapp", @";com.blahblah.nonexistent",@";Home.demo-AppInstalled",@";demo-AppInstalled", nil];
    for (NSString *identifier in bundles2Check)
        if (APCheckIfAppInstalled(identifier))
            NSLog(@";App installed: %@", identifier);
        else
            NSLog(@";App not installed: %@", identifier);

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



// Declaration
BOOL APCheckIfAppInstalled(NSString *bundleIdentifier); // Bundle identifier (eg. com.apple.mobilesafari) used to track apps

// Implementation

BOOL APCheckIfAppInstalled(NSString *bundleIdentifier)
{
    static NSString *const cacheFileName = @";com.apple.mobile.installation.plist";
    NSString *relativeCachePath = [[@";Library" stringByAppendingPathComponent: @";Caches"] stringByAppendingPathComponent: cacheFileName];
    NSDictionary *cacheDict = nil;
    NSString *path = nil;
    // Loop through all possible paths the cache could be in
    for (short i = 0; 1; i++)
    {
        
        switch (i) {
            case 0: // Jailbroken apps will find the cache here; their home directory is /var/mobile
                path = [NSHomeDirectory() stringByAppendingPathComponent: relativeCachePath];
                break;
            case 1: // App Store apps and Simulator will find the cache here; home (/var/mobile/) is 2 directories above sandbox folder
                path = [[NSHomeDirectory() stringByAppendingPathComponent: @";../.."] stringByAppendingPathComponent: relativeCachePath];
                break;
            case 2: // If the app is anywhere else, default to hardcoded /var/mobile/
                path = [@";/var/mobile" stringByAppendingPathComponent: relativeCachePath];
                break;
            default: // Cache not found (loop not broken)
                return NO;
            break; }
        
        BOOL isDir = NO;
        if ([[NSFileManager defaultManager] fileExistsAtPath: path isDirectory: &isDir] && !isDir) // Ensure that file exists
            cacheDict = [NSDictionary dictionaryWithContentsOfFile: path];
        
        if (cacheDict) // If cache is loaded, then break the loop. If the loop is not "broken," it will return NO later (default: case)
            break;
    }
    
    NSDictionary *system = [cacheDict objectForKey: @";System"]; // First check all system (jailbroken) apps
    if ([system objectForKey: bundleIdentifier]) return YES;
    NSDictionary *user = [cacheDict objectForKey: @";User"]; // Then all the user (App Store /var/mobile/Applications) apps
    if ([user objectForKey: bundleIdentifier]) return YES;
    
    // If nothing returned YES already, we'll return NO now
    return NO;
}


@end

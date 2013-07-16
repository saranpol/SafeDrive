//
//  SDAppDelegate.m
//  SafeDrive
//
//  Created by saranpol on 7/16/56 BE.
//  Copyright (c) 2556 saranpol. All rights reserved.
//

#import "SDAppDelegate.h"
#import "SDViewController.h"

@implementation SDAppDelegate


@synthesize mLocationManager;

//static UIBackgroundTaskIdentifier bgTask;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[UIApplication sharedApplication] setStatusBarHidden:NO];

    self.mLocationManager = [[CLLocationManager alloc] init];
    [mLocationManager setDelegate:self];
    [mLocationManager setDesiredAccuracy:kCLLocationAccuracyBestForNavigation];
    //[mLocationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    //[mLocationManager startMonitoringSignificantLocationChanges];
    [mLocationManager startUpdatingLocation];

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    
}
    
- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.

}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.

}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}







- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"didFailWithError: %@", error);
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    CLLocation *loc = [locations lastObject];
    if(!loc)
        return;
    
    BOOL isInBackground = NO;
    if ([UIApplication sharedApplication].applicationState == UIApplicationStateBackground
        || [UIApplication sharedApplication].applicationState == UIApplicationStateInactive)
        isInBackground = YES;
    
    float speed = loc.speed*3600.0/1000.0;
    if(speed < 0)
        speed = 0;
    
    if (isInBackground) {
        NSLog(@"background speed %.2f", speed);
        if(speed > 15.0)
            [self sendLocalPush];
        
    }else{
        NSLog(@"foreground speed %.2f", speed);
        SDViewController *vc = (SDViewController*)self.window.rootViewController;
        [vc.mLabelSpeed setText:[NSString stringWithFormat:@"%.0f", speed]];
        float p = speed/15.0;
        if(p > 1.0)
            p = 1.0;
        if(p <= 0.0)
            p = 0.001;
        [vc setProgress:p];
        if(speed > 15.0)
            [vc showLock];
        else
            [vc hideLock];
    }
    
}


- (void)sendLocalPush {
    UILocalNotification *localNotif = [[UILocalNotification alloc] init];
    localNotif.fireDate = [NSDate date];;
    localNotif.alertBody = @"ควรหยุดใช้การพิมพ์ข้อความ";
    localNotif.alertAction = @"View";
    localNotif.soundName = UILocalNotificationDefaultSoundName;
    
	// Specify custom data for the notification
    //NSDictionary *infoDict = [NSDictionary dictionaryWithObject:@"someValue" forKey:@"someKey"];
    //localNotif.userInfo = infoDict;
    
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotif];
}





@end

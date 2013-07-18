//
//  SDAppDelegate.h
//  SafeDrive
//
//  Created by saranpol on 7/16/56 BE.
//  Copyright (c) 2556 saranpol. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface SDAppDelegate : UIResponder <UIApplicationDelegate, CLLocationManagerDelegate>


@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, strong) CLLocationManager *mLocationManager;
@property (nonatomic, strong) NSDate *mLastTimeSendPush;

@end

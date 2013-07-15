//
//  SDViewController.m
//  SafeDrive
//
//  Created by saranpol on 7/16/56 BE.
//  Copyright (c) 2556 saranpol. All rights reserved.
//

#import "SDViewController.h"

@implementation SDViewController

@synthesize mLabelSpeed;
@synthesize mViewLock;


- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


- (void)showLock {
    if(![mViewLock isHidden])
        return;
    
    [mViewLock setHidden:NO];
    [mViewLock setAlpha:0.0];
    [UIView animateWithDuration:0.3 animations:^{
        [mViewLock setAlpha:1.0];
    }];
}

- (void)hideLock {
    if([mViewLock isHidden])
        return;

    [mViewLock setAlpha:1.0];
    [UIView animateWithDuration:0.3 animations:^{
        [mViewLock setAlpha:0.0];
    }completion:^(BOOL finished){
        [mViewLock setHidden:YES];
    }];

    
}


@end

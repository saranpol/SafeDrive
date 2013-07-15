//
//  SDViewController.h
//  SafeDrive
//
//  Created by saranpol on 7/16/56 BE.
//  Copyright (c) 2556 saranpol. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SDViewController : UIViewController

@property (nonatomic, weak) IBOutlet UILabel *mLabelSpeed;
@property (nonatomic, weak) IBOutlet UIView *mViewLock;

- (void)showLock;
- (void)hideLock;

@end

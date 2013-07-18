//
//  SDViewController.h
//  SafeDrive
//
//  Created by saranpol on 7/16/56 BE.
//  Copyright (c) 2556 saranpol. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewCircle.h"

@interface SDViewController : UIViewController

@property (nonatomic, weak) IBOutlet UILabel *mLabelSpeed;
@property (nonatomic, weak) IBOutlet UILabel *mLabelKMH;
@property (nonatomic, weak) IBOutlet UILabel *mLabelSpeedText;
@property (nonatomic, weak) IBOutlet UILabel *mLabelAlert;
@property (nonatomic, weak) IBOutlet UILabel *mLabelAlert1;
@property (nonatomic, weak) IBOutlet UILabel *mLabelAlert2;
@property (nonatomic, weak) IBOutlet UILabel *mLabelAlert3;
@property (nonatomic, weak) IBOutlet UIView *mViewLock;
@property (nonatomic, weak) IBOutlet UIView *mViewBG;
@property (nonatomic, weak) IBOutlet ViewCircle *mViewCircle;
@property (nonatomic, weak) IBOutlet UIImageView *mImageAlert;

- (void)showLock;
- (void)hideLock;
- (void)setProgress:(float)p;


@end

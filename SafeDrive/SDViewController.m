//
//  SDViewController.m
//  SafeDrive
//
//  Created by saranpol on 7/16/56 BE.
//  Copyright (c) 2556 saranpol. All rights reserved.
//

#import "SDViewController.h"
#import <QuartzCore/QuartzCore.h>

@implementation SDViewController

@synthesize mLabelSpeed;
@synthesize mLabelKMH;
@synthesize mLabelSpeedText;
@synthesize mLabelAlert;
@synthesize mLabelAlert1;
@synthesize mLabelAlert2;
@synthesize mLabelAlert3;
@synthesize mViewLock;
@synthesize mViewBG;
@synthesize mViewCircle;


- (void)viewDidLoad
{
    static NSString *f = @"DBHelvethaicaMonX-Cond";
    [super viewDidLoad];
    
    [mLabelSpeed setFont:[UIFont fontWithName:f size:mLabelSpeed.font.pointSize]];
    [mLabelKMH setFont:[UIFont fontWithName:f size:mLabelKMH.font.pointSize]];
    [mLabelSpeedText setFont:[UIFont fontWithName:f size:mLabelSpeedText.font.pointSize]];
    
    NSMutableAttributedString *s = [[NSMutableAttributedString alloc] initWithAttributedString:mLabelAlert.attributedText];
    // OVER 15 km/h
    // index, length
    //OVER 0, 4
    [s addAttribute:NSFontAttributeName value:[UIFont fontWithName:f size:70.0] range:NSMakeRange(0, 4)];
    //     4, 1
    [s addAttribute:NSFontAttributeName value:[UIFont fontWithName:f size:20.0] range:NSMakeRange(4, 1)];
    // 15  5, 2
    [s addAttribute:NSFontAttributeName value:[UIFont fontWithName:f size:114.0] range:NSMakeRange(5, 2)];
    //     7, 1
    [s addAttribute:NSFontAttributeName value:[UIFont fontWithName:f size:20.0] range:NSMakeRange(7, 1)];
    // km/h 8, 4
    [s addAttribute:NSFontAttributeName value:[UIFont fontWithName:f size:30.0] range:NSMakeRange(8, 4)];
    [mLabelAlert setAttributedText:s];
    

    
    [mLabelAlert1 setFont:[UIFont fontWithName:f size:mLabelAlert1.font.pointSize]];
    [mLabelAlert2 setFont:[UIFont fontWithName:f size:mLabelAlert2.font.pointSize]];
    [mLabelAlert3 setFont:[UIFont fontWithName:f size:mLabelAlert3.font.pointSize]];
    
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

- (void)animateProgress:(NSNumber*)p {
    if(mViewCircle.mProgress > [p floatValue]) {
        mViewCircle.mProgress -= (mViewCircle.mProgress - [p floatValue])/20.0;
        [mViewCircle setNeedsDisplay];
        [self performSelector:@selector(animateProgress:) withObject:p afterDelay:.01];
    }else if(mViewCircle.mProgress < [p floatValue]){
        mViewCircle.mProgress += -(mViewCircle.mProgress - [p floatValue])/20.0;
        [mViewCircle setNeedsDisplay];
        [self performSelector:@selector(animateProgress:) withObject:p afterDelay:.01];
    }
}



- (void)setProgress:(float)p {
    static float s0 = 0.0;
    static float s1 = 1.0/3.0;
    static float s2 = 2.0/3.0;
    static float s3 = 1.0;
    [mLabelSpeed.layer removeAllAnimations];
    [mViewBG.layer removeAllAnimations];
    [UIView animateWithDuration:0.3 animations:^{
//        0 -> 106 166 179
//        5/15 -> 157 217 169
//        10/15 -> 251 210 112
//        15/15 -> 197 46 71
        
        UIColor *c;
        if(p >= s0 && p < s1){
            float k = (p-s0)/(s1-s0);
            float r = 106.0*(1.0-k) + 157.0*k;
            float g = 166.0*(1.0-k) + 217.0*k;
            float b = 179.0*(1.0-k) + 169.0*k;
            c = [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0];
        }else if(p >= s1 && p < s2){
            float k = (p-s1)/(s2-s1);
            float r = 157.0*(1.0-k) + 251.0*k;
            float g = 217.0*(1.0-k) + 210.0*k;
            float b = 169.0*(1.0-k) + 112.0*k;
            c = [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0];
        }else {//if(p >= s2 && p < s3){
            float k = (p-s2)/(s3-s2);
            float r = 251.0*(1.0-k) + 197.0*k;
            float g = 210.0*(1.0-k) + 46.0*k;
            float b = 112.0*(1.0-k) + 71.0*k;
            c = [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0];
        }
        
        [mLabelSpeed setTextColor:c];
        [mViewBG setBackgroundColor:c];
        
    }];
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [self animateProgress:[NSNumber numberWithFloat:p]];
}

@end

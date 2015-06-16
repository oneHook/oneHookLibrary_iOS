//
//  OHConfettiScreen.h
//  Challenger
//
//  Created by Eagle Diao on 2015-05-29.
//  Copyright (c) 2015 Eagle Diao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OHConfettiScreen : UIView

- (void)setConfettiImage:(UIImage*)image;
- (void)setColors:(NSArray*)colors;

- (void) startEmitting;
- (void) decayOverTime:(NSTimeInterval)interval;
- (void) stopEmitting;

@end

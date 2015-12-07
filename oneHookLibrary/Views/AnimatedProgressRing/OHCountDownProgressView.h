//
//  OHCountDownProgressView.h
//  oneHookLibrary
//
//  Created by Eagle Diao on 2015-12-07.
//  Copyright © 2015 oneHook inc. All rights reserved.
//

#import "OHAnimatedProgressRing.h"

@interface OHCountDownProgressView : OHAnimatedProgressRing

@property (assign, nonatomic) double secondsToCountDown;

-(void)start;

@end

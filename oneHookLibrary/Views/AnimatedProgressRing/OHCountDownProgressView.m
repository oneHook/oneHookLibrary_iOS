//
//  OHCountDownProgressView.m
//  oneHookLibrary
//
//  Created by Eagle Diao on 2015-12-07.
//  Copyright © 2015 oneHook inc. All rights reserved.
//

#import "OHCountDownProgressView.h"

#define kDefaultFireIntervalHighUse  0.02

@interface OHCountDownProgressView() {
    double _startTime;
}

@property (strong) NSTimer *timer;

@end

@implementation OHCountDownProgressView

-(void)start{
    
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:kDefaultFireIntervalHighUse
                                              target:self
                                            selector:@selector(updateProgress)
                                            userInfo:nil
                                             repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    _startTime = CACurrentMediaTime();
    [_timer fire];
}

- (void)updateProgress
{
    double currTime = CACurrentMediaTime();
    double past = currTime - _startTime;
    CGFloat progress = past / self.secondsToCountDown;
    self.progress = progress;
    if(progress >= 1.0) {
        if(_timer) {
            [_timer invalidate];
            _timer = nil;
            NSLog(@"end");
        }
    }
    NSLog(@"progress %f", progress);
}


@end

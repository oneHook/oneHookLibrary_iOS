//
//  CircularRevealAnimationController.h
//  Challenger
//
//  Created by Eagle Diao on 2014-09-05.
//  Copyright (c) 2014 oneHook inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface OHCircularRevealAnimationController
    : NSObject <UIViewControllerAnimatedTransitioning>

@property (assign, nonatomic) BOOL isPresenting;
@property (assign, nonatomic) CGRect buttonPosition;
@property (assign, nonatomic) double animationDuration;
@property (strong, nonatomic) CAMediaTimingFunction *timingFunction;

@end

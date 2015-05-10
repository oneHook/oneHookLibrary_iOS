//
//  OHRotatingRevealAnimationController.h
//  oneHookLibrary
//
//  Created by Eagle Diao on 2015-05-10.
//  Copyright (c) 2015 oneHook inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface OHRotatingRevealAnimationController : NSObject <UIViewControllerAnimatedTransitioning>

@property (assign, nonatomic) BOOL isPresenting;
@property (assign, nonatomic) double animationDuration;
@property (strong, nonatomic) CAMediaTimingFunction *timingFunction;

@end

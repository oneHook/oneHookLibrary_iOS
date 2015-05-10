//
//  OHRotatingRevealAnimationController.m
//  oneHookLibrary
//
//  Created by Eagle Diao on 2015-05-10.
//  Copyright (c) 2015 oneHook inc. All rights reserved.
//

#import "OneHookFoundation.h"
#import "OHRotatingRevealAnimationController.h"

@implementation OHRotatingRevealAnimationController

- (id)init {
    self = [super init];
    if (self) {
        self.animationDuration = 0.25f;
    }
    return self;
}

- (NSTimeInterval)transitionDuration:
        (id<UIViewControllerContextTransitioning>)transitionContext {
    return OHAnimationLong;
}

- (void)animateTransition:
        (id<UIViewControllerContextTransitioning>)transitionContext {
    if (self.isPresenting) {
        [self executePresentationAnimation:transitionContext];
    } else {
        [self executeDismissalAnimation:transitionContext];
    }
}

- (void)executePresentationAnimation:
        (id<UIViewControllerContextTransitioning>)transitionContext {
    UIView *inView = [transitionContext containerView];

    UIViewController *toViewController = [transitionContext
        viewControllerForKey:UITransitionContextToViewControllerKey];
    toViewController.view.bounds = inView.bounds;
    [inView addSubview:toViewController.view];

    toViewController.view.layer.anchorPoint = CGPointMake(1.0f, 0.0f);
    toViewController.view.center = CGPointMake(inView.bounds.size.width, 0);
    toViewController.view.transform = CGAffineTransformMakeRotation(-M_PI);
    [UIView animateWithDuration:self.animationDuration animations:^{
        toViewController.view.transform = CGAffineTransformIdentity;

    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}

- (void)executeDismissalAnimation:
        (id<UIViewControllerContextTransitioning>)transitionContext {

    UIView *inView = [transitionContext containerView];
    UIViewController *toViewController = [transitionContext
        viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromViewController = [transitionContext
        viewControllerForKey:UITransitionContextFromViewControllerKey];

    [inView insertSubview:toViewController.view
             belowSubview:fromViewController.view];

    fromViewController.view.layer.anchorPoint = CGPointMake(1.0f, 0.0f);
    fromViewController.view.center = CGPointMake(inView.bounds.size.width, 0);
    fromViewController.view.transform = CGAffineTransformIdentity;

    [UIView animateWithDuration:self.animationDuration animations:^{
        
        fromViewController.view.transform = CGAffineTransformMakeRotation(-M_PI);
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}

@end

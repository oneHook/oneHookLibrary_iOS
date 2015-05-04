
//
//  CircularRevealAnimationController.m
//  Challenger
//
//  Created by Eagle Diao on 2014-09-05.
//  Copyright (c) 2014 oneHook inc. All rights reserved.
//

#import "OneHookFoundation.h"
#import "OHCircularRevealAnimationController.h"

@implementation OHCircularRevealAnimationController

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
    toViewController.view.frame = inView.bounds;
    [inView addSubview:toViewController.view];

    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    CGRect maskRect = self.buttonPosition;
    CGPathRef path = CGPathCreateWithRoundedRect(
        maskRect, maskRect.size.width / 2, maskRect.size.height / 2, NULL);
    maskLayer.path = path;
    CGPathRelease(path);
    toViewController.view.layer.mask = maskLayer;

    CGFloat height = inView.bounds.size.height * 3.25;
    maskRect.size.width = height;
    maskRect.size.height = height;
    maskRect.origin.x = inView.bounds.size.width / 2 - height / 2;
    maskRect.origin.y = inView.bounds.size.height / 2 - height / 2;

    CGPathRef newPath = CGPathCreateWithRoundedRect(
        maskRect, maskRect.size.width / 2, maskRect.size.height / 2, NULL);

    CGPathRef oldPath = maskLayer.path;
    CGPathRetain(oldPath);
    maskLayer.path = newPath;

    [CATransaction begin];
    [CATransaction setAnimationDuration:self.animationDuration];
    [CATransaction setCompletionBlock:^{
    CGPathRelease(oldPath);
    [transitionContext completeTransition:YES];
    }];
    CABasicAnimation *ba = [CABasicAnimation animationWithKeyPath:@"path"];
    if (self.timingFunction) {
        ba.timingFunction = self.timingFunction;
    }
    ba.fillMode = kCAFillModeForwards;
    ba.fromValue = (__bridge id)oldPath;
    ba.toValue = (__bridge id)newPath;
    ba.removedOnCompletion = YES;
    [maskLayer addAnimation:ba forKey:@"animatePath"];

    [CATransaction commit];
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

    CGRect maskRect = self.buttonPosition;
    CGPathRef newPath = CGPathCreateWithRoundedRect(
        maskRect, maskRect.size.width / 2, maskRect.size.height / 2, NULL);
    CGPathRetain(newPath);

    CGFloat height = inView.bounds.size.height * 2;
    maskRect.size.width = height;
    maskRect.size.height = height;
    maskRect.origin.x = inView.bounds.size.width / 2 - height / 2;
    maskRect.origin.y = inView.bounds.size.height / 2 - height / 2;
    CGPathRef oldPath = CGPathCreateWithRoundedRect(
        maskRect, maskRect.size.width / 2, maskRect.size.height / 2, NULL);
    CGPathRetain(oldPath);

    CAShapeLayer *layer = (CAShapeLayer *)fromViewController.view.layer.mask;
    layer.path = newPath;

    [CATransaction begin];
    [CATransaction setAnimationDuration:self.animationDuration];
    [CATransaction setCompletionBlock:^{
    CGPathRelease(newPath);
    CGPathRelease(oldPath);
    [transitionContext completeTransition:YES];
    if ([UIApplication sharedApplication].keyWindow.subviews.count == 0) {
      [[UIApplication sharedApplication].keyWindow
          addSubview:toViewController.view];
    }
    }];
    CABasicAnimation *ba = [CABasicAnimation animationWithKeyPath:@"path"];

    if (self.timingFunction) {
        ba.timingFunction = self.timingFunction;
    }
    ba.fillMode = kCAFillModeForwards;
    ba.fromValue = (__bridge id)oldPath;
    ba.toValue = (__bridge id)newPath;
    ba.removedOnCompletion = YES;
    [layer addAnimation:ba forKey:@"path"];

    [CATransaction commit];
}

@end

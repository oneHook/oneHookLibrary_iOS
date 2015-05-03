//
//  CustomScrollView.m
//  oneHookLibrary
//
//  Created by Eagle Diao on 2015-05-01.
//  Copyright (c) 2015 oneHook inc. All rights reserved.
//

#import "OHHorizontalScrollView.h"

@implementation OHHorizontalScrollView

#pragma marks - UIGesture

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {

    // If the gesture is a pan, determine whether it starts out more
    // horizontal than vertical than act accordingly
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {

        UIPanGestureRecognizer *panGestureRecognizer = (UIPanGestureRecognizer *)gestureRecognizer;
        CGPoint velocity = [panGestureRecognizer velocityInView:self];

        if (gestureRecognizer == self.panGestureRecognizer) {
            // For the vertical scrollview, if it's more vertical than
            // horizontal, return true; else false
            return fabs(velocity.y) < fabs(velocity.x);
        } else {
            // For the horizontal pan view, if it's more horizontal than
            // vertical, return true; else false
            return fabs(velocity.y) > fabs(velocity.x);
        }
    } else {
        return YES;
    }
}

@end

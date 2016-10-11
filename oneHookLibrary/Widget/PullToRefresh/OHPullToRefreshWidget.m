//
//  OHPullToRefreshWidget.m
//  oneHookLibrary
//
//  Created by Eagle Diao@ToMore on 2016-10-04.
//  Copyright © 2016 oneHook inc. All rights reserved.
//

#import "OHPullToRefreshWidget.h"

@interface OHPullToRefreshWidget() {
    
}

@property (assign, nonatomic) BOOL inRefresh;
@property (assign, nonatomic) CGFloat pullToRefreshOffsetRatio;

@end

@implementation OHPullToRefreshWidget

- (id)init
{
    self = [super init];
    if(self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit
{
    self.pullToRefreshOffsetRatio = 0.12f;
}

- (void)didScroll:(UIScrollView*)scrollView
{
    if(self.inRefresh) {
        return;
    }
//    NSLog(@"Scroll view %f %f", scrollView.contentInset.top, scrollView.contentOffset.y);
    
    if(scrollView.contentOffset.y < scrollView.contentInset.top) {
        CGFloat offsetNeeded = CGRectGetHeight(scrollView.frame) * self.pullToRefreshOffsetRatio;
        CGFloat offsetTraveled = -(scrollView.contentInset.top + scrollView.contentOffset.y);
        CGFloat progress = offsetTraveled / offsetNeeded;
        
        [self.delegate willStartPullToRefresh:MIN(1, progress) starting:NO];
//        NSLog(@"offset needed %f offset traveled %f progress %f", offsetNeeded, offsetTraveled, progress);
    }
}

- (void)didEndDragging:(UIScrollView *)scrollView decelerating:(BOOL)shouldDecelerating
{
    if(self.inRefresh) {
        return;
    }
    
//    NSLog(@"Scroll view end dragging %f %f", scrollView.contentInset.top, scrollView.contentOffset.y);
    if(scrollView.contentOffset.y < scrollView.contentInset.top) {
        CGFloat offsetNeeded = CGRectGetHeight(scrollView.frame) * self.pullToRefreshOffsetRatio;
        CGFloat offsetTraveled = -(scrollView.contentInset.top + scrollView.contentOffset.y);
        CGFloat progress = offsetTraveled / offsetNeeded;
        if(progress > 1) {
            [self.delegate willStartPullToRefresh:1.0f starting:YES];
            self.inRefresh = YES;
        }
//        NSLog(@"offset needed %f offset traveled %f progress %f", offsetNeeded, offsetTraveled, progress);
    }
    
    if(!shouldDecelerating && self.inRefresh) {
        [self.delegate shouldStartRefresh];
    }
}

- (void)didEndDecelerating
{
    if(self.inRefresh) {
        [self.delegate shouldStartRefresh];
    }
}

- (void)endRefreshing
{
    self.inRefresh = NO;
}

@end

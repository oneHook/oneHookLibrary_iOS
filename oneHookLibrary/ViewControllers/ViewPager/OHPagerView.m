//
//  OHPagerViewController.m
//  oneHookLibrary
//
//  Created by Eagle Diao on 2015-04-30.
//  Copyright (c) 2015 oneHook inc. All rights reserved.
//

#import "OHPagerView.h"

#define PAGE_WIDTH self.bounds.size.width

@interface OHPagerView () {
    BOOL _sized;
}

@property (strong, nonatomic) NSMutableArray *views;

@end

@implementation OHPagerView

- (id)init {
    self = [super init];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    _sized = NO;
    self.scrollView = [[OHHorizontalScrollView alloc] init];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.delegate = self;

    [self addSubview:self.scrollView];

    self.backgroundColor = [UIColor whiteColor];

    self.selectedIndex = 0;
}

- (void)setDatasource:(id<OHPagerViewDatasource>)datasource {
    _datasource = datasource;
    [self reloadData];
}

- (void)reloadData {
    if (self.datasource == nil || !_sized) {
        return;
    }
    if (self.views == nil) {
        self.views = [[NSMutableArray alloc] init];
    }
    for (int i = 0; i < self.views.count; i++) {
        UIView *view = [self.views objectAtIndex:i];
        if (![view isEqual:[NSNull null]]) {
            [self.delegate pagerView:self viewPurgedAt:i];
            [view removeFromSuperview];
        }
    }
    NSInteger numPages = [self.datasource numberOfPagesInPager:self];
    for (int i = 0; i < numPages; i++) {
        [self.views addObject:[NSNull null]];
    }
}

- (void)gotoPageAtIndex:(NSInteger)index animated:(BOOL)animated {
    self.selectedIndex = index;
    [self.scrollView setContentOffset:CGPointMake(index * PAGE_WIDTH, 0) animated:animated];
}

- (void)layoutSubviews {
    [self onSizeChanged];
    [self.scrollView setContentOffset:CGPointMake(self.selectedIndex * PAGE_WIDTH, 0) animated:NO];
}

- (void)onSizeChanged {
    if (!_sized) {
        _sized = YES;
        [self reloadData];
    }
    self.scrollView.frame = self.bounds;
    NSInteger numPages = [self.datasource numberOfPagesInPager:self];
    self.scrollView.contentSize = CGSizeMake(self.bounds.size.width * numPages, self.bounds.size.height);
    for (int i = 0; i < numPages; i++) {
        if (![[self.views objectAtIndex:i] isEqual:[NSNull null]]) {
            UIView *view = [self.views objectAtIndex:i];
            view.frame = CGRectMake(PAGE_WIDTH * i, 0, PAGE_WIDTH, self.bounds.size.height);
        }
    }
    [self invalidatePages:self.selectedIndex];
}

- (void)invalidatePages:(NSInteger)currIndex {
    NSInteger totalPages = [self.datasource numberOfPagesInPager:self];
    for (int i = 0; i < totalPages; i++) {
        if (i == currIndex - 1) {
            if ([[self.views objectAtIndex:i] isEqual:[NSNull null]]) {
                [self loadViewAt:i];
            }
        } else if (i == currIndex) {
            if ([[self.views objectAtIndex:i] isEqual:[NSNull null]]) {
                [self loadViewAt:i];
            }
        } else if (i == currIndex + 1) {
            if ([[self.views objectAtIndex:i] isEqual:[NSNull null]]) {
                [self loadViewAt:i];
            }
        } else {
            if (![[self.views objectAtIndex:i] isEqual:[NSNull null]]) {
                [self purgeViewAt:i];
            }
        }
    }
}

- (void)purgeViewAt:(NSInteger)index {
    UIView *v = [self.views objectAtIndex:index];
    if (![v isEqual:[NSNull null]]) {
        [v removeFromSuperview];
        [self.views replaceObjectAtIndex:index withObject:[NSNull null]];
        [self.delegate pagerView:self viewPurgedAt:index];
    }
}

- (void)loadViewAt:(NSInteger)index {
    UIView *view = [self.datasource pagerView:self viewControllerAtIndex:index];
    [self.scrollView addSubview:view];
    view.frame = CGRectMake(PAGE_WIDTH * index, 0, PAGE_WIDTH, self.bounds.size.height);
    [self.views replaceObjectAtIndex:index withObject:view];
    [self.delegate pagerView:self viewAddedAt:index];
}

#pragma marks - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (!_sized) {
        return;
    }
    NSInteger currIndex = roundf(scrollView.contentOffset.x / PAGE_WIDTH);
    [self invalidatePages:currIndex];
}

@end

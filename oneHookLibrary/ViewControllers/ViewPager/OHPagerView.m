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
@property (strong, nonatomic) UIScrollView *scrollView;

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
    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.delegate = self;

    [self addSubview:self.scrollView];

    self.backgroundColor = [UIColor whiteColor];

    self.selectedIndex = 0;

    //    [self reloadData];
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
    /* TODO may want to purge all existing vcs */
    //    [self.views removeAllObjects];
    NSInteger numPages = [self.datasource numberOfPagesInPager:self];
    for (int i = 0; i < numPages; i++) {
        [self.views addObject:[NSNull null]];
    }
    self.scrollView.contentOffset = CGPointMake(PAGE_WIDTH * self.selectedIndex, 0);
    [self invalidatePages:self.selectedIndex];
}

- (void)gotoPageAtIndex:(NSInteger)index animated:(BOOL)animated {
    [self.scrollView setContentOffset:CGPointMake(index * PAGE_WIDTH, 0) animated:animated];
}

- (void)layoutSubviews {
    self.scrollView.frame = self.bounds;
    [self onSizeChanged];
}

- (void)onSizeChanged {
    _sized = YES;
    NSInteger numPages = [self.datasource numberOfPagesInPager:self];
    self.scrollView.contentSize = CGSizeMake(self.bounds.size.width * numPages, 0);
    [self reloadData];
}

- (void)invalidatePages:(NSInteger)currIndex {
    NSLog(@"invalidate pages %@ %@", self, self.views);
    NSInteger totalPages = [self.datasource numberOfPagesInPager:self];
    for (int i = 0; i < totalPages; i++) {
        if (i == currIndex - 1) {
            if ([[self.views objectAtIndex:i] isEqual:[NSNull null]]) {
                [self loadViewControllerAt:i];
            }
        } else if (i == currIndex) {
            if ([[self.views objectAtIndex:i] isEqual:[NSNull null]]) {
                [self loadViewControllerAt:i];
            }
        } else if (i == currIndex + 1) {
            if ([[self.views objectAtIndex:i] isEqual:[NSNull null]]) {
                [self loadViewControllerAt:i];
            }
        } else {
            if (![[self.views objectAtIndex:i] isEqual:[NSNull null]]) {
                [self purgeViewControllerAt:i];
            }
        }
    }
}

- (void)purgeViewControllerAt:(NSInteger)index {
    NSLog(@"purse view at %ld", index);
    UIView *v = [self.views objectAtIndex:index];
    if (![v isEqual:[NSNull null]]) {
        [v removeFromSuperview];
        [self.views replaceObjectAtIndex:index withObject:[NSNull null]];
        [self.delegate pagerView:self viewPurgedAt:index];
    }
}

- (void)loadViewControllerAt:(NSInteger)index {
    UIView *view = [self.datasource pagerView:self viewControllerAtIndex:index];
    [self.scrollView addSubview:view];
    view.frame = CGRectMake(PAGE_WIDTH * index, 0, PAGE_WIDTH, self.bounds.size.height);
    [self.views replaceObjectAtIndex:index withObject:view];
    [self.delegate pagerView:self viewAddedAt:index];
    NSLog(@"obtain view at %ld %f %f", index, PAGE_WIDTH, self.bounds.size.height);
}

#pragma marks - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (!_sized) {
        return;
    }
    NSLog(@"CONTENT OFFSET X %f", scrollView.contentOffset.x);
    NSInteger currIndex = roundf(scrollView.contentOffset.x / PAGE_WIDTH);
    [self invalidatePages:currIndex];
}

@end

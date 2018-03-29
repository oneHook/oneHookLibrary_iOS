//
//  OHFlipperView.m
//  oneHookLibrary
//
//  Created by Eagle Diao on 2016-11-17.
//  Copyright © 2016 oneHook inc. All rights reserved.
//

#import "OHFlipperView.h"

@interface OHFlipperView() {
    
    CGFloat _lastWidth;
    CGFloat _lastHeight;
    
}

@property (strong, nonatomic) UIView* frontPage;
@property (strong, nonatomic) UIView* bottomPage;

@end

@implementation OHFlipperView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit
{
    self.clipsToBounds = YES;
    self.frontBottomMargin = 0;
    self.bottomScale = 1;
    
    self.leftPadding = 0;
    self.rightPadding = 0;
    self.topPadding = 0;
    self.bottomPadding = 0;
    
    self.frontPage = [self createPage];
    self.frontPage.layer.anchorPoint = CGPointMake(0.5, 1);
    self.bottomPage = [self createPage];
    self.bottomPage.layer.anchorPoint = CGPointMake(0.5, 1);
    self.bottomPage.accessibilityElementsHidden = YES;
    [self addSubview:self.bottomPage];
    [self addSubview:self.frontPage];
}

- (void)layoutSubviews
{
    CGFloat width = CGRectGetWidth(self.bounds);
    CGFloat height = CGRectGetHeight(self.bounds);
    
    if(_lastWidth != width || _lastHeight != height) {
        [self doLayout];
    }
}

- (void)doLayout
{
    CGFloat width = CGRectGetWidth(self.bounds);
    CGFloat height = CGRectGetHeight(self.bounds);
    
    self.frontPage.frame = CGRectMake(_leftPadding,
                                      _topPadding,
                                      width - _leftPadding - _rightPadding,
                                      height - _topPadding - _bottomPadding - _frontBottomMargin);
    
    self.bottomPage.alpha = 1;
    self.bottomPage.frame = self.frontPage.frame;
    _lastWidth = width;
    _lastHeight = height;
    
    self.bottomPage.transform = CGAffineTransformTranslate(CGAffineTransformMakeScale(self.bottomScale, self.bottomScale),
                                                           0,
                                                           _frontBottomMargin);
}

- (UIView*)createPage
{
    return nil;
}

- (void)flip:(enum OHFlipperViewDirection)direction {
    CGFloat dc = (direction == OHFlipperViewDirectionLeft) ? -1 : 1;
    [UIView animateWithDuration:0.25 animations:^{
        self.frontPage.transform = CGAffineTransformMakeTranslation(dc * CGRectGetWidth(self.bounds), 0);
        self.bottomPage.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        if(finished) {
            BOOL hasNextPage = [self frontPageDidDisappear];
            self.frontPage.hidden = !hasNextPage;
            
            [self bringSubviewToFront:self.bottomPage];
            self.frontPage.transform = CGAffineTransformIdentity;
            self.frontPage.alpha = 0;
            UIView* temp = self.frontPage;
            self.frontPage = self.bottomPage;
            self.bottomPage = temp;
            [UIView animateWithDuration:0.25 animations:^{
                [self doLayout];
            } completion:^(BOOL finished) {
                [self onFlipFinishedWithFront:self.frontPage bottom:self.bottomPage];
            }];
        }
    }];
}

- (void)onFlipFinishedWithFront:(UIView *)frontPage bottom:(UIView *)bottomPage
{
    frontPage.accessibilityElementsHidden = NO;
    bottomPage.accessibilityElementsHidden = YES;
}


- (BOOL)frontPageDidDisappear {
    return NO;
}
@end

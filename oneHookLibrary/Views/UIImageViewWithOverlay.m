//
//  UIImageViewWithOverlay.m
//  oneHookLibrary
//
//  Created by Eagle Diao on 2015-08-13.
//  Copyright (c) 2015 oneHook inc. All rights reserved.
//

#import "UIImageViewWithOverlay.h"

@interface UIImageViewWithOverlay() {

    CALayer* _overlayLayer;
    UIImageView* _placeholderImageView;
}

@end

@implementation UIImageViewWithOverlay

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self) {
        [self commonInit];
    }
    return self;
}

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
    _overlayLayer = [[CALayer alloc] init];
    _overlayLayer.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5].CGColor;
    [self.layer addSublayer:_overlayLayer];
}

- (void)dealloc
{
    [_overlayLayer removeFromSuperlayer];
    _overlayLayer = nil;
    [_placeholderImageView removeFromSuperview];
    _placeholderImageView = nil;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _overlayLayer.frame = self.bounds;
    if(self.placeholderImage && _placeholderImageView) {
        _placeholderImageView.image = self.placeholderImage;
        _placeholderImageView.bounds = CGRectMake(0, 0, self.placeholderImage.size.width, self.placeholderImage.size.height);
        _placeholderImageView.center = CGPointMake(CGRectGetWidth(self.bounds) / 2,
                                                   CGRectGetHeight(self.bounds) / 2);
    } else {
        _placeholderImageView.frame = CGRectZero;
    }
}

- (void)setShowOverlay:(BOOL)showOverlay
{
    _showOverlay = showOverlay;
    if(_showOverlay) {
        if(!_overlayLayer) {
            _overlayLayer = [[CALayer alloc] init];
            _overlayLayer.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5].CGColor;
            [self.layer addSublayer:_overlayLayer];
        }
        _overlayLayer.hidden = NO;
    } else {
        _overlayLayer.hidden = YES;
    }
}

- (void)setShowPlaceholder:(BOOL)showPlaceholder
{
    _showPlaceholder = showPlaceholder;
    if(_showPlaceholder) {
        if(!_placeholderImageView) {
            _placeholderImageView = [[UIImageView alloc] init];
            [self addSubview:_placeholderImageView];
        }
        if(_placeholderImage) {
            _placeholderImageView.image = _placeholderImage;
            _placeholderImageView.bounds = CGRectMake(0, 0, _placeholderImage.size.width, _placeholderImage.size.height);
            _placeholderImageView.center = CGPointMake(CGRectGetWidth(self.bounds) / 2,
                                                       CGRectGetHeight(self.bounds) / 2);
        } else {
            _placeholderImageView.frame = CGRectZero;
        }
        _placeholderImageView.hidden = NO;
    } else {
        _placeholderImageView.hidden = YES;
    }
}

- (void)setPlaceholderImage:(UIImage *)placeholderImage
{
    _placeholderImage = placeholderImage;
    if(_placeholderImageView) {
        if(_placeholderImage) {
            _placeholderImageView.image = _placeholderImage;
            _placeholderImageView.bounds = CGRectMake(0, 0, _placeholderImage.size.width, _placeholderImage.size.height);
            _placeholderImageView.center = CGPointMake(CGRectGetWidth(self.bounds) / 2,
                                                       CGRectGetHeight(self.bounds) / 2);
        } else {
            _placeholderImageView.frame = CGRectZero;
        }
    }
}

@end

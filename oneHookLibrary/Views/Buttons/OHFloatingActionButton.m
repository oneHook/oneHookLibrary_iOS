//
//  OHFloatingActionButton.m
//  oneHookLibrary
//
//  Created by Eagle Diao@ToMore on 2016-06-06.
//  Copyright © 2016 oneHook inc. All rights reserved.
//

#import "OHFloatingActionButton.h"
#import "UIImage+Color.h"
#import "OneHookFoundation.h"

@interface OHFloatingActionButton () {
    CGFloat _buttonScale;
    CGFloat _lastWidth;
}

@property (strong, nonatomic) UIView* backgroundView;
@property (strong, nonatomic) UIView* contentView;

@end

@implementation OHFloatingActionButton

#define SHADOW_OPACITY 0.3f

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self doInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self doInit];
    }
    return self;
}

- (id)init {
    self = [super init];
    if (self) {
        [self doInit];
    }
    return self;
}

- (void)doInit {
    _lastWidth = 0;
    self.backgroundColor = [UIColor clearColor];
    
    self.backgroundView = [[UIView alloc] init];
    self.backgroundView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.backgroundView];
    self.backgroundView.clipsToBounds = YES;
    
    self.hasShadow = YES;
}

- (UILabel*)titleLabel
{
    if(_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleLabel];
        self.contentView = _titleLabel;
    }
    return _titleLabel;
}

- (UIImageView*)imageView
{
    if(_imageView == nil) {
        _imageView = [[UIImageView alloc] init];
        _imageView.clipsToBounds = YES;
        _imageView.contentMode = UIViewContentModeScaleToFill;
        [self addSubview:_imageView];
        self.contentView = _imageView;
    }
    return _imageView;
}

- (void)setContentView:(UIView *)contentView
{
    _contentView = contentView;
    [self addSubview:_contentView];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self onPressed];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self onRelease];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self onRelease];
}

- (void)setHasShadow:(BOOL)hasShadow
{
    _hasShadow = hasShadow;
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOpacity = SHADOW_OPACITY;
    self.layer.shadowRadius = 2.0;
    if(hasShadow) {
        self.layer.shadowOffset = CGSizeMake(0, 5);
    } else {
        self.layer.shadowOffset = CGSizeMake(0, 0);
    }
}

- (void)onPressed {
    if(_hasShadow) {
        self.layer.shadowOffset = CGSizeMake(0, 10);
    }
}

- (void)onRelease {
    if(_hasShadow) {
        self.layer.shadowOffset = CGSizeMake(0, 5);
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if(_lastWidth != CGRectGetWidth(self.frame)) {
        _lastWidth = CGRectGetWidth(self.frame);
        self.backgroundView.frame = self.bounds;
        _titleLabel.frame = self.bounds;
        _imageView.frame = self.bounds;
        [self.backgroundView.layer setCornerRadius:ViewWidth(self) / 2];
        if(_contentView) {
            _contentView.frame = self.bounds;
            [_contentView.layer setCornerRadius:ViewWidth(self) / 2];
        }
        self.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:100.0].CGPath;
    }
}

@end

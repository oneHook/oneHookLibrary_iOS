//
//  OHToolbar.m
//  oneHookLibrary
//
//  Created by Eagle Diao@ToMore on 2016-06-05.
//  Copyright © 2016 oneHook inc. All rights reserved.
//

#import "OHToolbar.h"

@interface OHToolbar() {
    CGFloat _lastWidth;
    CGFloat _lastHeight;
}

@end

@implementation OHToolbar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self) {
        [self commonInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit
{
    self.toolbarContainer = [[UIView alloc] init];
    [self addSubview:self.toolbarContainer];
    
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:1 alpha:0.8];
    //    self.backgroundColor = COLOR_PRIMARY_DARK;
    //    self.toolbarContainer.backgroundColor = COLOR_PRIMARY;
}

- (void)layoutSubviews
{
    CGFloat width = CGRectGetWidth(self.bounds);
    CGFloat height = CGRectGetHeight(self.bounds);
    
    if(_lastWidth != width || _lastHeight != height) {
        
        CGFloat topOffset = self.showStatusBar ? kSystemStatusBarHeight : 0;
        self.toolbarContainer.frame = CGRectMake(0, topOffset, width, height - topOffset);
        
        CGFloat actionButtonLength = kToolbarDefaultHeight - MARGIN_SMALL * 2;
        CGFloat left = 0;
        CGFloat right = width;
        if(_leftButton) {
            CGFloat defaultWidth = actionButtonLength;
            [_leftButton sizeToFit];
            defaultWidth = MAX(defaultWidth, CGRectGetWidth(_leftButton.bounds));
            _leftButton.frame = CGRectMake(MARGIN_SMALL,
                                           topOffset + MARGIN_SMALL,
                                           defaultWidth,
                                           actionButtonLength);
            _leftButton.layer.cornerRadius = defaultWidth;
            left = CGRectGetMaxX(_leftButton.frame);
        }
        if(_rightButton) {
            CGFloat defaultWidth = actionButtonLength;
            [_rightButton sizeToFit];
            defaultWidth = MAX(defaultWidth, CGRectGetWidth(_rightButton.bounds));
            _rightButton.frame = CGRectMake(width - MARGIN_SMALL - defaultWidth,
                                            topOffset + MARGIN_SMALL,
                                            defaultWidth,
                                            actionButtonLength);
            _rightButton.layer.cornerRadius = defaultWidth;
            right = CGRectGetMinX(_rightButton.frame);
        }
        _titleLabel.frame = CGRectMake(MARGIN_SMALL + left,
                                       topOffset,
                                       right - left,
                                       kToolbarDefaultHeight);
        _lastWidth = width;
        _lastHeight = height;
    }
}

- (UIButton*)leftButton
{
    if(!_leftButton) {
        _leftButton = [OHButtonFactory createToolbarActionButton];
        [self addSubview:_leftButton];
    }
    return _leftButton;
}

- (UIButton*)rightButton
{
    if(!_rightButton) {
        _rightButton = [OHButtonFactory createToolbarActionButton];
        [self addSubview:_rightButton];
    }
    return _rightButton;
}

- (CGPoint)leftButtonCenter
{
    CGFloat actionButtonLength = kToolbarDefaultHeight - MARGIN_SMALL * 2;
    return CGPointMake(MARGIN_SMALL + actionButtonLength / 2, CGRectGetHeight(self.frame) - actionButtonLength / 2 - MARGIN_SMALL);
}

- (CGPoint)rightButtonCenter
{
    CGFloat actionButtonLength = kToolbarDefaultHeight - MARGIN_SMALL * 2;
    return CGPointMake(CGRectGetWidth(self.frame) - MARGIN_MEDIUM - actionButtonLength / 2,
                       CGRectGetHeight(self.frame) - actionButtonLength / 2 - MARGIN_SMALL);
}

- (UILabel*)titleLabel
{
    if(!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:20];
        _titleLabel.textColor = WHITE;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    [self layoutSubviews];
}



@end

//
//  OHToolbar.m
//  oneHookLibrary
//
//  Created by Eagle Diao@ToMore on 2016-06-05.
//  Copyright © 2016 oneHook inc. All rights reserved.
//

#import "OHToolbar.h"

@interface OHToolbar() {
    
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
    
    CGFloat topOffset = self.showStatusBar ? kSystemStatusBarHeight : 0;
    self.toolbarContainer.frame = CGRectMake(0, topOffset, width, height - topOffset);
    
    CGFloat actionButtonLength = height - topOffset - MARGIN_TINY * 2;
    _leftButton.frame = CGRectMake(MARGIN_TINY,
                                   topOffset + MARGIN_TINY,
                                   actionButtonLength,
                                   actionButtonLength);
    _rightButton.frame = CGRectMake(width - MARGIN_TINY - actionButtonLength,
                                    topOffset + MARGIN_TINY,
                                    actionButtonLength,
                                    actionButtonLength);
    _titleLabel.frame = CGRectMake(MARGIN_TINY + actionButtonLength,
                                   topOffset,
                                   width - 2 * actionButtonLength - 2 * MARGIN_TINY,
                                   height - topOffset);
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



@end

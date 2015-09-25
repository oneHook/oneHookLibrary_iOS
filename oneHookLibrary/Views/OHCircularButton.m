//
//  OHCircularButton.m
//  oneHookLibrary
//
//  Created by Eagle Diao on 2015-03-27.
//  Copyright (c) 2015 oneHook inc. All rights reserved.
//

#import "UIImage+Color.h"
#import "OHCircularButton.h"
#import "OneHookFoundation.h"

@interface OHCircularButton () {
    CGFloat _buttonScale;
}
@end

@implementation OHCircularButton

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
    self.backgroundColor = [UIColor clearColor];
    
    self.backgroundView = [[UIView alloc] init];
    self.backgroundView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.backgroundView];
    self.backgroundView.clipsToBounds = YES;
    
    self.hasShadow = YES;
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.titleLabel];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touch begin");
    [self onPressed];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self onRelease];
    NSLog(@"touch end");
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self onRelease];
    NSLog(@"touch cancel");
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
    self.backgroundView.frame = self.bounds;
    self.titleLabel.frame = self.bounds;
    [self.backgroundView.layer setCornerRadius:ViewWidth(self) / 2];
    self.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:100.0].CGPath;
}

@end

//
//  OHIconLabelButton.m
//  oneHookLibrary
//
//  Created by Eagle Diao@ToMore on 2016-09-03.
//  Copyright © 2016 oneHook inc. All rights reserved.
//

#import "OHIconLabelButton.h"

@interface OHIconLabelButton() {
    
}

@end

@implementation OHIconLabelButton

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
    self.imageView = [[UIImageView alloc] init];
    self.imageView.clipsToBounds = YES;
    self.imageView.contentMode = UIViewContentModeCenter;
    [self addSubview:self.imageView];
    
    self.label = [[UILabel alloc] init];
    self.label.adjustsFontSizeToFitWidth = YES;
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.textColor = [UIColor blackColor];
    self.label.font = [UIFont boldSystemFontOfSize:14];
    [self addSubview:self.label];
}

- (void)layoutSubviews
{
    CGFloat width = CGRectGetWidth(self.frame);
    CGFloat height = CGRectGetHeight(self.frame);
    self.imageView.frame = CGRectMake(0, 0, width, width);
    self.label.frame = CGRectMake(0, width, width, height - width);
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

- (void)onPressed {
    self.imageView.alpha = 0.5f;
    self.label.alpha = 0.5f;
}

- (void)onRelease {
    self.imageView.alpha = 1.f;
    self.label.alpha = 1.f;
}

@end

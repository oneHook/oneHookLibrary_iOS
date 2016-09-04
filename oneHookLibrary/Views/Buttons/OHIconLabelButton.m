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
    [self addSubview:self.label];
}

- (void)layoutSubviews
{
    CGFloat width = CGRectGetWidth(self.frame);
    CGFloat height = CGRectGetHeight(self.frame);
    self.imageView.frame = CGRectMake(0, 0, width, width);
    self.label.frame = CGRectMake(0, width, width, height - width);
}

@end

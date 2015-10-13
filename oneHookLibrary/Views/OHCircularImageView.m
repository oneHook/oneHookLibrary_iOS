//
//  OHCircularImageView.m
//  oneHookLibrary
//
//  Created by Eagle Diao on 2015-10-13.
//  Copyright © 2015 oneHook inc. All rights reserved.
//

#import "OHCircularImageView.h"

@implementation OHCircularImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self) {
        self.contentMode = UIViewContentModeScaleAspectFill;
        self.layer.borderWidth = 3;
        self.layer.borderColor = [UIColor whiteColor].CGColor;
        self.clipsToBounds = YES;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.layer.cornerRadius = CGRectGetWidth(self.bounds) / 2;
}

@end

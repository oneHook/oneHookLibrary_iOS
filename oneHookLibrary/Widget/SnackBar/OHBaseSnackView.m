//
//  OHBaseSnackView.m
//  oneHookLibrary
//
//  Created by Eagle Diao on 2016-08-29.
//  Copyright © 2016 oneHook inc. All rights reserved.
//

#import "OHBaseSnackView.h"

@implementation OHBaseSnackView

- (id)initWithBackgroundStyle:(OHSnackBarBackgroundStyle)style
{
    self = [super init];
    if(self) {
        self.idleTime = 2;
        self.backgroundStyle = style;
    }
    return self;
}

- (CGFloat)measureHeightByWidth:(CGFloat)width {
    return 64;
}

@end

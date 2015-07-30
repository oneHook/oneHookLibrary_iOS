//
//  OHEqualWeightLayout.m
//  oneHookLibrary
//
//  Created by Eagle Diao on 2015-07-30.
//  Copyright (c) 2015 oneHook inc. All rights reserved.
//

#import "OHEqualWeightLayout.h"

@implementation OHEqualWeightLayout

- (id)initWithOrientation:(OHEqualWeightLayoutOrientation)orientation {
    self = [super init];
    if(self) {
        self.orientation = orientation;
    }
    return self;
}

- (void)doLayout {
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    NSInteger childCount = self.subviews.count;
    if(childCount == 0) {
        return;
    }
    if(self.orientation == OHEqualWeightLayoutOrientationHorizontal) {
        CGFloat itemWidth = (width - (childCount - 1) * self.viewMargin) / childCount;
        CGFloat x = 0;
        for(UIView* view in self.subviews) {
            view.frame = CGRectMake(x, 0, itemWidth, height);
            x += itemWidth + self.viewMargin;
        }
    } else {
        CGFloat itemHeight = (height - (childCount - 1) * self.viewMargin) / childCount;
        CGFloat y = 0;
        for(UIView* view in self.subviews) {
            view.frame = CGRectMake(0, y, width, itemHeight);
            y += itemHeight + self.viewMargin;
        }
    }
}

- (void)layoutSubviews {
    [self doLayout];
}


@end

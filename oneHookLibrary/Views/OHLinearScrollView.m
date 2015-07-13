//
//  OHLinearScrollView.m
//  oneHookLibrary
//
//  Created by Eagle Diao@ToMore on 2015-07-13.
//  Copyright (c) 2015 oneHook inc. All rights reserved.
//

#import "OHLinearScrollView.h"

@implementation OHLinearScrollView

- (id)initWithOrientation:(OHLinearScrollViewOrientation)orientation {
    self = [super init];
    if(self) {
        self.orientation = orientation;
        self.contentView = [[UIView alloc] init];
        [self addSubview:self.contentView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    static CGFloat lastWidth = 0;
    if(lastWidth != self.bounds.size.width) {
        lastWidth = self.bounds.size.width;
        CGFloat contentLength = 0;
        for(UIView* view in self.contentView.subviews) {
            if(self.orientation == OHLinearScrollViewOrientationHorizontal) {
                view.frame = CGRectMake(contentLength, 0, view.bounds.size.width, self.bounds.size.height);
                contentLength += view.bounds.size.width;
            } else {
                view.frame = CGRectMake(0, contentLength, self.bounds.size.width, view.bounds.size.height);
                contentLength += view.bounds.size.height;
            }
        }
        if(self.orientation == OHLinearScrollViewOrientationHorizontal) {
            self.contentSize = CGSizeMake(contentLength, 0);
            self.contentView.frame = CGRectMake(0, 0, contentLength, self.frame.size.height);
        } else {
            self.contentSize = CGSizeMake(0, contentLength);
            self.contentView.frame = CGRectMake(0, 0, self.frame.size.width, contentLength);
        }
    }
}

@end

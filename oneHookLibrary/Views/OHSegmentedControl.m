//
//  OHSegmentedControl.m
//  oneHookLibrary
//
//  Created by Eagle Diao on 2015-06-08.
//  Copyright (c) 2015 oneHook inc. All rights reserved.
//

#import "OHSegmentedControl.h"

@interface OHSegmentedControl() {
    
}

@property (strong, nonatomic) NSMutableArray* controls;

@end

@implementation OHSegmentedControl

- (id)init {
    self = [super init];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    if(self.titles.count > 0) {
        for(UILabel* label in self.controls) {
            [label removeFromSuperview];
        }
        for(NSString* title in self.titles) {
            UILabel* tab = [[UILabel alloc] init];
            [self.controls addObject:tab];
            [self addSubview:tab];
            
            tab.text = title;
        }
        self.selectedIndex = 0;
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if(self.controls.count > 0) {
        CGFloat tabWidth = self.bounds.size.width / self.controls.count;
        CGFloat xStart = 0;
        for(UILabel* tab in self.controls) {
            tab.frame = CGRectMake(xStart, 0, tabWidth, self.bounds.size.height);
            xStart += tabWidth;
        }
    }
}

- (NSMutableArray*)controls
{
    if(_controls == nil) {
        _controls = [[NSMutableArray alloc] init];
    }
    return _controls;
}

- (void)setTitles:(NSArray *)titles
{
    _titles = titles;
    [self commonInit];
}

@end

//
//  OHSegmentedControl.h
//  oneHookLibrary
//
//  Created by Eagle Diao on 2015-06-08.
//  Copyright (c) 2015 oneHook inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OHSegmentedControl;

@protocol OHSegmentedControlDelegate <NSObject>

- (void)onSegmentedControl:(OHSegmentedControl*)segmentedControl indexSelected:(NSInteger)index;

@end

@interface OHSegmentedControl : UIView

@property (strong, nonatomic) UIColor* tintColor;
@property (strong, nonatomic) NSArray* titles;
@property (assign, nonatomic) NSInteger selectedIndex;

@end

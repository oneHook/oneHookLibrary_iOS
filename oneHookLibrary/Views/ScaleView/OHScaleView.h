//
//  OHScaleView.h
//  oneHookLibrary
//
//  Created by Eagle Diao on 2016-09-01.
//  Copyright © 2016 oneHook inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OHScaleView : UIView

@property (assign, nonatomic) CGFloat minValue;
@property (assign, nonatomic) CGFloat maxValue;
@property (assign, nonatomic) CGFloat startingValue;
@property (assign, nonatomic) int numberOfIntervals;
@property (assign, nonatomic) CGFloat intervalSpace;

- (id)initWithHorizontal;
- (id)initWithVertical;

@end

//
//  OHGradientView.h
//  oneHookLibrary
//
//  Created by Eagle Diao on 2015-08-22.
//  Copyright (c) 2015 oneHook inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OHGradientView : UIView

- (id)initWithHorizontalGradient;
- (id)initWithVerticalGradient;
- (void)setGradientColorFrom:(UIColor*)fromColor to:(UIColor*)toColor;
- (void)setGradientColors:(NSArray*) colors forPoints:(NSArray<NSNumber *>*) points;

@end

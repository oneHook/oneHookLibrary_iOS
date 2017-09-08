//
//  OHScaleView.h
//  oneHookLibrary
//
//  Created by EagleDIao@Optimity on 2017-08-06.
//  Copyright © 2017 oneHook inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OHScaleViewDelegate <NSObject>

- (void)onScaleMoved:(int)currentScale;

@end

@interface OHScaleView : UIView

@property (strong, nonatomic) UIColor* scaleColor;
@property (assign, nonatomic) CGFloat thinLineRatio;
@property (assign, nonatomic) CGFloat paddingTop;
@property (assign, nonatomic) CGFloat paddingBottom;
@property (assign, nonatomic) CGFloat thickLineThickness;
@property (assign, nonatomic) CGFloat thinLineThickness;
@property (strong, nonatomic) UIColor* scaleIndicatorColor;
@property (assign, nonatomic) CGFloat scaleIndicatorHeight;
@property (assign, nonatomic) CGFloat scaleIndicatorWidth;

@property (assign, nonatomic) int scaleInterval;
@property (assign, nonatomic) NSInteger scaleIntervalCount;

@property (assign, nonatomic) int minScale;
@property (assign, nonatomic) int maxScale;
@property (assign, nonatomic) int currentScale;

@property (weak, nonatomic) id<OHScaleViewDelegate> delegate;

@end

//
//  OHLinearScrollView.h
//  oneHookLibrary
//
//  Created by Eagle Diao@ToMore on 2015-07-13.
//  Copyright (c) 2015 oneHook inc. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    OHLinearScrollViewOrientationVertical,
    OHLinearScrollViewOrientationHorizontal
} OHLinearScrollViewOrientation;

#define MATCH_PARENT 1

@interface OHLinearScrollView : UIScrollView

@property (assign, nonatomic) OHLinearScrollViewOrientation orientation;
@property (strong, nonatomic) UIView* contentView;
@property (assign, nonatomic) float itemSpacing;

- (id)initWithOrientation:(OHLinearScrollViewOrientation)orientation;
- (void)addViewToOrder:(UIView*)view;

/* deprecated */
- (void)doLayout;

/* new version */
- (CGSize)doLayoutInSize:(CGSize)size;
- (void)addChild:(UIView*)view;
- (void)addChild:(UIView*)view at:(NSUInteger)index;
- (void)removeChild:(UIView*)view;

@end

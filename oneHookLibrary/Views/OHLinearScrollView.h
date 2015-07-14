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

@interface OHLinearScrollView : UIScrollView

@property (assign, nonatomic) OHLinearScrollViewOrientation orientation;
@property (strong, nonatomic) UIView* contentView;

- (id)initWithOrientation:(OHLinearScrollViewOrientation)orientation;
- (void)addViewToOrder:(UIView*)view;
- (void)doLayout;

@end

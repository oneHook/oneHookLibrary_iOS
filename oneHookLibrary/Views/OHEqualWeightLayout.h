//
//  OHEqualWeightLayout.h
//  oneHookLibrary
//
//  Created by Eagle Diao on 2015-07-30.
//  Copyright (c) 2015 oneHook inc. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    OHEqualWeightLayoutOrientationVertical,
    OHEqualWeightLayoutOrientationHorizontal
} OHEqualWeightLayoutOrientation;


@interface OHEqualWeightLayout : UIView

@property (assign, nonatomic) OHEqualWeightLayoutOrientation orientation;
@property (assign, nonatomic) CGFloat viewMargin;

- (id)initWithOrientation:(OHEqualWeightLayoutOrientation)orientation;
- (void)doLayout;

@end

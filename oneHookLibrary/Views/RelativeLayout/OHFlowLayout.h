//
//  OHFlowLayout.h
//  oneHookLibrary
//
//  Created by Eagle Diao@ToMore on 2016-07-21.
//  Copyright © 2016 oneHook inc. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    OHFlowLayoutAlignTypeBottom,
    OHFlowLayoutAlignTypeTop,
    OHFlowLayoutAlignTypeCenter
} OHFlowLayoutAlignType;


@interface OHFlowLayout : UIView

@property (assign, nonatomic) CGFloat horizontalSpacing;
@property (assign, nonatomic) CGFloat lineSpacing;
@property (assign, nonatomic) OHFlowLayoutAlignType alignType;

- (CGSize)doLayout:(CGFloat)maxWidth;

@end

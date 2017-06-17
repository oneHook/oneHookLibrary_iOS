//
//  OHFlowLayout.m
//  oneHookLibrary
//
//  Created by Eagle Diao@ToMore on 2016-07-21.
//  Copyright © 2016 oneHook inc. All rights reserved.
//

#import "OHFlowLayout.h"

@implementation OHFlowLayout

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self) {
        self.horizontalSpacing = 4;
        self.lineSpacing = 16;
        self.alignType = OHFlowLayoutAlignTypeCenter;
    }
    return self;
}


- (CGSize)doLayout:(CGFloat)maxWidth
{
    NSInteger subviewCount = self.subviews.count;
    
    CGFloat currentLineX = 0;
    CGFloat currentLineY = 0;
    CGFloat currentLineMaxHeight = 0;
    NSMutableArray* currentLineViews = [[NSMutableArray alloc] init];
    
    int i = 0;
    while(i < subviewCount) {
        UIView* child = [self.subviews objectAtIndex:i];
        CGSize viewSize = child.bounds.size;
        
        if(currentLineX + _horizontalSpacing + viewSize.width < maxWidth || currentLineViews.count == 0) {
            /* still in the same line */
            currentLineMaxHeight = MAX(currentLineMaxHeight, viewSize.height);
            [currentLineViews addObject:child];
            currentLineX += viewSize.width + _horizontalSpacing;
            i++;
        } else {
            /* first layout current line */
            [self layoutLine:currentLineViews yStart:currentLineY maxHeight:currentLineMaxHeight];
            /* should go into a new line */
            [currentLineViews removeAllObjects];
            currentLineY += currentLineMaxHeight + _lineSpacing;
            currentLineMaxHeight = 0;
            currentLineX = 0;
        }
    }
    
    if(currentLineViews.count > 0) {
        /* layout remaining views */
        [self layoutLine:currentLineViews yStart:currentLineY maxHeight:currentLineMaxHeight];
        [currentLineViews removeAllObjects];
        currentLineY += currentLineMaxHeight;
    } else {
        currentLineY -= _lineSpacing;
    }
    
    self.bounds = CGRectMake(0, 0, maxWidth, MAX(0, currentLineY));
    return CGSizeMake(maxWidth, MAX(0, currentLineY));
}

- (void)layoutLine:(NSArray*)views yStart:(CGFloat)yStart maxHeight:(CGFloat)maxHeight
{
    CGFloat xStart = 0;
    for(int j = 0; j < views.count ;j++) {
        UIView* toLayout = [views objectAtIndex:j];
        CGSize viewSize = toLayout.bounds.size;
        
        if(self.alignType == OHFlowLayoutAlignTypeBottom) {
            toLayout.frame = CGRectMake(xStart, yStart + maxHeight - viewSize.height, viewSize.width, viewSize.height);
        } else if(self.alignType == OHFlowLayoutAlignTypeCenter) {
            toLayout.frame = CGRectMake(xStart, yStart + (maxHeight - viewSize.height) / 2, viewSize.width, viewSize.height);
        } else if(self.alignType == OHFlowLayoutAlignTypeTop) {
            toLayout.frame = CGRectMake(xStart, yStart, viewSize.width, viewSize.height);
        }
        xStart += viewSize.width + _horizontalSpacing;
    }
}

@end

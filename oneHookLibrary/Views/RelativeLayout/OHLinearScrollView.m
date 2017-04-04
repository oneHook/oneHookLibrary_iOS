//
//  OHLinearScrollView.m
//  oneHookLibrary
//
//  Created by Eagle Diao@ToMore on 2015-07-13.
//  Copyright (c) 2015 oneHook inc. All rights reserved.
//

#import "OHLinearScrollView.h"

#define PADDING self.padding

@interface OHLinearScrollView() {
    
}

@property (strong, nonatomic) NSMutableArray* viewOrders;

@end

@implementation OHLinearScrollView

- (id)initWithOrientation:(OHLinearScrollViewOrientation)orientation {
    self = [super init];
    if(self) {
        self.orientation = orientation;
        self.contentView = [[UIView alloc] init];
        self.viewOrders = [[NSMutableArray alloc] init];
        [self addSubview:self.contentView];
    }
    return self;
}

- (void)doLayout {
    
    CGFloat contentLength = 0;
    for(UIView* view in self.viewOrders) {
        if(self.orientation == OHLinearScrollViewOrientationHorizontal) {
            view.frame = CGRectMake(contentLength, 0, view.bounds.size.width, self.bounds.size.height);
            contentLength += view.bounds.size.width;
        } else {
            CGFloat marginTop = view.bounds.origin.y;
            view.bounds = CGRectMake(0, 0, view.bounds.size.width, view.bounds.size.height);
            view.frame = CGRectMake(0,
                                    contentLength + marginTop,
                                    self.bounds.size.width - self.contentInset.left - self.contentInset.right,
                                    view.bounds.size.height);
            contentLength += view.bounds.size.height + marginTop;
        }
    }
    if(self.orientation == OHLinearScrollViewOrientationHorizontal) {
        self.contentSize = CGSizeMake(contentLength, 0);
        self.contentView.frame = CGRectMake(0, 0, contentLength, self.frame.size.height);
    } else {
        self.contentSize = CGSizeMake(0, contentLength);
        self.contentView.frame = CGRectMake(0, 0, self.frame.size.width, contentLength);
    }
}

- (void)addViewToOrder:(UIView *)view
{
    [self.viewOrders addObject:view];
}


- (CGSize)doLayoutInSize:(CGSize)size
{
    CGFloat contentLength = 0;
    for(UIView* view in self.viewOrders) {
        if(self.orientation == OHLinearScrollViewOrientationHorizontal) {
            view.frame = CGRectMake(contentLength, 0, view.bounds.size.width, self.bounds.size.height);
            contentLength += view.bounds.size.width;
        } else {
            CGFloat marginTop = view.bounds.origin.y;
            CGFloat viewWidth = CGRectGetWidth(view.bounds);
            CGFloat viewHeight = CGRectGetHeight(view.bounds);
            if(viewWidth == MATCH_PARENT) {
                viewWidth = size.width - self.contentInset.left - self.contentInset.right;
            } else if(viewWidth < 1) {
                viewWidth = (size.width - self.contentInset.left - self.contentInset.right) * viewWidth;
            }
            
            if(viewHeight == 0) {
                view.hidden = YES;
            } else {
                view.hidden = NO;
                view.bounds = CGRectMake(0, 0, viewWidth, viewHeight);
                view.frame = CGRectMake((size.width - viewWidth) / 2,
                                        contentLength + marginTop,
                                        viewWidth,
                                        viewHeight);
            }
            contentLength += viewHeight + marginTop;
        }
    }
    if(self.orientation == OHLinearScrollViewOrientationHorizontal) {
        self.contentSize = CGSizeMake(contentLength, 0);
        self.contentView.frame = CGRectMake(0, 0, contentLength, self.frame.size.height);
        return CGSizeMake(contentLength, CGRectGetHeight(self.frame));
    } else {
        self.contentSize = CGSizeMake(0, contentLength);
        self.contentView.frame = CGRectMake(0, 0, self.frame.size.width, contentLength);
        return CGSizeMake(CGRectGetWidth(self.frame), contentLength);
    }
}

- (void)addChild:(UIView*)view
{
    [self.contentView addSubview:view];
    [self addViewToOrder:view];
}

-(void)addChild:(UIView*)view at:(NSUInteger)index{
    [self.contentView addSubview:view];
    [self.viewOrders insertObject:view atIndex:index];
}

- (void)removeChild:(UIView*)view
{
    if([self.subviews containsObject:view])
    {
        [view removeFromSuperview];
        [self.viewOrders removeObject:view];
    }
}


@end

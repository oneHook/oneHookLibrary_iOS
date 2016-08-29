//
//  OHSinglelineSnackView.m
//  oneHookLibrary
//
//  Created by Eagle Diao on 2016-08-29.
//  Copyright © 2016 oneHook inc. All rights reserved.
//

#import "OHSinglelineSnackView.h"

@implementation OHSinglelineSnackView

- (id)init
{
    self = [super init];
    if(self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit
{
    self.textLabel = [[UILabel alloc] init];
    self.textLabel.numberOfLines = 0;
    [self addSubview:self.textLabel];
    self.padding = 4;
}

- (CGFloat)measureHeightByWidth:(CGFloat)width
{
    static CGFloat measuredWidth = 0;
    static CGFloat measuredHeight = 0;
    /* do not measure same width more than once */
    if(measuredWidth == width) {
        return measuredHeight;
    }
    measuredWidth = width;
    if(self.textLabel.text) {
        /* measure using plain text */
        CGRect sizeFrame = [self.textLabel.text
                            boundingRectWithSize:CGSizeMake(width - _padding * 2, CGFLOAT_MAX)
                            options:NSStringDrawingUsesLineFragmentOrigin
                            attributes:@{ NSFontAttributeName:self.textLabel.font }
                            context:nil];
        measuredHeight = sizeFrame.size.height + _padding * 2;
        
    } else if(self.textLabel.attributedText) {
        /* measure using attributed text */
        CGRect sizeFrame = [self.textLabel.attributedText
                            boundingRectWithSize:CGSizeMake(width - _padding * 2, CGFLOAT_MAX)
                            options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                            context:nil];
        measuredHeight = sizeFrame.size.height + _padding * 2;
    }
    
    return measuredHeight;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.textLabel.frame = CGRectMake(_padding, _padding, CGRectGetWidth(self.frame) - _padding * 2, CGRectGetHeight(self.frame) - _padding * 2);
}

@end

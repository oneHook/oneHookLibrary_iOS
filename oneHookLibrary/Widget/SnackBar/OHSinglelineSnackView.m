//
//  OHSinglelineSnackView.m
//  oneHookLibrary
//
//  Created by Eagle Diao on 2016-08-29.
//  Copyright © 2016 oneHook inc. All rights reserved.
//

#import "OHSinglelineSnackView.h"

@interface OHSinglelineSnackView() {
    
}

@property (assign, nonatomic) CGFloat measuredWidth;
@property (assign, nonatomic) CGFloat measuredHeight;

@end

@implementation OHSinglelineSnackView

- (id)initWithBackgroundStyle:(OHSnackBarBackgroundStyle)style
{
    self = [super initWithBackgroundStyle:style];
    if(self) {
        [self commonInit];
        self.measuredWidth = -1;
    }
    return self;
}

- (void)commonInit
{
    self.textLabel = [[UILabel alloc] init];
    self.textLabel.numberOfLines = 0;
    [self addSubview:self.textLabel];
    self.padding = 8;
}

- (CGFloat)measureHeightByWidth:(CGFloat)width
{
    /* do not measure same width more than once */
    if(self.measuredWidth == width) {
        return self.measuredHeight;
    }
    self.measuredWidth = width;
    if(self.textLabel.text) {
        /* measure using plain text */
        CGRect sizeFrame = [self.textLabel.text
                            boundingRectWithSize:CGSizeMake(width - _padding * 2, CGFLOAT_MAX)
                            options:NSStringDrawingUsesLineFragmentOrigin
                            attributes:@{ NSFontAttributeName:self.textLabel.font }
                            context:nil];
        self.measuredHeight = sizeFrame.size.height + _padding * 2;
        
    } else if(self.textLabel.attributedText) {
        /* measure using attributed text */
        CGRect sizeFrame = [self.textLabel.attributedText
                            boundingRectWithSize:CGSizeMake(width - _padding * 2, CGFLOAT_MAX)
                            options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                            context:nil];
        self.measuredHeight = sizeFrame.size.height + _padding * 2;
    }
    
    return self.measuredHeight;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.textLabel.frame = CGRectMake(_padding, _padding, CGRectGetWidth(self.frame) - _padding * 2, CGRectGetHeight(self.frame) - _padding * 2);
}

@end

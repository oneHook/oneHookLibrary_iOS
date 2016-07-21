//
//  OHTagsView.m
//  oneHookLibrary
//
//  Created by Eagle Diao@ToMore on 2016-07-20.
//  Copyright © 2016 oneHook inc. All rights reserved.
//

#import "OHTagsView.h"

@implementation OHTagsView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self) {
        self.defaultBackgroundColor = [UIColor redColor];
        self.defaultTextColor = [UIColor whiteColor];
        self.tagPadding = 8;
        self.tagCornerRadius = 4;
    }
    return self;
}

-(void)setTags:(NSArray *)tags
{
    /* make sure we purge all existing children */
    for(UIView* child in self.subviews) {
        [child removeFromSuperview];
    }
    
    for(int i = 0; i < tags.count; i++) {
        [self addSubview:[self createTagViewAt:i tag:[tags objectAtIndex:i]]];
    }
}

- (UIView*)createTagViewAt:(int)index tag:(NSString*)tag
{
    UILabel* tagView = [[UILabel alloc] init];
    tagView.numberOfLines = 1;
    tagView.backgroundColor = [self backgroundColorAt:index];
    tagView.textColor = [self textColorAt:index];
    tagView.text = tag;
    tagView.textAlignment = NSTextAlignmentCenter;
    tagView.clipsToBounds = YES;
    tagView.layer.cornerRadius = _tagCornerRadius;
    
    [tagView sizeToFit];
    tagView.bounds = CGRectMake(0, 0, CGRectGetWidth(tagView.frame) + _tagPadding, CGRectGetHeight(tagView.frame) + _tagPadding);
    return tagView;
}


- (UIColor*)backgroundColorAt:(int)index
{
    return self.defaultBackgroundColor;
}

- (UIColor*)textColorAt:(int)index
{
    return self.defaultTextColor;
}

@end

//
//  OHTagsView.m
//  oneHookLibrary
//
//  Created by Eagle Diao@ToMore on 2016-07-20.
//  Copyright © 2016 oneHook inc. All rights reserved.
//

#import "OHTagsView.h"
#import "UIColor+Utility.h"

@implementation OHTag

@end

@interface OHTagsView() {
    
}

@property (strong, nonatomic) NSMutableArray* rawTags;

@end

@implementation OHTagsView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self) {
        self.defaultBackgroundColor = [UIColor redColor];
        self.defaultTextColor = [UIColor whiteColor];
        self.tagPadding = 4;
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
    
    _rawTags = [[NSMutableArray alloc] init];
    for(int i = 0; i < tags.count; i++) {
        OHTag* ohTag = [tags objectAtIndex:i];
        [_rawTags addObject:ohTag];
        [self addSubview:[self createTagViewAt:i tag:ohTag.tagString]];
    }
}

- (UIView*)createTagViewAt:(int)index tag:(NSString*)tag
{
    UIButton* tagView = [[UIButton alloc] init];
    
    tagView.backgroundColor = [self backgroundColorAt:index];
    [tagView setTitleColor:[self textColorAt:index] forState:UIControlStateNormal];
    [tagView setTitleColor:[UIColor darkerColorForColor:[self textColorAt:index]] forState:UIControlStateHighlighted];
    [tagView setTitle:tag forState:UIControlStateNormal];
    tagView.tag = index;
    tagView.titleLabel.font = [UIFont systemFontOfSize:14];
    tagView.clipsToBounds = YES;
    tagView.layer.cornerRadius = _tagCornerRadius;
    
    [tagView sizeToFit];
    tagView.userInteractionEnabled = YES;
    tagView.bounds = CGRectMake(0, 0, CGRectGetWidth(tagView.frame) + _tagPadding * 2, CGRectGetHeight(tagView.frame) + _tagPadding);
    [tagView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTagViewClicked:)]];
    return tagView;
}

- (void)onTagViewClicked:(UITapGestureRecognizer*)rec
{
    NSInteger index = rec.view.tag;
    [self.delegate onTagClicked:rec.view tag:[self.rawTags objectAtIndex:index] in:self];
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

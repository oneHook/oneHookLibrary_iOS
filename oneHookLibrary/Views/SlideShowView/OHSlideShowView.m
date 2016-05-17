//
//  OHSlideShowView.m
//  oneHookLibrary
//
//  Created by Eagle Diao@ToMore on 2016-05-16.
//  Copyright © 2016 oneHook inc. All rights reserved.
//

#import "OHSlideShowView.h"

@interface OHSlideShowView() {
    
}

@property (assign, nonatomic) NSInteger totalSlides;
@property (assign, nonatomic) NSInteger currentSlideIndex;

@property (strong, nonatomic) UIImageView* imageViewOne;
@property (strong, nonatomic) UIImageView* imageViewTwo;

@end

@implementation OHSlideShowView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self) {
        self.imageViewOne = [[UIImageView alloc] init];
        self.imageViewOne.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:self.imageViewOne];
        
        self.imageViewTwo = [[UIImageView alloc] init];
        self.imageViewTwo.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:self.imageViewTwo];
    }
    return self;
}

- (void)layoutSubviews
{
    self.imageViewOne.frame = self.bounds;
    self.imageViewTwo.frame = self.bounds;
}

- (void)startAnimating
{
    self.totalSlides = [self.datasource numberOfSlidesIn:self];
    if(self.totalSlides > 0) {
    self.currentSlideIndex = 0;
        [self.datasource slideShowView:self shouldRenderImage:self.imageViewOne atIndex:self.currentSlideIndex];
    }
}


@end

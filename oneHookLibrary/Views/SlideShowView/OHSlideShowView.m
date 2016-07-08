//
//  OHSlideShowView.m
//  oneHookLibrary
//
//  Created by Eagle Diao@ToMore on 2016-05-16.
//  Copyright © 2016 oneHook inc. All rights reserved.
//

#import "OHSlideShowView.h"

#define FRAME_DURATION 0.02
#define SINGLE_PAGE_DURATION 8

@interface OHSlideShowView() {
    NSTimer* _timer;
    CGFloat _progress;
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
        self.imageViewOne.clipsToBounds = YES;
        [self addSubview:self.imageViewOne];
        
        self.imageViewTwo = [[UIImageView alloc] init];
        self.imageViewTwo.contentMode = UIViewContentModeScaleAspectFill;
        self.imageViewTwo.clipsToBounds = YES;
        [self addSubview:self.imageViewTwo];
    }
    return self;
}

- (void)layoutSubviews
{
    self.imageViewOne.frame = self.bounds;
    self.imageViewTwo.frame = self.bounds;
}

- (void)initialize
{
    self.totalSlides = [self.datasource numberOfSlidesIn:self];
    if(self.totalSlides > 1) {
        self.currentSlideIndex = 0;
        [self.datasource slideShowView:self shouldRenderImage:self.imageViewOne atIndex:self.currentSlideIndex];
        [self.datasource slideShowView:self shouldRenderImage:self.imageViewTwo atIndex:self.currentSlideIndex + 1];
        self.currentSlideIndex = 1;
    }
}

- (void)turnPage
{
    self.currentSlideIndex ++;
    if(self.currentSlideIndex >= self.totalSlides) {
        self.currentSlideIndex -= self.totalSlides;
    }
    [self.datasource slideShowView:self shouldRenderImage:self.imageViewOne atIndex:self.currentSlideIndex];
    UIImageView* imageView = self.imageViewOne;
    self.imageViewOne = self.imageViewTwo;
    self.imageViewTwo = imageView;
    self.imageViewOne.alpha = 1;
    self.imageViewTwo.alpha = 0;
}

- (void)resumeAnimating
{
    _timer = [NSTimer scheduledTimerWithTimeInterval:FRAME_DURATION target:self selector:@selector(onTimer) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    [_timer fire];
}

- (void)onTimer {
    static double offset = 0;
    offset += FRAME_DURATION;
    _progress = offset / SINGLE_PAGE_DURATION;
    
    self.imageViewOne.alpha = (1 - _progress);
    self.imageViewTwo.alpha = _progress;
    
    if(offset > SINGLE_PAGE_DURATION) {
        offset -= SINGLE_PAGE_DURATION;
        /* need turn page */
        [self turnPage];
    }
    
//    NSLog(@"on timer %f", _progress);
}

- (void)stopAnimating
{
    [_timer invalidate];
    _timer = nil;
}

- (NSInteger)currentIndex
{
    return self.currentSlideIndex;
}


@end

//
//  OHSlideShowView.h
//  oneHookLibrary
//
//  Created by Eagle Diao@ToMore on 2016-05-16.
//  Copyright © 2016 oneHook inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OHSlideShowView;

@protocol OHSlideShowViewDatasource <NSObject>

- (NSInteger)numberOfSlidesIn:(OHSlideShowView*)slideShowView;
- (void)slideShowView:(OHSlideShowView*)slideShowView shouldRenderImage:(UIImageView*)imageView atIndex:(NSInteger)index;

@end

@interface OHSlideShowView : UIView

@property (weak, nonatomic) id<OHSlideShowViewDatasource> datasource;

- (void)initialize;
- (void)resumeAnimating;
- (void)stopAnimating;
- (NSInteger)currentIndex;

@end

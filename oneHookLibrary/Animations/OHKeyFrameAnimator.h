//
//  OHKeyFrameAnimator.h
//  oneHookLibrary
//
//  Created by Eagle Diao on 2015-12-24.
//  Copyright © 2015 oneHook inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OHKeyFrameAnimator : NSObject

- (void)startAnimatingWithDuration:(double)duration progress:(void (^)(double))block;

@end

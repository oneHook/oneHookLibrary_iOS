//
//  OHCountDownProgressView.h
//  oneHookLibrary
//
//  Created by Eagle Diao on 2015-12-07.
//  Copyright © 2015 oneHook inc. All rights reserved.
//

#import "OHAnimatedProgressRing.h"

@interface OHCountDownProgressView : UIView

@property (assign, nonatomic) double secondsToCountDown;

@property (strong, nonatomic) OHAnimatedProgressRing* progressRing;
@property (strong, nonatomic) UILabel* secondsLabel;

-(void)startWithEndingBlock:(void(^)(NSTimeInterval countTime))endBlock;
-(void)reset;

@end

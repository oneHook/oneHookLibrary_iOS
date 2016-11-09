//
//  OHCircleToggleView.m
//  oneHookLibrary
//
//  Created by Eagle Diao@ToMore on 2016-11-08.
//  Copyright © 2016 oneHook inc. All rights reserved.
//

#import "OHCircleToggleView.h"

@interface OHCircleToggleView() {
    
}

@property (strong, nonatomic) CALayer* circleLayer;

@end

@implementation OHCircleToggleView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self) {
        self.circleLayer = [[CALayer alloc] init];
        self.circleLayer.backgroundColor = [UIColor whiteColor].CGColor;
        self.circleLayer.anchorPoint = CGPointMake(0.5, 0.5);
        
        [self.layer addSublayer:self.circleLayer];
        
        self.layer.borderColor = [UIColor whiteColor].CGColor;
        self.layer.borderWidth = 2;
    }
    return self;
}

- (void)layoutSubviews
{
    CGFloat width = CGRectGetWidth(self.frame);
    self.layer.cornerRadius = width / 2;
    
    self.circleLayer.cornerRadius = width / 4;
    self.circleLayer.position = CGPointMake(width / 2, width / 2);
}

- (void)renderSelected:(BOOL)selected animated:(BOOL)animated
{
    CGFloat width = CGRectGetWidth(self.frame);
    self.circleLayer.bounds = selected ? CGRectMake(0, 0, width / 2, width / 2) : CGRectMake(0, 0, 0, 0);
}

@end

//
//  OHProgressRingDemoViewController.m
//  oneHookLibrary
//
//  Created by Eagle Diao on 2015-11-12.
//  Copyright © 2015 oneHook inc. All rights reserved.
//

#import "OHProgressRingDemoViewController.h"
#import "OHAnimatedProgressRing.h"

@interface OHProgressRingDemoViewController() {
    
}

@property (strong, nonatomic) OHAnimatedProgressRing* ring1;
@property (strong, nonatomic) OHAnimatedProgressRing* ring2;
@property (strong, nonatomic) OHAnimatedProgressRing* ring3;

@end

@implementation OHProgressRingDemoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.ring1 = [self.view viewWithTag:1000];
    self.ring2 = [self.view viewWithTag:1001];
    self.ring3 = [self.view viewWithTag:1002];
    
    self.ring1.progressColor = [UIColor blueColor];
    self.ring2.progressColor = [UIColor blackColor];
    
    [self.ring1 setProgress:0.25 animated:NO];
    [self.ring2 setProgress:0.5 animated:NO];
    [self.ring3 setProgress:0.75 animated:NO];
    
    self.ring1.userInteractionEnabled = YES;
    self.ring2.userInteractionEnabled = YES;
    self.ring3.userInteractionEnabled = YES;
    
    [self.ring1 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ring1tapped:)]];
    [self.ring2 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ring2tapped:)]];
    [self.ring3 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ring3tapped:)]];
    
}

- (void)ring1tapped:(UITapGestureRecognizer*)rec
{
    self.ring1.progress = 0.3;
}


- (void)ring2tapped:(UITapGestureRecognizer*)rec
{
    [self.ring2 hideProgressRingWithDuration:2];
}

- (void)ring3tapped:(UITapGestureRecognizer*)rec
{
    [self.ring3 revealProgressRing];
}
@end

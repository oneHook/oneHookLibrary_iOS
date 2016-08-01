//
//  OHCutomActionSheet.m
//  oneHookLibrary
//
//  Created by Eagle Diao@ToMore on 2016-08-01.
//  Copyright © 2016 oneHook inc. All rights reserved.
//

#import "OHCustomActionSheet.h"

@implementation OHCustomActionSheet

- (id)init
{
    if (self = [super init])
    {
        [self commonInit];
    }
    return self;
}

- (void)commonInit
{
    NSLog(@"oh custom action sheet init");
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(orientationDidChange:)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil];
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5f];
}


- (void)dealloc
{
    NSLog(@"oh custom action sheet dealloc");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[UIDevice currentDevice] endGeneratingDeviceOrientationNotifications];
}


- (void)showInView:(UIView *)view
{
    [view addSubview:self];
    self.frame = CGRectMake(0, -100, CGRectGetWidth(view.bounds), 100);
    [UIView animateWithDuration:0.25 animations:^{
        self.frame = CGRectMake(0, 0, CGRectGetWidth(view.bounds), 100);
    }];
}

#pragma mark - Notification handlers

- (void)orientationDidChange:(NSNotification *)note
{
    NSLog(@"orientation change");
    
    self.frame = CGRectMake(0, 0, CGRectGetWidth(self.superview.bounds), 100);
}

@end

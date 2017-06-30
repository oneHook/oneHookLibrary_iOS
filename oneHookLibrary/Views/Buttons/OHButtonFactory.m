//
//  MOButtonFactory.m
//  Challenger
//
//  Created by Eagle Diao on 2015-08-12.
//  Copyright (c) 2015 myOptimity. All rights reserved.
//

#import "OHButtonFactory.h"
#import "OHColor.h"

@implementation OHButtonFactory

+(OHToolbarItem*)createToolbarActionButton {
    OHToolbarItem* button = [[OHToolbarItem alloc] init];
//    button.titleLabel.font = FONT_AWESOME_ICON(20);
    button.titleLabel.adjustsFontSizeToFitWidth = YES;
    
    [button setBackgroundColor:[UIColor clearColor] forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor colorWithWhite:1 alpha:0.2] forState:UIControlStateHighlighted];
    
    [button setTitleColor:WHITE forState:UIControlStateNormal];
    [button setTitleColor:WHITE forState:UIControlStateHighlighted];
    [button setTitleColor:WHITE forState:UIControlStateDisabled];
    
    return button;

}

@end

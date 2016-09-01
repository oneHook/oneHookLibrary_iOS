//
//  OHBaseSnackView.m
//  oneHookLibrary
//
//  Created by Eagle Diao on 2016-08-29.
//  Copyright © 2016 oneHook inc. All rights reserved.
//

#import "OHBaseSnackView.h"

@implementation OHBaseSnackView

- (id)init
{
    self = [super init];
    if(self) {
        self.idleTime = 2;
    }
    return self;
}

@end

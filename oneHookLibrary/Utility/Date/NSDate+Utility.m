//
//  NSDate+Utility.m
//  oneHookLibrary
//
//  Created by Eagle Diao on 2015-05-18.
//  Copyright (c) 2015 oneHook inc. All rights reserved.
//

#import "NSDate+Utility.h"

@implementation NSDate (Utility)

+ (NSDate *)beginningOfDay {
    NSCalendar *calendar = [NSCalendar currentCalendar];

    NSDateComponents *components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay
                                               fromDate:[[NSDate alloc] init]];

    return [calendar dateFromComponents:components];
}

+ (NSDate *)endOfDay {
    NSCalendar *calendar = [NSCalendar currentCalendar];

    NSDateComponents *components = [NSDateComponents new];
    components.day = 1;

    NSDate *date = [calendar dateByAddingComponents:components
                                             toDate:[NSDate beginningOfDay]
                                            options:0];

    date = [date dateByAddingTimeInterval:-1];

    return date;
}

@end

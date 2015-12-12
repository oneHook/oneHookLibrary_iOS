//
//  NSDate+Utility.h
//  oneHookLibrary
//
//  Created by Eagle Diao on 2015-05-18.
//  Copyright (c) 2015 oneHook inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Utility)

+ (NSDate *)beginningOfDay;
+ (NSDate *)endOfDay;

+ (NSDateFormatter*)isoDateFormatter;
- (NSString *)relativeTime;
- (NSString *)relativeTimeShort;

@end

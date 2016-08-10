//
//  NSDate+Utility.m
//  oneHookLibrary
//
//  Created by Eagle Diao on 2015-05-18.
//  Copyright (c) 2015 oneHook inc. All rights reserved.
//

#import "NSDate+Utility.h"
#import <UIKit/UIKit.h>
#import "OHMacros.h"


@interface DummyClass: NSObject
@end

@implementation DummyClass

@end


@implementation NSDate (Utility)

+ (NSString*)getWeekdaySymbolAt:(int)weekday
{
    switch (weekday) {
        case 0:
            return [NSDate localizedString:@"Sunday"];
        case 1:
            return [NSDate localizedString:@"Monday"];
        case 2:
            return [NSDate localizedString:@"Tuesday"];
        case 3:
            return [NSDate localizedString:@"Wednesday"];
        case 4:
            return [NSDate localizedString:@"Thursday"];
        case 5:
            return [NSDate localizedString:@"Friday"];
        case 6:
            return [NSDate localizedString:@"Saturday"];
        default:
            return @"Unknown";
            break;
    }
}

- (NSDate *)beginningOfDay
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond fromDate:self];
    components.hour = 0;
    components.minute = 0;
    components.second = 0;
    return [calendar dateFromComponents:components];
}

- (NSDate *)endOfDay
{
    NSDate* date = [self beginningOfDay];
    return [NSDate dateWithTimeInterval:86399 sinceDate:date];
}

- (NSDate *)yesterday
{
    return [self dateByAddingTimeInterval:-86400];
}

- (BOOL)isSameDay:(NSDate *)other
{
    if(!other) {
        return NO;
    }
    return [[self shortDate] isEqualToString:[other shortDate]];
}

+ (NSDateFormatter*)isoDateFormatter
{
    static NSDateFormatter* isoDateFormatter;
    if(!isoDateFormatter) {
        isoDateFormatter = [[NSDateFormatter alloc] init];
        [isoDateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];
    }
    return isoDateFormatter;
}

const int SECOND = 1;
const int MINUTE = 60*SECOND;
const int HOUR = 60*MINUTE;
const int DAY = HOUR*24;
const int WEEK = DAY*7;
const int MONTH = WEEK*4;
const int YEAR = DAY*365;

-(NSString *)relativeTime
{
    NSDate *currentDate = [NSDate date];
    long deltaSeconds = labs(lroundf([self timeIntervalSinceDate:currentDate]));
    BOOL dateInFuture = ([self timeIntervalSinceDate:currentDate] > 0);
    
    if(deltaSeconds < 2*SECOND) {
        return [NSDate localizedString: @"Now"];
    } else if(deltaSeconds < MINUTE) {
        return [self formattedStringForCurrentDate:currentDate count:deltaSeconds past:@"%d seconds ago" future:@"%d seconds from now"];
    } else if(deltaSeconds < 1.5*MINUTE) {
        return !dateInFuture ? [NSDate localizedString: @"A minute ago"] : [NSDate localizedString: @"A minute from now"];
    } else if(deltaSeconds < HOUR) {
        int minutes = (int)lroundf((float)deltaSeconds/(float)MINUTE);
        return [self formattedStringForCurrentDate:currentDate count:minutes past:@"%d minutes ago" future:@"%d minutes from now"];
    } else if(deltaSeconds < 1.5*HOUR) {
        return !dateInFuture ? [NSDate localizedString: @"An hour ago"] : [NSDate localizedString: @"An hour from now"];
    } else if(deltaSeconds < DAY) {
        int hours = (int)lroundf((float)deltaSeconds/(float)HOUR);
        return [self formattedStringForCurrentDate:currentDate count:hours past:@"%d hours ago" future:@"%d hours from now"];
    } else if(deltaSeconds < 1.5*DAY) {
        return !dateInFuture ? [NSDate localizedString: @"A day ago"] : [NSDate localizedString: @"A day from now"];
    } else if(deltaSeconds < WEEK) {
        int days = (int)lroundf((float)deltaSeconds/(float)DAY);
        return [self formattedStringForCurrentDate:currentDate count:days past:@"%d days ago" future:@"%d days from now"];
    } else if(deltaSeconds < 1.5*WEEK) {
        return !dateInFuture ? [NSDate localizedString: @"A week ago"] : [NSDate localizedString: @"A week from now"];
    } else if(deltaSeconds < MONTH) {
        int weeks = (int)lroundf((float)deltaSeconds/(float)WEEK);
        return [self formattedStringForCurrentDate:currentDate count:weeks past:@"%d weeks ago" future:@"%d weeks from now"];
    } else if(deltaSeconds < 1.5*MONTH) {
        return !dateInFuture ? [NSDate localizedString: @"A month ago"] : [NSDate localizedString: @"A month from now"];
    } else if(deltaSeconds < YEAR) {
        int months = (int)lroundf((float)deltaSeconds/(float)MONTH);
        return [self formattedStringForCurrentDate:currentDate count:months past:@"%d months ago" future:@"%d months from now"];
    } else if(deltaSeconds < 1.5*YEAR) {
        return !dateInFuture ? [NSDate localizedString: @"A year ago"] : [NSDate localizedString: @"A year from now"];
    } else {
        int years = (int)lroundf((float)deltaSeconds/(float)YEAR);
        return [self formattedStringForCurrentDate:currentDate count:years past:@"%d years ago" future:@"%d years from now"];
    }
}

- (NSString*)relativeTimeShort
{
    NSDate *currentDate = [NSDate date];
    long deltaSeconds = labs(lroundf([self timeIntervalSinceDate:currentDate]));
    
    if(deltaSeconds < 2*SECOND) {
        return [NSDate localizedString: @"Now"];
    } else if(deltaSeconds < MINUTE) {
        return [self formattedStringForCurrentDate:currentDate count:deltaSeconds past:@"%ds" future:@"in %ds"];
    }else if(deltaSeconds < HOUR) {
        int minutes = (int)lroundf((float)deltaSeconds/(float)MINUTE);
        return [self formattedStringForCurrentDate:currentDate count:minutes past:@"%dm" future:@"in %dm"];
    } else if(deltaSeconds < DAY) {
        int hours = (int)lroundf((float)deltaSeconds/(float)HOUR);
        return [self formattedStringForCurrentDate:currentDate count:hours past:@"%dh" future:@"in %dh"];
    } else if(deltaSeconds < WEEK) {
        int days = (int)lroundf((float)deltaSeconds/(float)DAY);
        return [self formattedStringForCurrentDate:currentDate count:days past:@"%dd" future:@"in %dd"];
    } else if(deltaSeconds < MONTH) {
        int weeks = (int)lroundf((float)deltaSeconds/(float)WEEK);
        return [self formattedStringForCurrentDate:currentDate count:weeks past:@"%dw" future:@"in %dw"];
    } else if(deltaSeconds < YEAR) {
        int months = (int)lroundf((float)deltaSeconds/(float)MONTH);
        return [self formattedStringForCurrentDate:currentDate count:months past:@"%dm" future:@"in %dm"];
    } else {
        int years = (int)lroundf((float)deltaSeconds/(float)YEAR);
        return [self formattedStringForCurrentDate:currentDate count:years past:@"%dy" future:@"in %dy"];
    }
}

-(NSString *)formattedStringForCurrentDate:(NSDate *)currentDate count:(long)count past:(NSString *)past future:(NSString *)future
{
    if ([self timeIntervalSinceDate:currentDate] > 0) {
        return [NSString stringWithFormat:[NSDate localizedString:future], count];
    } else {
        return [NSString stringWithFormat:[NSDate localizedString:past], count];
    }
}

+(NSString *)localizedString:(NSString *)key
{
    static NSBundle *bundle;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        bundle = [NSBundle bundleWithPath:[[[NSBundle bundleForClass:[DummyClass class]] resourcePath] stringByAppendingPathComponent:@"NSDate+Utility.bundle"]];
    });
    return NSLocalizedStringFromTableInBundle(key, @"NSDate+Utility", bundle, nil);
}

- (NSString *)shortDate
{
    static NSDateFormatter* dateFormatter;
    if(!dateFormatter) {
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:[NSDate localizedString:@"shortDateNoYearFormat"]];
    }
    return [dateFormatter stringFromDate:self];
}

- (NSString *)shortDateWithYear
{
    static NSDateFormatter* dateFormatter;
    if(!dateFormatter) {
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:[NSDate localizedString:@"shortDateWithYearFormat"]];
    }
    return [dateFormatter stringFromDate:self];
}

- (NSString *)shortTime
{
    static NSDateFormatter* dateFormatter;
    if(!dateFormatter) {
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"hh:mm a"];
    }
    return [dateFormatter stringFromDate:self];
}

- (NSString *)shortWeek
{
    NSCalendar* cal = [NSCalendar currentCalendar];
    int weekday = 0;
    if(OLDER_VERSION) {
        NSDateComponents* comp = [cal components:NSWeekdayCalendarUnit fromDate:self];
        weekday = (int) [comp weekday];
    } else {
        NSDateComponents* comp = [cal components:NSCalendarUnitWeekday fromDate:self];
        weekday = (int) [comp weekday];
    }
    switch(weekday) {
        case 1:
            return @"SU";
        case 2:
            return @"M";
        case 3:
            return @"TU";
        case 4:
            return @"W";
        case 5:
            return @"TH";
        case 6:
            return @"F";
        case 7:
            return @"SA";
            default:
            return @"";
            
    }
}

- (NSString *)shortDateUTC
{
    static NSDateFormatter* dateFormatter;
    if(!dateFormatter) {
        dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
        [dateFormatter setDateFormat:@"MMM dd"];
    }
    return [dateFormatter stringFromDate:self];
}

- (NSString *)shortDateWithYearUTC
{
    static NSDateFormatter* dateFormatter;
    if(!dateFormatter) {
        dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
        [dateFormatter setDateFormat:@"MMM dd, yyyy"];
    }
    return [dateFormatter stringFromDate:self];
}

- (NSString *)shortWeekUTC
{
    NSCalendar* cal = [NSCalendar currentCalendar];
    cal.timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    int weekday = 0;
    if(OLDER_VERSION) {
        NSDateComponents* comp = [cal components:NSWeekdayCalendarUnit fromDate:self];
        weekday = (int) [comp weekday];
    } else {
        NSDateComponents* comp = [cal components:NSCalendarUnitWeekday fromDate:self];
        weekday = (int) [comp weekday];
    }
    switch(weekday) {
        case 1:
            return @"SU";
        case 2:
            return @"M";
        case 3:
            return @"TU";
        case 4:
            return @"W";
        case 5:
            return @"TH";
        case 6:
            return @"F";
        case 7:
            return @"SA";
        default:
            return @"";
            
    }
}

- (int)year
{
    NSCalendar* cal = [NSCalendar currentCalendar];
    int year = 0;
    if(OLDER_VERSION) {
        NSDateComponents* comp = [cal components:NSYearCalendarUnit fromDate:self];
        year = (int) [comp year];
    } else {
        NSDateComponents* comp = [cal components:NSCalendarUnitYear fromDate:self];
        year = (int) [comp year];
    }
    return year;
}

@end

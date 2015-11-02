//
//  NSString+Utility.m
//  oneHookLibrary
//
//  Created by Eagle Diao on 2015-10-31.
//  Copyright © 2015 oneHook inc. All rights reserved.
//

#import "NSString+Utility.h"

@implementation NSString (Utility)

- (NSString*)capitalize
{
    if(self.length > 0) {
        return [[[self substringToIndex:1] uppercaseString] stringByAppendingString:[[self substringFromIndex:1] lowercaseString]];
    }
    return self;
}

+ (BOOL)isEmpty:(NSString *)text
{
    return text == nil || text.length == 0;
}

@end

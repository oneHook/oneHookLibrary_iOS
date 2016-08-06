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
    return text == nil || text == [NSNull null] || text.length == 0;
}

-(BOOL)isEmailAddress
{
    BOOL stricterFilter = NO; // Discussion http://blog.logichigh.com/2010/09/02/validating-an-e-mail-address/
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

@end

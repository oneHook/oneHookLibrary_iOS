//
//  NSString+Utility.h
//  oneHookLibrary
//
//  Created by Eagle Diao on 2015-10-31.
//  Copyright © 2015 oneHook inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Utility)

- (NSString*)capitalize;
+ (BOOL)isEmpty:(NSString*)text;
- (BOOL)isEmailAddress;
- (NSString *)MD5;

- (NSString *)urlencode;

- (NSString *)stringByTrimmingLeadingCharactersInSet:(NSCharacterSet *)characterSet;
- (NSString *)stringByTrimmingLeadingWhitespaceAndNewlineCharacters;
- (NSString *)stringByTrimmingTrailingCharactersInSet:(NSCharacterSet *)characterSet;
- (NSString *)stringByTrimmingTrailingWhitespaceAndNewlineCharacters;

@end

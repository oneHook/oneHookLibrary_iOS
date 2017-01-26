//
//  OHLocalization.m
//  oneHookLibrary
//
//  Created by Eagle Diao@Optimity on 2017-01-26.
//  Copyright © 2017 oneHook inc. All rights reserved.
//

#import "OHLocalization.h"

@interface DummyClass: NSObject
@end

@implementation DummyClass

@end

@implementation OHLocalization

+(NSString *)localizedString:(NSString *)key
{
    static NSBundle *bundle;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        bundle = [NSBundle bundleWithPath:[[[NSBundle bundleForClass:[DummyClass class]] resourcePath] stringByAppendingPathComponent:@"oneHookLibrary.bundle"]];
    });
    return NSLocalizedStringFromTableInBundle(key, @"oneHookLibrary", bundle, nil);
}

@end

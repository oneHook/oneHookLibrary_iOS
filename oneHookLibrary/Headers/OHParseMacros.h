//
//  OHParseMacros.h
//  oneHookLibrary
//
//  Created by EagleDiao@Optimity on 2017-07-18.
//  Copyright © 2017 oneHook inc. All rights reserved.
//

#ifndef OHParseMacros_h
#define OHParseMacros_h

#define IS_NULL(v) (!v || [v isEqual:[NSNull null]])

#define PARSE_NUMBER(v, d) (v && ![v isEqual:[NSNull null]]) ? v : [NSNumber numberWithInt:d];
#define PARSE_NUMBER_NULLABLE(v) (v && ![v isEqual:[NSNull null]]) ? v : nil;

#define PARSE_INTEGER(v, d) (v && ![v isEqual:[NSNull null]]) ? ((NSNumber*)v).integerValue : d;
#define PARSE_INT(v, d) (v && ![v isEqual:[NSNull null]]) ? ((NSNumber*)v).intValue : d;
#define PARSE_BOOL(v, d) (v && ![v isEqual:[NSNull null]]) ? ((NSNumber*)v).boolValue : d;

#define PARSE_STRING(v, d) (v && ![v isEqual:[NSNull null]]) ? v : d;
#define PARSE_STRING_NULLABLE(v) (v && ![v isEqual:[NSNull null]]) ? v : nil;

#endif /* OHParseMacros_h */

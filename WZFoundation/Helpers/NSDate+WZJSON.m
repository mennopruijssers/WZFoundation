//
//  NSDate+WZJSON.m
//  WZFoundation
//
//  Created by Menno on 30-03-12.
//  Copyright (c) 2012 Wyzers. All rights reserved.
//

#import "NSDate+WZJSON.h"

MAKE_CATEGORIES_LOADABLE(NSDATE_WZJSON)

@implementation NSDate (WZJSON)
+ (NSDateFormatter *) dateFormatterForFormat: (enum JSONDateFormat) format {
    NSDateFormatter *formatter;
    
    switch (format) {
        case kJSONDateFormatDate: {
            static NSDateFormatter *dateFormatter;
            if(dateFormatter == nil) {
                dateFormatter = [[NSDateFormatter alloc] init];
                [dateFormatter setDateFormat:@"yyyy-MM-dd"];
                [dateFormatter setLocale:[NSLocale currentLocale]];
            }
            formatter = dateFormatter;
            
            break;
        }
        case kJSONDateFormatTime: {
            static NSDateFormatter *timeFormatter;
            if (timeFormatter == nil) {
                NSAssert(false, @"TODO!");
            }                        
        }
        case kJSONDateFormatTimestamp: {
            static NSDateFormatter *timestampFormatter;
            
            if (timestampFormatter == nil) {
                NSAssert(false, @"TODO!");
            }            
        }
    }
    return formatter;
}

- (NSString *)JSONDate:(enum JSONDateFormat)format {
    
    NSDateFormatter *formatter = [[self class] dateFormatterForFormat:format];
    if(formatter) {
        return [formatter stringFromDate:self];
    } else {
        return nil;
    }
}

+ (NSDate *) dateFromJSON:(NSString *)json withFormat:(enum JSONDateFormat) format {
    
    if(json == nil) {
        return nil;
    }
    
    NSDateFormatter *formatter = [self dateFormatterForFormat:format];
    
    if(formatter) {
        return [formatter dateFromString:json];
    } else {
        return nil;
    }
}
@end

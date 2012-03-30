//
//  NSDate+WZJSON.h
//  WZFoundation
//
//  Created by Menno on 30-03-12.
//  Copyright (c) 2012 Wyzers. All rights reserved.
//

#import <Foundation/Foundation.h>

enum JSONDateFormat {
    kJSONDateFormatDate = 0,
    kJSONDateFormatTime = 1,
    kJSONDateFormatTimestamp = 2
};

@interface NSDate (WZJSON)
- (NSString*) JSONDate: (enum JSONDateFormat) format;
+ (NSDate *) dateFromJSON:(NSString *)json withFormat:(enum JSONDateFormat) format;
@end

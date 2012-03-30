//
//  NSArray+WZHelpers.m
//  WZFoundation
//
//  Created by Menno on 07-03-12.
//  Copyright (c) 2012 Wyzers. All rights reserved.
//

#import "NSArray+WZHelpers.h"

MAKE_CATEGORIES_LOADABLE(NSArray_WZHelpers)

@implementation NSArray (WZHelpers)
- (id)initWithObject:(id)object {
    return [self initWithObjects:object, nil];
}

- (BOOL)isEmpty {
    return [self count] == 0;
}

- (id)firstObject {
    if([self isEmpty]) {
        return nil;
    }

    return [self objectAtIndex:0];
}

- (NSString*)join {
    NSMutableString *string = [NSMutableString string];
    
    for(id object in self) {
        if([string length] > 0) {
            [string appendString:@", "];
        }
        [string appendString:object];
    }
    
    return string;
}
@end

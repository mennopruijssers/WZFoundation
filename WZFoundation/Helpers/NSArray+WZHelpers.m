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
- (BOOL)isEmpty {
    return [self count] == 0;
}

- (id)firstObject {
    if([self isEmpty]) {
        return nil;
    }

    return [self objectAtIndex:0];
}
@end

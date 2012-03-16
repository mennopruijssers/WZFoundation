//
//  NSDictionary+Wyzers.m
//  WZFoundation
//
//  Created by Menno on 16-03-12.
//  Copyright (c) 2012 Wyzers. All rights reserved.
//

#import "NSDictionary+Wyzers.h"

MAKE_CATEGORIES_LOADABLE(NSDICTIONARY_WYZERS)

@implementation NSDictionary (Wyzers)
- (BOOL) containsObjectForKey: (id) key {
    id value = [self objectForKey:key];
    
    return value != nil;    
}
@end

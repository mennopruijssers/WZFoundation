//
//  NSArray+WZHelpers.h
//  WZFoundation
//
//  Created by Menno on 07-03-12.
//  Copyright (c) 2012 Wyzers. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (WZHelpers)
- (id) initWithObject: (id) object;
- (BOOL) isEmpty;
- (id) firstObject;

- (NSString*) join;
@end

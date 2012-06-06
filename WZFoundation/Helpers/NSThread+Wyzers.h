//
//  NSThread+Wyzers.h
//  WZFoundation
//
//  Created by Menno on 06-06-12.
//  Copyright (c) 2012 Wyzers. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSThread (Wyzers)
- (void)performBlock:(void (^)())block;
- (void)performBlock:(void (^)())block waitUntilDone:(BOOL)wait;
- (void) performBlock:(void (^)())block afterDelay: (NSTimeInterval) delay;
+ (void)performBlockInBackground:(void (^)())block;
+ (void) performBlockOnMainThread:(void (^)())block;
@end

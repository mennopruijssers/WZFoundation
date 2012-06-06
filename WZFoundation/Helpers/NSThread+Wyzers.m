//
//  NSThread+Wyzers.m
//  WZFoundation
//
//  Created by Menno on 06-06-12.
//  Copyright (c) 2012 Wyzers. All rights reserved.
//

#import "NSThread+Wyzers.h"

@implementation NSThread (Wyzers)
- (void)performBlock:(void (^)())block
{
	if ([[NSThread currentThread] isEqual:self])
		block();
	else
		[self performBlock:block waitUntilDone:NO];
}

- (void)ng_runBlock:(void (^)())block
{
	block();
}

- (void) performBlock:(void (^)())block afterDelay: (NSTimeInterval) delay {           
    [self performSelector:@selector(ng_runBlock:) withObject:[block copy] afterDelay:delay];
}
- (void)performBlock:(void (^)())block waitUntilDone:(BOOL)wait
{
    [NSThread performSelector:@selector(ng_runBlock:)
                     onThread:self
                   withObject:[block copy]
                waitUntilDone:wait];
}
+ (void)ng_runBlock:(void (^)())block
{
	block();
}
+ (void)performBlockInBackground:(void (^)())block
{
	[NSThread performSelectorInBackground:@selector(ng_runBlock:)
	                           withObject:[block copy]];
}
+ (void)performBlockOnMainThread:(void (^)())block {
    [[NSThread mainThread] performBlock:block];
}
@end

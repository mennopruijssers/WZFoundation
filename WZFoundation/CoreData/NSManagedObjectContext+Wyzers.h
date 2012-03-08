//
//  NSManagedObjectContext+Wyzers.h
//  WZFoundation
//
//  Created by Menno on 07-03-12.
//  Copyright (c) 2012 Wyzers. All rights reserved.
//



@interface NSManagedObjectContext (Wyzers)
#pragma mark Change notification observation
- (void) observeContext:(NSManagedObjectContext *) otherContext;
- (void) stopOpbserveContext:(NSManagedObject *) otherContext;

#pragma mark Save
- (BOOL) save;
- (BOOL) saveWithErrorHandler: (void (^)(NSError *)) errorHandler;
@end

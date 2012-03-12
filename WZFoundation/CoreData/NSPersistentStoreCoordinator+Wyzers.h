//
//  NSPersistentStoreCoordinator+Wyzers.h
//  WZFoundation
//
//  Created by Menno on 09-03-12.
//  Copyright (c) 2012 Wyzers. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSPersistentStoreCoordinator (Wyzers)
- (NSPersistentStore *) addSQLiteStoreWithName: (NSString *) name automigrating: (BOOL) autoMigrating;
- (NSPersistentStore *) addSQLiteStoreWithUL: (NSURL *) url automigrating: (BOOL) autoMigrating;

- (NSManagedObjectContext *) managedObjectContextForDispatchQueue: (dispatch_queue_t) queue;
- (NSManagedObjectContext *) managedObjectContextForCurrentQueue;
@end

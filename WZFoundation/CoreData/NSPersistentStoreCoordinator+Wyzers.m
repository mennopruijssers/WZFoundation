//
//  NSPersistentStoreCoordinator+Wyzers.m
//  WZFoundation
//
//  Created by Menno on 09-03-12.
//  Copyright (c) 2012 Wyzers. All rights reserved.
//

#import "NSPersistentStoreCoordinator+Wyzers.h"
#import "WZHelpers.h"
#import "WZCoreDataHelper.h"
#import "NSManagedObjectContext+Wyzers.h"

static NSObject *KEY = @"DispatchQueueManagedObjectContext";

MAKE_CATEGORIES_LOADABLE(NSPersistentStoreCoordinator_Wyzers)

@implementation NSPersistentStoreCoordinator (Wyzers)
- (NSPersistentStore *)addSQLiteStoreWithName:(NSString *)name automigrating:(BOOL)autoMigrating {
    NSString *basePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *filePath = [basePath stringByAppendingPathComponent:name];
    NSURL *storeUrl = [NSURL fileURLWithPath:filePath];
    
    return [self addSQLiteStoreWithUL:storeUrl automigrating:autoMigrating];
}

- (NSPersistentStore *)addSQLiteStoreWithUL:(NSURL *)url automigrating:(BOOL)autoMigrating {    
    NSError *error = nil;

    NSDictionary *options;
    if(autoMigrating) {
        options = [NSDictionary dictionaryWithObjectsAndKeys:
                                 [NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption,
                                 [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption,
                                 nil];
    } else {
        options = nil;
    }
    
    NSPersistentStore *store = [self addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:url options:options error:&error];
    
    if(error) {
        [WZCoreDataHelper handleError:error];
    }
    
    return store;
}

static void QueueRelease(void* context ){
    NSManagedObjectContext *managedObjectContext = (__bridge_transfer NSManagedObjectContext *) context;
    NSManagedObjectContext *mainContext = [[managedObjectContext persistentStoreCoordinator] managedObjectContextForDispatchQueue:dispatch_get_main_queue()];

    if(mainContext != managedObjectContext) {
        [mainContext stopOpbserveContext:managedObjectContext];
        [managedObjectContext stopOpbserveContext:mainContext];
    }
    mainContext = nil;
    managedObjectContext = nil;
}

- (NSManagedObjectContext *)managedObjectContextForDispatchQueue:(dispatch_queue_t)queue {    
    if (queue == dispatch_get_main_queue()) {
        NSMutableDictionary *threadDic = [[NSThread mainThread] threadDictionary];
        
        static NSString *key = @"WZManagedObjectContext";
        if([threadDic containsObjectForKey:key]) {
            return [threadDic objectForKey:key];
        } else {
            NSManagedObjectContext *context = [[NSManagedObjectContext alloc] init];
            [context setPersistentStoreCoordinator:self];
            [threadDic setObject:context forKey:key];
            
            return context;
        }
    }
    __block NSManagedObjectContext *result;
    
    dispatch_block_t block = ^{
        NSManagedObjectContext *context = (__bridge NSManagedObjectContext *) dispatch_get_specific((__bridge void *)KEY);
        if (context != NULL) {
            result = context;
            return;
        }            
    };
    
    if(dispatch_get_current_queue() == queue) {
        block();
    } else {
        dispatch_sync(queue, block);
    }
    
    if(result == NULL) {            
        result = [[NSManagedObjectContext alloc] init];                        
        [result setPersistentStoreCoordinator:self];
        
        if(queue != dispatch_get_main_queue()) {
            NSManagedObjectContext *mainContext = [self managedObjectContextForDispatchQueue:dispatch_get_main_queue()];
            [mainContext observeContext:result];
            [result observeContext:mainContext];
        }

        //released in QueueRelease handler
#ifndef __clang_analyzer__
        dispatch_queue_set_specific(queue, (__bridge void*) KEY, (__bridge_retained void*)result, QueueRelease);        
#endif
    }
    
    return result;        
}

- (NSManagedObjectContext *)managedObjectContextForCurrentQueue {
    return [self managedObjectContextForDispatchQueue:dispatch_get_current_queue()];
}
@end

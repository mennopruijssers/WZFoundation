//
//  NSManagedObjectContext+Wyzers.m
//  WZFoundation
//
//  Created by Menno on 07-03-12.
//  Copyright (c) 2012 Wyzers. All rights reserved.
//

#import "NSManagedObjectContext+Wyzers.h"
#import "WZCoreDataHelper.h"
MAKE_CATEGORIES_LOADABLE(NSManagedObjectContext_Wyzers)

@interface NSManagedObjectContext (WyzersPrivate)
- (void) mergeChanges: (NSNotification *) notification;
@end

@implementation NSManagedObjectContext (Wyzers)
- (void)mergeChanges:(NSNotification *)notification {
    [self mergeChangesFromContextDidSaveNotification:notification];
}
#pragma mark Change notification observation
- (void)observeContext:(NSManagedObjectContext *)otherContext {    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(mergeChanges:) name:NSManagedObjectContextDidSaveNotification object:otherContext];
}

- (void) stopOpbserveContext:(NSManagedObjectContext *)otherContext {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NSManagedObjectContextDidSaveNotification object:otherContext];
}

#pragma mark Save
- (BOOL)save {
    NSError *error = nil;
    BOOL saved = [self save:&error];
    if(error) {
        [WZCoreDataHelper handleError:error];
    }
    return saved;
}

- (BOOL)saveWithErrorHandler:(void (^)(NSError *))errorHandler {
    NSError *error = nil;
    BOOL result = NO;

    result = [self save:&error];

    if(!result && error) {
        if(errorHandler) {
            errorHandler(error);
        } else {
            [WZCoreDataHelper handleError:error];
        }
    }
    return result;
}
@end

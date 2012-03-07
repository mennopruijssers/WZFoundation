//
//  NSManagedObject+Wyzers.m
//  WZFoundation
//
//  Created by Menno on 07-03-12.
//  Copyright (c) 2012 Wyzers. All rights reserved.
//

#import "NSManagedObject+Wyzers.h"
#import "WZCoreDataHelper.h"
#import "WZHelpers.h"

MAKE_CATEGORIES_LOADABLE(NSManagedObject_Wyzers)

@implementation NSManagedObject (Wyzers)
- (id)fromContext:(NSManagedObjectContext *)context {
    NSError *error = nil;

    id other = [context existingObjectWithID:[self objectID] error:&error];
    
    if(error) {
        [WZCoreDataHelper handleError:error];
    }
    
    return other;
}

+ (NSString *) entityName {
    return NSStringFromClass(self);
}

+ (NSEntityDescription *) entityDescriptionInContext: (NSManagedObjectContext *) context {
    return [NSEntityDescription entityForName:[self entityName] inManagedObjectContext:context];
}

+ (NSArray *)executeFetchRequest:(NSFetchRequest *)request inContext:(NSManagedObjectContext *)context {
    NSError *error = nil;
	
	NSArray *results = [context executeFetchRequest:request error:&error];
    
    if(results == nil) {
        [WZCoreDataHelper handleError: error];
    }    
    
    return results;
}

+ (id)executeFetchRequest:(NSFetchRequest *)request andReturnFirstinContext:(NSManagedObjectContext *)context {
    [request setFetchLimit:1];
    
    NSArray *results = [self executeFetchRequest:request inContext:context];
    
    return [results firstObject];
}

+ (NSArray *)findAllInContext:(NSManagedObjectContext *)context {
    return [self executeFetchRequest:[self requestInContext:context] inContext:context];     
}

+ (NSArray *)findAllInContext:(NSManagedObjectContext *)context sortedBy:(NSString *)sortTerm ascending:(BOOL)ascending {
    return [self executeFetchRequest:[self requestInContext:context sortedBy:sortTerm ascending:ascending] inContext:context];    
}

+ (NSArray *)findAllInContext:(NSManagedObjectContext *)context filteredBy:(NSPredicate *)searchTerm {
    return [self executeFetchRequest:[self requestInContext:context filtedBy:searchTerm] inContext:context];            
}

+ (NSFetchRequest *)requestInContext:(NSManagedObjectContext *)context {
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    [request setEntity:[self entityDescriptionInContext:context]];
    
    return request;
}

+ (NSFetchRequest *)requestInContext:(NSManagedObjectContext *)context sortedBy:(NSString *)sortTerm ascending:(BOOL)ascending {
    NSFetchRequest *request = [self requestInContext:context];

    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:sortTerm ascending:ascending];
    NSArray *descriptors = [[NSArray alloc] initWithObject:sortDescriptor];
    
    [request setSortDescriptors:descriptors];
    
    return request;
}

+ (NSFetchRequest *)requestInContext:(NSManagedObjectContext *)context filtedBy:(NSPredicate *)predicate {
    NSFetchRequest *request = [self requestInContext:context];
        
    [request setPredicate:predicate];
    
    return request;
}

+ (id)findFirstInContext:(NSManagedObjectContext *)context {
    return [self executeFetchRequest:[self requestInContext:context] andReturnFirstinContext:context];
}

+ (id)findFirstInContext:(NSManagedObjectContext *)context filteredBy:(NSPredicate *)predicate {
    return [self executeFetchRequest:[self requestInContext:context filtedBy:predicate] andReturnFirstinContext:context];
}

+ (id)findFirstInContext:(NSManagedObjectContext *)context sortedBy:(NSString *)sortTerm ascending:(BOOL)ascending {
    return [self executeFetchRequest:[self requestInContext:context sortedBy:sortTerm ascending:ascending] andReturnFirstinContext:context];
}
@end

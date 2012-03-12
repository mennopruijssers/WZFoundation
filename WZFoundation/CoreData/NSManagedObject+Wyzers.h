//
//  NSManagedObject+Wyzers.h
//  WZFoundation
//
//  Created by Menno on 07-03-12.
//  Copyright (c) 2012 Wyzers. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSManagedObject (Wyzers)
#pragma mark Instance methods
- (id) fromContext: (NSManagedObjectContext*) context;
- (void) deleteInContext: (NSManagedObjectContext*) context; 

#pragma mark Class Methods
#pragma mark - Descriptors
+ (NSString *) entityName;
+ (NSEntityDescription *) entityDescriptionInContext: (NSManagedObjectContext *) context;

#pragma mark - Helpers
+ (NSArray *) executeFetchRequest: (NSFetchRequest *) request inContext:(NSManagedObjectContext *) context;
+ (id) executeFetchRequest: (NSFetchRequest *) request andReturnFirstinContext:(NSManagedObjectContext *) context;

+ (NSFetchRequest *) requestInContext:(NSManagedObjectContext *) context;
+ (NSFetchRequest *) requestInContext:(NSManagedObjectContext *)context sortedBy: (NSString *) sortTerm ascending:(BOOL) ascending;
+ (NSFetchRequest *) requestInContext:(NSManagedObjectContext *)context filtedBy: (NSPredicate *) searchTerm;


#pragma mark Finders
+ (NSArray *) findAllInContext:(NSManagedObjectContext *) context;
+ (NSArray *) findAllInContext:(NSManagedObjectContext *) context sortedBy: (NSString *) sortTerm ascending:(BOOL) ascending;
+ (NSArray *) findAllInContext:(NSManagedObjectContext *) context filteredBy: (NSPredicate *) searchTerm;

+ (id) findFirstInContext:(NSManagedObjectContext *) context;
+ (id) findFirstInContext:(NSManagedObjectContext *) context sortedBy: (NSString *) sortTerm ascending:(BOOL) ascending;
+ (id) findFirstInContext:(NSManagedObjectContext *) context filteredBy: (NSPredicate *) predicate;

#pragma mark Create
+ (id) insertInContext: (NSManagedObjectContext *) context;
@end

//
//  NSManagedObject+Wyzers.h
//  WZFoundation
//
//  Created by Menno on 07-03-12.
//  Copyright (c) 2012 Wyzers. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSManagedObject (Wyzers)
- (id) fromContext: (NSManagedObjectContext*) context;


+ (NSString *) entityName;
+ (NSEntityDescription *) entityDescriptionInContext: (NSManagedObjectContext *) context;

+ (NSArray *) findAllInContext:(NSManagedObjectContext *) context;
+ (NSArray *) findAllInContext:(NSManagedObjectContext *) context sortedBy: (NSString *) sortTerm ascending:(BOOL) ascending;
+ (NSArray *) findAllInContext:(NSManagedObjectContext *) context filteredBy: (NSPredicate *) searchTerm;

+ (NSFetchRequest *) requestAllInContext:(NSManagedObjectContext *) context;
+ (NSFetchRequest *) requestAllInContext:(NSManagedObjectContext *)context sortedBy: (NSString *) sortTerm ascending:(BOOL) ascending;
+ (NSFetchRequest *) requestAllInContext:(NSManagedObjectContext *)context filtedBy: (NSPredicate *) searchTerm;

+ (id) findFirstInContext:(NSManagedObjectContext *) context;
+ (id) findFirstInContext:(NSManagedObjectContext *) context sortedBy: (NSString *) sortTerm ascending:(BOOL) ascending;
+ (id) findFirstInContext:(NSManagedObjectContext *) context filteredBy: (NSPredicate *) searchTerm;
@end

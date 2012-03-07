//
//  NSManagedObject+Wyzers.m
//  WZFoundation
//
//  Created by Menno on 07-03-12.
//  Copyright (c) 2012 Wyzers. All rights reserved.
//

#import "NSManagedObject+Wyzers.h"

@implementation NSManagedObject (Wyzers)
+ (NSString *) entityName {
    return NSStringFromClass(self);
}

+ (NSEntityDescription *) entityDescriptionInContext: (NSManagedObjectContext *) context {
    return [NSEntityDescription entityForName:[self entityName] inManagedObjectContext:context];
}

+ (NSArray *)findAllInContext:(NSManagedObjectContext *)context {
    
}

+ (NSFetchRequest *)requestAllInContext:(NSManagedObjectContext *)context {
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    [request setEntity:[self entityDescriptionInContext:context]];
    
    return request;
}
@end

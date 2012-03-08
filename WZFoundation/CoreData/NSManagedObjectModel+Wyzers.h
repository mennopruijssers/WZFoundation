//
//  NSManagedObjectModel+Wyzers.h
//  WZFoundation
//
//  Created by Menno on 08-03-12.
//  Copyright (c) 2012 Wyzers. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSManagedObjectModel (Wyzers)
+ (NSManagedObjectModel *) newManagedObjectModel;
+ (NSManagedObjectModel *) newManagedObjectModelNamed:(NSString*) fileName;
@end

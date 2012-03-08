//
//  NSManagedObjectModel+Wyzers.m
//  WZFoundation
//
//  Created by Menno on 08-03-12.
//  Copyright (c) 2012 Wyzers. All rights reserved.
//

#import "NSManagedObjectModel+Wyzers.h"

MAKE_CATEGORIES_LOADABLE(NSManagedObjectModel_Wyzers)
@implementation NSManagedObjectModel (Wyzers)
+ (NSManagedObjectModel *)newManagedObjectModel {
    return [self mergedModelFromBundles:nil];
}

+ (NSManagedObjectModel *)newManagedObjectModelNamed:(NSString *)fileName {
    NSString *path = [[NSBundle mainBundle] pathForResource:[fileName stringByDeletingPathExtension] 
                                                     ofType:[fileName pathExtension]];
	NSURL *momURL = [NSURL fileURLWithPath:path];

    return [[NSManagedObjectModel alloc] initWithContentsOfURL:momURL];
}
@end

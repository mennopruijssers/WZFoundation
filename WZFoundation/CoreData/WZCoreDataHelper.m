//
//  WZCoreDataHelper.m
//  WZFoundation
//
//  Created by Menno on 07-03-12.
//  Copyright (c) 2012 Wyzers. All rights reserved.
//

#import "WZCoreDataHelper.h"

@implementation WZCoreDataHelper
+ (void)handleError:(NSError *)error {
    NSLog(@"Core Data Error: %@", error);
    abort();
}
@end

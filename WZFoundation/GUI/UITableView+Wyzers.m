//
//  UITableView+Wyzers.m
//  WZFoundation
//
//  Created by Menno on 23-03-12.
//  Copyright (c) 2012 Wyzers. All rights reserved.
//

#import "UITableView+Wyzers.h"

MAKE_CATEGORIES_LOADABLE(UITABLEVIEW_WYZERS)
@implementation UITableView (Wyzers)
- (NSIndexPath *)indexPathForLastCell {
    NSInteger section = [self numberOfSections] -1;
    
    if(section < 0) {
        return NULL;
    }
    
    NSInteger row = [self numberOfRowsInSection:section] - 1;
    
    if(row < 0) {
        return NULL;
    }
    
    return [NSIndexPath indexPathForRow:row inSection:section];
}
@end

//
//  UIView+Wyzers.m
//  WZFoundation
//
//  Created by Menno on 16-06-12.
//  Copyright (c) 2012 Wyzers. All rights reserved.
//

#import "UIView+Wyzers.h"

@implementation UIView (Wyzers)
- (void)bringToFront {
    [[self superview] bringSubviewToFront:self];
}
@end

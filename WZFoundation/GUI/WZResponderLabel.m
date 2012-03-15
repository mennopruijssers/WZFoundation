//
//  WZResponderLabel.m
//  WZFoundation
//
//  Created by Menno on 14-03-12.
//  Copyright (c) 2012 Wyzers. All rights reserved.
//

#import "WZResponderLabel.h"

@implementation WZResponderLabel
- (BOOL)canBecomeFirstResponder {
    return YES;
}

@synthesize inputView;

@end

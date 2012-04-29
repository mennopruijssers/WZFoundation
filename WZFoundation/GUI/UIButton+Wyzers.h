//
//  UIButton+Wyzers.h
//  WZFoundation
//
//  Created by Menno on 29-04-12.
//  Copyright (c) 2012 Wyzers. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Wyzers)
- (void) makeBackgroundStretchableImageWithLeftCapWidth:(NSInteger)leftCapWidth topCapHeight:(NSInteger)topCapHeight;
- (void) makeBackgroundStretchableImageWithLeftCapWidth:(NSInteger)leftCapWidth topCapHeight:(NSInteger)topCapHeight forState: (UIControlState) controlState;

@end

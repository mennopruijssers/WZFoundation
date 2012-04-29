//
//  UIButton+Wyzers.m
//  WZFoundation
//
//  Created by Menno on 29-04-12.
//  Copyright (c) 2012 Wyzers. All rights reserved.
//

#import "UIButton+Wyzers.h"

MAKE_CATEGORIES_LOADABLE(UIButton_Wyzers)
@implementation UIButton (Wyzers)
- (void)makeBackgroundStretchableImageWithLeftCapWidth:(NSInteger)leftCapWidth topCapHeight:(NSInteger)topCapHeight {
    [self makeBackgroundStretchableImageWithLeftCapWidth:leftCapWidth topCapHeight:topCapHeight forState:UIControlStateNormal];
    [self makeBackgroundStretchableImageWithLeftCapWidth:leftCapWidth topCapHeight:topCapHeight forState:UIControlStateSelected];
    [self makeBackgroundStretchableImageWithLeftCapWidth:leftCapWidth topCapHeight:topCapHeight forState:UIControlStateDisabled];
    [self makeBackgroundStretchableImageWithLeftCapWidth:leftCapWidth topCapHeight:topCapHeight forState:UIControlStateHighlighted];
    
}

- (void)makeBackgroundStretchableImageWithLeftCapWidth:(NSInteger)leftCapWidth topCapHeight:(NSInteger)topCapHeight forState:(UIControlState)controlState{
    UIImage *backgroundImage = [self backgroundImageForState:controlState];
    if(backgroundImage) {
        [self setBackgroundImage:[backgroundImage stretchableImageWithLeftCapWidth:leftCapWidth topCapHeight:topCapHeight] forState:controlState];
    }
}


@end

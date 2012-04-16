//
//  WZGradientView.m
//  WZFoundation
//
//  Created by Menno on 14-04-12.
//  Copyright (c) 2012 Wyzers. All rights reserved.
//

#import "WZGradientView.h"
#import <QuartzCore/QuartzCore.h>
@implementation WZGradientView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(NSArray *)colors {
    return [((CAGradientLayer*)[self layer]) colors];
}

- (void)setColors:(NSArray *)colors {
    [((CAGradientLayer*)[self layer]) setColors:colors];
}

- (NSArray *)locations {
    return [((CAGradientLayer*)[self layer]) locations];
}

- (void)setLocations:(NSArray *)locations {
    [((CAGradientLayer*)[self layer]) setLocations:locations];
}

- (CGPoint)startPoint {
    return [((CAGradientLayer*)[self layer]) startPoint];
}

- (void)setStartPoint:(CGPoint)startPoint {
    [((CAGradientLayer*)[self layer]) setStartPoint:startPoint];
}

- (CGPoint)endPoint {
    return [((CAGradientLayer*)[self layer]) endPoint];
}

- (void)setEndPoint:(CGPoint)endPoint {
    [((CAGradientLayer*)[self layer]) setEndPoint:endPoint];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

+ (Class)layerClass {
    return [CAGradientLayer class];
}
@end

//
//  WZInnerShadowLabel.m
//  WZFoundation
//
//  Created by Menno on 19-05-12.
//  Copyright (c) 2012 Wyzers. All rights reserved.
//

#import "WZInnerShadowLabel.h"

@implementation WZInnerShadowLabel
@synthesize innerShadowOffset;
@synthesize innerShadowColor;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setFont:[UIFont fontWithName:@"HTTrattoria" size:17.0f]];
    [self setInnerShadowColor:[UIColor blackColor]];
    [self setInnerShadowOffset:CGSizeMake(0, 1)];
}
- (CGImageRef)newMaskWithSize:(CGSize)size shape:(void (^)(void))block
{
	if (UIGraphicsBeginImageContextWithOptions != NULL)
	{
		UIGraphicsBeginImageContextWithOptions(size, NO, 0);  
	}
	else
	{
		UIGraphicsBeginImageContext(size);
	}
	
	block();
	
	CGImageRef shape = [UIGraphicsGetImageFromCurrentImageContext() CGImage];
	UIGraphicsEndImageContext();  
    CGImageRef mask = CGImageMaskCreate(CGImageGetWidth(shape),
										CGImageGetHeight(shape),
										CGImageGetBitsPerComponent(shape),
										CGImageGetBitsPerPixel(shape),
										CGImageGetBytesPerRow(shape),
										CGImageGetDataProvider(shape), NULL, false);
	return mask;
}

- (UIImage*)blackSquareOfSize:(CGSize)size
{
	/* Way to be compatible with iOS < 4.0. */
	if (UIGraphicsBeginImageContextWithOptions != NULL)
	{
		UIGraphicsBeginImageContextWithOptions(size, NO, 0);
	}
	else
	{
		UIGraphicsBeginImageContext(size);
	}
	
	[[UIColor blackColor] setFill];
	CGContextFillRect(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, size.width, size.height));
	UIImage *blackSquare = UIGraphicsGetImageFromCurrentImageContext();
	
	UIGraphicsEndImageContext();
	
	return blackSquare;
}

- (void)drawRect:(CGRect)rect
{
	CGSize fontSize = [self.text sizeWithFont:self.font];
	
	CGFloat width = CGRectGetWidth(self.bounds);
	CGFloat height = CGRectGetHeight(self.bounds);
	
	CGFloat textX;
	
	switch (self.textAlignment)
	{
		case UITextAlignmentLeft:
			textX = 0;
			break;
		case UITextAlignmentCenter:
			textX = (width - fontSize.width) / 2.;
			break;
		case UITextAlignmentRight:
			textX = width - fontSize.width;
			break;
	}
	
	CGFloat textY = (height - fontSize.height) / 2.;
	
	CGImageRef mask = [self newMaskWithSize:rect.size shape:^{
		[[UIColor blackColor] setFill];
		CGContextFillRect(UIGraphicsGetCurrentContext(), rect);
		[[UIColor whiteColor] setFill];
		
		/* Custom shape goes here. */
		
		[self.text drawAtPoint:CGPointMake(textX, textY) withFont:self.font];
		[self.text drawAtPoint:CGPointMake(textX, textY - 1) withFont:self.font];
	}];
	
	CGImageRef cutoutRef = CGImageCreateWithMask([self blackSquareOfSize:rect.size].CGImage, mask);
	CGImageRelease(mask);
	
	UIImage *cutout;
	
	if ([UIImage respondsToSelector:@selector(imageWithCGImage:scale:orientation:)])
	{
		cutout = [UIImage imageWithCGImage:cutoutRef scale:[[UIScreen mainScreen] scale]
							   orientation:UIImageOrientationUp];
	}
	else
	{
		cutout = [UIImage imageWithCGImage:cutoutRef];
	}
	
	CGImageRelease(cutoutRef);  
	
	CGImageRef shadedMask = [self newMaskWithSize:rect.size shape:^{
		[[UIColor whiteColor] setFill];
		CGContextFillRect(UIGraphicsGetCurrentContext(), rect);
        CGContextSetShadowWithColor(UIGraphicsGetCurrentContext(), [self innerShadowOffset], 1.0f, [[self innerShadowColor] CGColor]);
//		CGContextSetShadowWithColor(UIGraphicsGetCurrentContext(), CGSizeMake(0, 1), 1.0f
//									, [[UIColor colorWithWhite:0.0 alpha:0.5] CGColor]);
		[cutout drawAtPoint:CGPointZero];
	}];
	
	/* Create negative image. */
	if (UIGraphicsBeginImageContextWithOptions != NULL)
	{
		UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
	}
	else
	{
		UIGraphicsBeginImageContext(rect.size);
	}
	
	[[UIColor blackColor] setFill];
	/* Custom shape goes here. */
	[self.text drawAtPoint:CGPointMake(textX, textY - 1) withFont:self.font];
	UIImage *negative = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext(); 
	
	CGImageRef innerShadowRef = CGImageCreateWithMask(negative.CGImage, shadedMask);
	CGImageRelease(shadedMask);
	
	UIImage *innerShadow;
	
	if ([UIImage respondsToSelector:@selector(imageWithCGImage:scale:orientation:)])
	{
		innerShadow = [UIImage imageWithCGImage:innerShadowRef scale:[[UIScreen mainScreen] scale]
                                    orientation:UIImageOrientationUp];
	}
	else
	{
		innerShadow = [UIImage imageWithCGImage:innerShadowRef];
	}
	
	CGImageRelease(innerShadowRef);
	
	/* Draw actual image. */
//    if([self shadowColor]){
//        [self.shadowColor setFill];
//        
//        CGFloat xOffset = self.shadowOffset.width;
//        CGFloat yOffset = self.shadowOffset.height - 1;
//        
//        [self.text drawAtPoint:CGPointMake(textX + xOffset, textY + yOffset) withFont:self.font];
//	}
	if (self.highlighted)
	{
		[self.highlightedTextColor setFill];
	}
	else
	{
		[self.textColor setFill];
	}
	    
    CGContextSetShadowWithColor(UIGraphicsGetCurrentContext(), [self shadowOffset], 0.0f, [[self shadowColor] CGColor]);
	[self.text drawAtPoint:CGPointMake(textX, textY - 1) withFont:self.font];  
	
	/* Finally apply shadow. */
	[innerShadow drawAtPoint:CGPointZero];
}

- (void)drawTextInRect:(CGRect)rect {
        
    [super drawTextInRect:rect];
}

@end

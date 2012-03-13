//
//  WZLabelCell.m
//  WZFoundation
//
//  Created by Menno on 13-03-12.
//  Copyright (c) 2012 Wyzers. All rights reserved.
//

#import "WZLabelCell.h"

@implementation WZLabelCell

@synthesize label;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        label = [[UILabel alloc] init];
        [label setBackgroundColor:[UIColor clearColor]];
        [label setTextColor:[UIColor grayColor]];
        
        [label setTextAlignment:UITextAlignmentRight];
        [label setFont:[UIFont boldSystemFontOfSize:12.0f]];        
        [label setAdjustsFontSizeToFitWidth:YES];
        [label setNumberOfLines:0];
        
        [[self contentView] addSubview:label];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGRect labelFrame = CGRectInset([[self contentView] bounds], 8.0f, 8.0f);
    labelFrame.size = CGSizeMake(72, 27);
    [label setFrame:labelFrame];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    UIColor *color = selected ? [UIColor whiteColor] : [UIColor grayColor];
    [label setTextColor:color];
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    [super setHighlighted:highlighted animated:animated];
    
    UIColor *color = highlighted ? [UIColor whiteColor] : [UIColor grayColor];
    [label setTextColor:color];
}

@end

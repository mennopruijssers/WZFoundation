//
//  WZButtonCell.m
//  WZFoundation
//
//  Created by Menno on 13-03-12.
//  Copyright (c) 2012 Wyzers. All rights reserved.
//

#import "WZButtonCell.h"

@implementation WZButtonCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];

    if (self) {
        [[self textLabel] setTextAlignment:UITextAlignmentCenter];
        [[self textLabel] setFont:[UIFont boldSystemFontOfSize:14.0]];
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGRect frame = CGRectInset(self.contentView.bounds , 20.0f, 8.0f);    
    [[self textLabel] setFrame:frame];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    UIColor *color = selected ? [UIColor whiteColor] : [UIColor colorWithRed:0.29f green:0.43f blue:0.65f alpha:1.0f];
    [[self textLabel] setTextColor:color];
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    [super setHighlighted:highlighted animated:animated];
    
    UIColor *color = highlighted ? [UIColor whiteColor] : [UIColor colorWithRed:0.29f green:0.43f blue:0.65f alpha:1.0f];
    [[self textLabel] setTextColor:color];
}

@end

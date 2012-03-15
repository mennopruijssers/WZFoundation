//
//  WZLabelValueCell.m
//  WZFoundation
//
//  Created by Menno on 13-03-12.
//  Copyright (c) 2012 Wyzers. All rights reserved.
//

#import "WZLabelValueCell.h"

@implementation WZLabelValueCell
@synthesize valueLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if(self) {
        valueLabel = [[WZResponderLabel alloc] init];
        
        [valueLabel setBackgroundColor:[UIColor clearColor]];
        [valueLabel setFont:[UIFont boldSystemFontOfSize:16.0f]];
        
        [[self contentView] addSubview:valueLabel];
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGRect frame = CGRectInset([[self contentView] bounds], 8, 8);
    CGFloat labelAndMargin = [[self label] frame].size.width + 6;
    frame.origin.x += labelAndMargin;
    frame.size.width -= labelAndMargin;
    
    [valueLabel setFrame:frame];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    UIColor* color = selected ? [UIColor whiteColor] : [UIColor blackColor];
    [valueLabel setTextColor:color];
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    [super setHighlighted:highlighted animated:animated];
    
    UIColor* color = highlighted ? [UIColor whiteColor] : [UIColor blackColor];
    [valueLabel setTextColor:color];
}


@end

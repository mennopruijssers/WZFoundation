//
//  WZLabelFieldCell.m
//  WZFoundation
//
//  Created by Menno on 13-03-12.
//  Copyright (c) 2012 Wyzers. All rights reserved.
//

#import "WZLabelFieldCell.h"

@implementation WZLabelFieldCell
@synthesize textField;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if(self) {
        textField = [[UITextField alloc] init];

        [textField setBackgroundColor:[UIColor clearColor]];
        [textField setFont:[UIFont boldSystemFontOfSize:16.0f]];
        [textField setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];

        [[self contentView] addSubview:textField];
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGRect frame = CGRectInset([[self contentView] bounds], 8, 8);
    CGFloat labelAndMargin = [[self label] frame].origin.x + 6;
    frame.origin.x += labelAndMargin;
    frame.size.width -= labelAndMargin;
    
    [textField setFrame:frame];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    UIColor* color = selected ? [UIColor whiteColor] : [UIColor blackColor];
    [textField setTextColor:color];
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    [super setHighlighted:highlighted animated:animated];
    
    UIColor* color = highlighted ? [UIColor whiteColor] : [UIColor blackColor];
    [textField setTextColor:color];
}

@end

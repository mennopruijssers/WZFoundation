//
//  WZGradientView.h
//  WZFoundation
//
//  Created by Menno on 14-04-12.
//  Copyright (c) 2012 Wyzers. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WZGradientView : UIView
@property(copy) NSArray *colors;
@property(copy) NSArray *locations;
@property CGPoint startPoint, endPoint;
@end

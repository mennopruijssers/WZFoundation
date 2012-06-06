//
//  WZHelpers.h
//  WZFoundation
//
//  Created by Menno on 07-03-12.
//  Copyright (c) 2012 Wyzers. All rights reserved.
//

#ifndef WZFoundation_WZHelpers_h
#define WZFoundation_WZHelpers_h

#import "LoadableCategory.h"
#import "NSArray+WZHelpers.h"
#import "UIView+Wyzers.h"
#import "NSString+Wyzers.h"
#import "UIDevice+Wyzers.h"
#import "WZKeyChain.h"
#import "NSDictionary+Wyzers.h"
#import "NSDate+WZJSON.h"
#import "UIImage+Resize.h"
#import "JRSwizzle.h"
#import "NSThread+Wyzers.h"
#endif

static inline UIViewAnimationOptions animationOptionsWithCurve(UIViewAnimationCurve curve)
{
    switch (curve) {
        case UIViewAnimationCurveEaseInOut:
            return UIViewAnimationOptionCurveEaseInOut;
        case UIViewAnimationCurveEaseIn:
            return UIViewAnimationOptionCurveEaseIn;
        case UIViewAnimationCurveEaseOut:
            return UIViewAnimationOptionCurveEaseOut;
        case UIViewAnimationCurveLinear:
            return UIViewAnimationOptionCurveLinear;
    }
}

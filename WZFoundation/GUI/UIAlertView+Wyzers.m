//
//  UIAlertView+Wyzers.m
//  WZFoundation
//
//  Created by Menno on 27-03-12.
//  Copyright (c) 2012 Wyzers. All rights reserved.
//

#import "UIAlertView+Wyzers.h"
#import <objc/runtime.h>

//static DismissBlock _dismissBlock;
//static VoidBlock _cancelBlock;

@implementation UIAlertView (Wyzers)

+ (UIAlertView*) showAlertViewWithTitle:(NSString*) title                    
                            message:(NSString*) message 
                  cancelButtonTitle:(NSString*) cancelButtonTitle
                  otherButtonTitles:(NSArray*) otherButtons
                          onDismiss:(DismissBlock) dismissed                   
                           onCancel:(VoidBlock) cancelled {

//    _cancelBlock  = [cancelled copy];
//    
//    _dismissBlock  = [dismissed copy];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:[self class]
                                          cancelButtonTitle:cancelButtonTitle
                                          otherButtonTitles:nil];
    
    objc_setAssociatedObject(alert, @"UIAlertView (Wyzers).dismissed", dismissed, OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(alert, @"UIAlertView (Wyzers).cancelled", cancelled, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    for(NSString *buttonTitle in otherButtons)
        [alert addButtonWithTitle:buttonTitle];
    
    [alert show];
    return alert;
}

+ (UIAlertView*) showAlertViewWithTitle:(NSString*) title 
                            message:(NSString*) message {
    return [UIAlertView showAlertViewWithTitle:title 
                                   message:message 
                         cancelButtonTitle:NSLocalizedString(@"Dismiss", @"")];
}

+ (UIAlertView*) showAlertViewWithTitle:(NSString*) title 
                            message:(NSString*) message
                  cancelButtonTitle:(NSString*) cancelButtonTitle {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:nil
                                          cancelButtonTitle:cancelButtonTitle
                                          otherButtonTitles: nil];
    [alert show];
    return alert;
}


+ (void)alertView:(UIAlertView*) alertView didDismissWithButtonIndex:(NSInteger) buttonIndex {
    DismissBlock dismissBlock = objc_getAssociatedObject(alertView, @"UIAlertView (Wyzers).dismissed");
    VoidBlock cancelBlock = objc_getAssociatedObject(alertView, @"UIAlertView (Wyzers).cancelled");
    
	if(buttonIndex == [alertView cancelButtonIndex])
	{
		cancelBlock();
	}
    else
    {
        dismissBlock(buttonIndex - 1); // cancel button is button 0
    }
    
    objc_setAssociatedObject(alertView, @"UIAlertView (Wyzers).dismissed", nil, OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(alertView, @"UIAlertView (Wyzers).cancelled", nil, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
@end

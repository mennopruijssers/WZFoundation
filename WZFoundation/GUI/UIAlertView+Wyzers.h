//
//  UIAlertView+Wyzers.h
//  WZFoundation
//
//  Created by Menno on 27-03-12.
//  Copyright (c) 2012 Wyzers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WZBlocks.h"

@interface UIAlertView (Wyzers)
+ (UIAlertView*) showAlertViewWithTitle:(NSString*) title 
                            message:(NSString*) message;

+ (UIAlertView*) showAlertViewWithTitle:(NSString*) title 
                            message:(NSString*) message
                  cancelButtonTitle:(NSString*) cancelButtonTitle;

+ (UIAlertView*) showAlertViewWithTitle:(NSString*) title                    
                            message:(NSString*) message 
                  cancelButtonTitle:(NSString*) cancelButtonTitle
                  otherButtonTitles:(NSArray*) otherButtons
                          onDismiss:(DismissBlock) dismissed                   
                           onCancel:(VoidBlock) cancelled;
@end

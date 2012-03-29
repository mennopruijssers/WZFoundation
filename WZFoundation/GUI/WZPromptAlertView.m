//
//  WZPromptAlertView.m
//  WZFoundation
//
//  Created by Menno on 26-03-12.
//  Copyright (c) 2012 Wyzers. All rights reserved.
//

#import "WZPromptAlertView.h"
#import <objc/runtime.h>
#import <QuartzCore/QuartzCore.h>
@implementation WZPromptAlertView

@synthesize textField;
@synthesize dismissBlock;
@synthesize cancelBlock;

- (id)initWithTitle:(NSString *)title
           delegate:(id)delegate 
  cancelButtonTitle:(NSString *)cancelButtonTitle
 confirmButtonTitle:(NSString*) confirmButtonTitle
        placeHolder:(NSString*) placeHolder
              value:(NSString*) value {
    self = [super initWithTitle:title message:@" " delegate:delegate cancelButtonTitle:cancelButtonTitle otherButtonTitles: nil];
    
    if(self) {
        [self addButtonWithTitle:confirmButtonTitle];
        
        UITextField *theTextField = [[UITextField alloc] initWithFrame:CGRectMake(12.0, 45.0, 260.0, 25.0)];
        [theTextField setBackgroundColor:[UIColor whiteColor]]; 
        [[theTextField layer] setShadowColor:[[UIColor blackColor] CGColor]];
        [[theTextField layer] setShadowOffset:CGSizeMake(0, 1)];
        [[theTextField layer] setShadowOpacity:0.75f];
        if(placeHolder) {
            [theTextField setPlaceholder:placeHolder];
        }
        if(value) {
            [theTextField setText:value];
        }
        
        [self addSubview:theTextField];
        textField = theTextField;
    }
    
    return self;
}

- (void)show {
    [textField becomeFirstResponder];
    [super show];
}

+ (void)alertView:(WZPromptAlertView*) alertView didDismissWithButtonIndex:(NSInteger) buttonIndex {
    
	if(buttonIndex == [alertView cancelButtonIndex])
	{
        if([alertView cancelBlock]) {
            [alertView cancelBlock];
        }
	}
    else
    {
        if([alertView dismissBlock]) {
            [alertView dismissBlock]([[alertView textField] text]); 
        }
    }
}

+ (WZPromptAlertView*) showPromptViewWithTitle:(NSString*) title                    
                             cancelButtonTitle:(NSString*) cancelButtonTitle
                            confirmButtonTitle:(NSString*) confirmButtonTitle
                                   placeHolder:(NSString*) placeHolder
                                         value:(NSString*) value
                                     onDismiss:(PromptDismissBlock) dismissed                   
                                      onCancel:(VoidBlock) cancelled {
    WZPromptAlertView *alert = [[WZPromptAlertView alloc] initWithTitle:title
                                                               delegate:[self class] 
                                                      cancelButtonTitle:cancelButtonTitle  
                                                     confirmButtonTitle:confirmButtonTitle 
                                                            placeHolder:placeHolder 
                                                                  value:value];
    
    [alert setCancelBlock:cancelled];
    [alert setDismissBlock:dismissed];
    
    [alert show];
    return alert;
}

@end
//
//  WZPromptAlertView.h
//  WZFoundation
//
//  Created by Menno on 26-03-12.
//  Copyright (c) 2012 Wyzers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WZBlocks.h"

typedef void (^PromptDismissBlock)(NSString *value);

@interface WZPromptAlertView : UIAlertView

@property (nonatomic, retain, readonly) UITextField *textField;
@property (nonatomic, copy) VoidBlock cancelBlock;
@property (nonatomic, copy) PromptDismissBlock dismissBlock;

- (id)initWithTitle:(NSString *)title
           delegate:(id)delegate 
  cancelButtonTitle:(NSString *)cancelButtonTitle
 confirmButtonTitle:(NSString*) confirmButtonTitle
        placeHolder:(NSString*) placeHolder
              value:(NSString*) value;

+ (WZPromptAlertView*) showPromptViewWithTitle:(NSString*) title                    
                             cancelButtonTitle:(NSString*) cancelButtonTitle
                             confirmButtonTitle:(NSString*) confirmButtonTitle
                                   placeHolder:(NSString*) placeHolder
                                         value:(NSString*) value
                                     onDismiss:(PromptDismissBlock) dismissed                   
                                      onCancel:(VoidBlock) cancelled;
@end


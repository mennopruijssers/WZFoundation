//
//  UIActionSheet+Wyzers.h
//  WZFoundation
//
//  Created by Menno on 24-03-12.
//  Copyright (c) 2012 Wyzers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WZBlocks.h"

typedef void (^PhotoPickedBlock)(UIImage *chosenImage);


@interface UIActionSheet (Wyzers)<UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

+(void) showActionSheetWithTitle:(NSString*) title
                         message:(NSString*) message
                      andButtons:(NSArray*) buttonTitles
                          inView:(UIView*) view
                       onDismiss:(DismissBlock) dismissed                   
                        onCancel:(VoidBlock) cancelled;


+ (void) showActionSheetWithTitle:(NSString*) title                     
                          message:(NSString*) message          
           destructiveButtonTitle:(NSString*) destructiveButtonTitle
                       andButtons:(NSArray*) buttonTitles
                           inView:(UIView*) view
                        onDismiss:(DismissBlock) dismissed                   
                         onCancel:(VoidBlock) cancelled;


+ (void) showPhotoPickerWithTitle:(NSString*) title
                       inView:(UIView*) view
                        presentVC:(UIViewController*) presentView
                    onPhotoPicked:(PhotoPickedBlock) photoPicked                   
                         onCancel:(VoidBlock) cancelled;

@end

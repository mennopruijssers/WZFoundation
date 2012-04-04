//
//  UIActionSheet+Wyzers.m
//  WZFoundation
//
//  Created by Menno on 24-03-12.
//  Copyright (c) 2012 Wyzers. All rights reserved.
//

#import "UIActionSheet+Wyzers.h"
#import <objc/runtime.h>

//static DismissBlock _dismissBlock;
//static VoidBlock _cancelBlock;
//static PhotoPickedBlock _photoPickedBlock;
//static UIViewController *_presentVC;

#define kPhotoActionSheetTag 8790 //CharacterCodes for WZ


#define keyDismissed @"UIActionSheet (Wyzers).dismissed"
#define keyCancelled @"UIActionSheet (Wyzers).cancelled"
#define keyPhotoPicked @"UIActionSheet (Wyzers).photoPicked"
#define keyPresentVC @"UIActionSheet (Wyzers).presentVC"

@implementation UIActionSheet (Wyzers)

+ (void) showActionSheetWithTitle:(NSString*) title
                         message:(NSString*) message
                         andButtons:(NSArray*) buttonTitles
                          inView:(UIView*) view
                       onDismiss:(DismissBlock) dismissed                   
                        onCancel:(VoidBlock) cancelled
{    
    [UIActionSheet showActionSheetWithTitle:title 
                                message:message 
                 destructiveButtonTitle:nil 
                                andButtons:buttonTitles 
                             inView:view 
                              onDismiss:dismissed 
                               onCancel:cancelled];
}

+ (void) showActionSheetWithTitle:(NSString*) title                     
                      message:(NSString*) message          
       destructiveButtonTitle:(NSString*) destructiveButtonTitle
                      andButtons:(NSArray*) buttonTitles
                   inView:(UIView*) view
                    onDismiss:(DismissBlock) dismissed                   
                     onCancel:(VoidBlock) cancelled
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:title 
                                                             delegate:(id<UIActionSheetDelegate>)[self class] 
                                                    cancelButtonTitle:nil
                                               destructiveButtonTitle:destructiveButtonTitle 
                                                    otherButtonTitles:nil];
    objc_setAssociatedObject(actionSheet, keyDismissed, dismissed, OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(actionSheet, keyCancelled, cancelled, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    
    for(NSString* thisButtonTitle in buttonTitles) {
        [actionSheet addButtonWithTitle:thisButtonTitle];
    }
    
    [actionSheet addButtonWithTitle:NSLocalizedString(@"Cancel", @"")];
    actionSheet.cancelButtonIndex = [buttonTitles count];
    
    if(destructiveButtonTitle) {
        actionSheet.cancelButtonIndex ++;
    }
    
    if([view isKindOfClass:[UITabBar class]]) {
        [actionSheet showFromTabBar:(UITabBar*) view];
    } else if([view isKindOfClass:[UIBarButtonItem class]]) {
        [actionSheet showFromBarButtonItem:(UIBarButtonItem*) view animated:YES];
    } else if([view isKindOfClass:[UIToolbar class]]) {
        [actionSheet showFromToolbar:(UIToolbar *)view];
    } else {
        [actionSheet showInView:view];
    }    
}

+ (void) showPhotoPickerWithTitle:(NSString*) title
                   inView:(UIView*) view
                    presentVC:(UIViewController*) presentVC
                onPhotoPicked:(PhotoPickedBlock) photoPicked                   
                     onCancel:(VoidBlock) cancelled
{        
    int cancelButtonIndex = -1;
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:title 
                                                             delegate:(id<UIActionSheetDelegate>)[self class] 
													cancelButtonTitle:nil
											   destructiveButtonTitle:nil
													otherButtonTitles:nil];
    
    objc_setAssociatedObject(actionSheet, keyCancelled, cancelled, OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(actionSheet, keyPhotoPicked, photoPicked, OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(actionSheet, keyPresentVC, presentVC, OBJC_ASSOCIATION_RETAIN_NONATOMIC);


    
    
	if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
	{
		[actionSheet addButtonWithTitle:NSLocalizedString(@"Camera", @"")];
		cancelButtonIndex ++;
	}
	if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
	{
		[actionSheet addButtonWithTitle:NSLocalizedString(@"Photo library", @"")];
		cancelButtonIndex ++;
	}
    
	[actionSheet addButtonWithTitle:NSLocalizedString(@"Cancel", @"")];
	cancelButtonIndex ++;
    
    actionSheet.tag = kPhotoActionSheetTag;
	actionSheet.cancelButtonIndex = cancelButtonIndex;		 
    
    if([view isKindOfClass:[UITabBar class]]) {
        [actionSheet showFromTabBar:(UITabBar*) view];
    } else if([view isKindOfClass:[UIBarButtonItem class]]) {
        [actionSheet showFromBarButtonItem:(UIBarButtonItem*) view animated:YES];
    } else if([view isKindOfClass:[UIToolbar class]]) {
        [actionSheet showFromToolbar:(UIToolbar *)view];
    } else {
        [actionSheet showInView:view];
    }  
}


+ (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
	UIImage *editedImage = (UIImage*) [info valueForKey:UIImagePickerControllerEditedImage];
    if(editedImage) {
        PhotoPickedBlock photoPickedBlock = objc_getAssociatedObject(picker, keyPhotoPicked);
        photoPickedBlock(editedImage);
    }
    [picker dismissModalViewControllerAnimated:YES];	
    
    objc_setAssociatedObject(picker, keyPresentVC, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(picker, keyPhotoPicked, nil, OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(picker, keyCancelled, nil, OBJC_ASSOCIATION_COPY_NONATOMIC);
}


+ (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    // Dismiss the image selection and close the program
    UIViewController *presentVC = objc_getAssociatedObject(picker,keyPresentVC);    
    [presentVC dismissModalViewControllerAnimated:YES];    
    
    VoidBlock cancelBlock = objc_getAssociatedObject(picker, keyCancelled);
    cancelBlock();
    
    objc_setAssociatedObject(picker, keyPresentVC, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(picker, keyPhotoPicked, nil, OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(picker, keyCancelled, nil, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
}

+(void)actionSheet:(UIActionSheet*) actionSheet didDismissWithButtonIndex:(NSInteger) buttonIndex
{
	if(buttonIndex == [actionSheet cancelButtonIndex])
	{
        VoidBlock cancelBlock = objc_getAssociatedObject(actionSheet, keyCancelled);
		cancelBlock();
	}
    else
    {
        if(actionSheet.tag == kPhotoActionSheetTag)
        {
            if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
            {
                buttonIndex ++;
            }
            if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
            {
                buttonIndex ++;
            }
            
            
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.delegate = (id<UINavigationControllerDelegate, UIImagePickerControllerDelegate>)[self class];
            picker.allowsEditing = YES;
            
            if(buttonIndex == 1) 
            {                
                picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            }
            else if(buttonIndex == 2)
            {
                picker.sourceType = UIImagePickerControllerSourceTypeCamera;;
            }
            
            
            UIViewController *presentVC = objc_getAssociatedObject(actionSheet, keyPresentVC);

            objc_setAssociatedObject(picker, keyPresentVC, presentVC, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            
            PhotoPickedBlock photoPickedBlock = objc_getAssociatedObject(actionSheet, keyPhotoPicked);
            objc_setAssociatedObject(picker, keyPhotoPicked, photoPickedBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
            
            VoidBlock cancelledBlock = objc_getAssociatedObject(actionSheet, keyCancelled);
            objc_setAssociatedObject(picker, keyCancelled, cancelledBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
            
            
            

            [presentVC presentModalViewController:picker animated:YES];
        }
        else
        {
            DismissBlock dismissBlock = objc_getAssociatedObject(actionSheet, keyDismissed);
            dismissBlock(buttonIndex);
        }        
    }
    
    objc_setAssociatedObject(actionSheet, keyDismissed, nil, OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(actionSheet, keyCancelled, nil, OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(actionSheet, keyPhotoPicked, nil, OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(actionSheet, keyPresentVC, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end

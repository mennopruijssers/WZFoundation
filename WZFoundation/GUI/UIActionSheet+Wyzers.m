//
//  UIActionSheet+Wyzers.m
//  WZFoundation
//
//  Created by Menno on 24-03-12.
//  Copyright (c) 2012 Wyzers. All rights reserved.
//

#import "UIActionSheet+Wyzers.h"

static DismissBlock _dismissBlock;
static VoidBlock _cancelBlock;
static PhotoPickedBlock _photoPickedBlock;
static UIViewController *_presentVC;

#define kPhotoActionSheetTag 8790 //CharacterCodes for WZ

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
    _cancelBlock  = [cancelled copy];
    
    _dismissBlock  = [dismissed copy];
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:title 
                                                             delegate:(id<UIActionSheetDelegate>)[self class] 
                                                    cancelButtonTitle:nil
                                               destructiveButtonTitle:destructiveButtonTitle 
                                                    otherButtonTitles:nil];
    
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
    _cancelBlock  = [cancelled copy];
    
    _photoPickedBlock  = [photoPicked copy];
    _presentVC = presentVC;
        
    int cancelButtonIndex = -1;
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:title 
                                                             delegate:(id<UIActionSheetDelegate>)[self class] 
													cancelButtonTitle:nil
											   destructiveButtonTitle:nil
													otherButtonTitles:nil];
    
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
    if(!editedImage)
        editedImage = (UIImage*) [info valueForKey:UIImagePickerControllerOriginalImage];
    
    _photoPickedBlock(editedImage);
	[picker dismissModalViewControllerAnimated:YES];	
}


+ (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    // Dismiss the image selection and close the program
    [_presentVC dismissModalViewControllerAnimated:YES];    
    _cancelBlock();
}

+(void)actionSheet:(UIActionSheet*) actionSheet didDismissWithButtonIndex:(NSInteger) buttonIndex
{
	if(buttonIndex == [actionSheet cancelButtonIndex])
	{
		_cancelBlock();
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
            
            [_presentVC presentModalViewController:picker animated:YES];
        }
        else
        {
            _dismissBlock(buttonIndex);
        }
    }
}
@end

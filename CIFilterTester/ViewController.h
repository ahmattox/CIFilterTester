//
//  ViewController.h
//  FilterTest
//
//  Created by Anthony Mattox on 6/29/12.
//  Copyright (c) 2012 Friends of The Web. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UIPopoverControllerDelegate> {
    IBOutlet UIImageView *imageView;
    IBOutlet UIView *imageBorder;
    
    IBOutlet UILabel *currentFilterName;
    IBOutlet UIView *paramaterView;
    IBOutlet UIPickerView *filterPicker;
    
    UIImage *sourceImage;
    
    NSArray *filternames;
    
    NSMutableArray *attributeSliders;
    
    UIPopoverController *imagePopover;
}

- (IBAction) filterImage:(id) sender;
- (IBAction) selectImage:(UIButton *) sender;

@end

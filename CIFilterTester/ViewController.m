//
//  ViewController.m
//  FilterTest
//
//  Created by Anthony Mattox on 6/29/12.
//  Copyright (c) 2012 Friends of The Web. All rights reserved.
//

#import "ViewController.h"

#import "FilterAttributeSlider.h"

@implementation ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        attributeSliders = [[NSMutableArray alloc] initWithCapacity:5];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self displayImageNamed:@"baobabs.png"];
    
    filternames = [CIFilter filterNamesInCategory:kCICategoryBuiltIn];
    
    [filterPicker selectRow:5 inComponent:0 animated:YES];
    [self pickerView:filterPicker didSelectRow:5 inComponent:0];
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}





#pragma mark - Filtering Images


- (IBAction) filterImage:(id)sender {
    [self applyFilter];
}

- (void) applyFilter {    
    CIImage *inputImage = [CIImage imageWithCGImage:sourceImage.CGImage];
    CIContext *context = [CIContext contextWithOptions:nil];
    
    CIFilter *filter = [CIFilter filterWithName:[filternames objectAtIndex:[filterPicker selectedRowInComponent:0]]];
    [filter setValue:inputImage forKey:kCIInputImageKey];
    NSLog(@"number of sliders = %i", attributeSliders.count);
    for (FilterAttributeSlider *slider in attributeSliders) {
        NSLog(@"apply attribute %@", slider.attributeKey);
        [filter setValue:slider.value forKey:slider.attributeKey];
    }
    
    CIImage *outputImage = [filter outputImage];
    
    CGImageRef cgimg = 
    [context createCGImage:outputImage fromRect:[outputImage extent]];
    UIImage *newImg = [UIImage imageWithCGImage:cgimg];
    
    [imageView setImage:newImg];
    
    CGImageRelease(cgimg);
}







#pragma mark - Picker View

#pragma mark Data Source

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return filternames.count;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [filternames objectAtIndex:row];
}


#pragma mark Delegate

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    NSLog(@"picker selected row");
    
    NSDictionary *filterAttributes = [[CIFilter filterWithName:[filternames objectAtIndex:row]] attributes];
    NSLog(@"filter attributes = %@", filterAttributes);
    
    currentFilterName.text = [filterAttributes objectForKey:@"CIAttributeFilterDisplayName"];
    
    for (UIView *view in paramaterView.subviews) {
        [view removeFromSuperview];
        [attributeSliders removeAllObjects];
    }
    
    float parameterHeight = 0;
    for (NSString *attributeKey in filterAttributes) {
        if ([[attributeKey substringToIndex:5] isEqualToString:@"input"]) {
            NSDictionary *attribute = [filterAttributes objectForKey:attributeKey];
            if ([[attribute objectForKey:@"CIAttributeClass"] isEqualToString:@"NSNumber"]) {
                FilterAttributeSlider *slider = [[FilterAttributeSlider alloc] initWithFrame:CGRectMake(0, parameterHeight, paramaterView.bounds.size.width, 65)
                                                                                andAttribute:attribute
                                                                                       named:attributeKey];
                [paramaterView addSubview:slider];
                [attributeSliders addObject:slider];
                parameterHeight += slider.bounds.size.height;
            }
            if ([[attribute objectForKey:@"CIAttributeClass"] isEqualToString:@"CIColor"]) {
                
            }
        }
    }
}





#pragma mark - Image Loading

- (void) displayImageNamed:(NSString *) imageName {
    [self displayImage:[UIImage imageNamed:imageName]];
}

- (void) displayImage:(UIImage *) image {
    sourceImage = image;
    imageView.image = sourceImage;
    
    CGRect imageFrame = [self centeredFrameForImage:sourceImage inView:imageView];
    imageBorder.frame = CGRectMake(imageFrame.origin.x-5+imageView.frame.origin.x,
                                   imageFrame.origin.y-5+imageView.frame.origin.y,
                                   imageFrame.size.width+10,
                                   imageFrame.size.height+10);
}



- (CGRect) centeredFrameForImage:(UIImage *) image inView:(UIView *) view {
    CGRect maxImageFrame = imageView.frame;
    CGSize imageSize = ((UIImage *)image).size;
    CGFloat imageScale = fminf(maxImageFrame.size.width/imageSize.width, maxImageFrame.size.height/imageSize.height);
    if (imageScale>1) {
        return CGRectMake(view.frame.size.width/2-imageSize.width/2, view.frame.size.height/2-imageSize.height/2, imageSize.width, imageSize.height);
    }
    CGSize scaledImageSize = CGSizeMake(imageSize.width*imageScale, imageSize.height*imageScale);
    return CGRectMake(floorf(0.5f*(view.frame.size.width-scaledImageSize.width)), floorf(0.5f*(view.frame.size.height-scaledImageSize.height)), scaledImageSize.width, scaledImageSize.height);
}




#pragma mark - Picking Images

- (IBAction) selectImage:(UIButton *) sender {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] initWithRootViewController:nil];
        imagePicker.delegate = self;
        [imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        if ([[UIDevice currentDevice] userInterfaceIdiom]==UIUserInterfaceIdiomPad) {
            imagePopover = [[UIPopoverController alloc] initWithContentViewController:imagePicker];
            imagePopover.delegate = self;
            [imagePopover presentPopoverFromRect:sender.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        }
    }
}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController {
    if (popoverController==imagePopover) {
        imagePopover = nil;
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo {
    [self displayImage:image];
    [imagePopover dismissPopoverAnimated:YES];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
}




@end

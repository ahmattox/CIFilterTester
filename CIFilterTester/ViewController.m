//
//  ViewController.m
//  FilterTest
//
//  Created by Anthony Mattox on 6/29/12.
//  Copyright (c) 2012 Friends of The Web. All rights reserved.
//

#import "ViewController.h"

#import "FilterAttributeSlider.h"

@interface ViewController ()

@end

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
    imageView.image = [UIImage imageNamed:@"baobabs.png"];
    
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
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"baobabs" ofType:@"png"];
    NSURL *fileNameAndPath = [NSURL fileURLWithPath:filePath];
    
    CIImage *inputImage = [CIImage imageWithContentsOfURL:fileNameAndPath];
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




@end

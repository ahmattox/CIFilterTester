//
//  FilterAttributeColor.h
//  CIFilterTester
//
//  Created by Anthony Mattox on 7/11/12.
//  Copyright (c) 2012 Friends of The Web. All rights reserved.
//

#import "FilterAttributeSelector.h"

@interface FilterAttributeColor : FilterAttributeSelector {
    IBOutlet UISlider *redSlider;
    IBOutlet UISlider *greenSlider;
    IBOutlet UISlider *blueSlider;
    
    IBOutlet UIView *colorPreview;
}

- (IBAction) sliderChanged:(id)sender;

@end

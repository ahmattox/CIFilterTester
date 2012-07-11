//
//  FilterAttributeSlider.h
//  CIFilterTester
//
//  Created by Anthony Mattox on 6/30/12.
//  Copyright (c) 2012 Friends of The Web. All rights reserved.
//

#import "FilterAttributeSelector.h"

@interface FilterAttributeSlider : FilterAttributeSelector {
    IBOutlet UISlider *slider;
    IBOutlet UILabel *valueLabel;
}

- (IBAction) sliderChanged:(id)sender;

@end

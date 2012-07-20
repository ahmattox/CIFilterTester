//
//  FilterAttributeVector.h
//  CIFilterTester
//
//  Created by Anthony Mattox on 7/16/12.
//  Copyright (c) 2012 Friends of The Web. All rights reserved.
//

#import "FilterAttributeSelector.h"

@interface FilterAttributeVector : FilterAttributeSelector {
    IBOutlet UILabel *valueLabel;
    IBOutletCollection(UISlider) NSMutableArray *sliders;
    
    CGSize imageSize;
}

- (IBAction) sliderChanged:(id)sender;

@property (nonatomic) CGSize imageSize;

@end

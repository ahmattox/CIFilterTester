//
//  FilterAttributeSlider.m
//  FilterTest
//
//  Created by Anthony Mattox on 6/30/12.
//  Copyright (c) 2012 Friends of The Web. All rights reserved.
//

#import "FilterAttributeSlider.h"

@implementation FilterAttributeSlider

- (id) initWithFrame:(CGRect) frame andAttribute:(NSDictionary *) anAttribute named:(NSString *) name {
    self = [[[NSBundle mainBundle] loadNibNamed:@"FilterAttributeSlider" owner:self options:nil] objectAtIndex:0];
    if (self) {
        self.frame = frame;
        attributeName = name;
        attribute = anAttribute;
        
        label.text = name;
        slider.minimumValue = [[attribute objectForKey:@"CIAttributeSliderMin"] floatValue];
        slider.maximumValue = [[attribute objectForKey:@"CIAttributeSliderMax"] floatValue];
        [slider setValue:[[attribute objectForKey:@"CIAttributeDefault"] floatValue] animated:NO];
    }
    return self;
}

- (IBAction) sliderChanged:(id)sender {
    valueLabel.text = [NSString stringWithFormat:@"%f", slider.value];
}

- (NSString *) attributeKey {
    return attributeName;
}

- (NSNumber *) value {
    return [NSNumber numberWithFloat:slider.value];
}

@end

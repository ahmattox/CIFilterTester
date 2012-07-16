//
//  FilterAttributeVector.m
//  CIFilterTester
//
//  Created by Anthony Mattox on 7/16/12.
//  Copyright (c) 2012 Friends of The Web. All rights reserved.
//

#import "FilterAttributeVector.h"

@implementation FilterAttributeVector
@synthesize imageSize;

- (id) initWithFrame:(CGRect) frame andAttribute:(NSDictionary *) anAttribute named:(NSString *) name {
    self = [super initWithAttribute:anAttribute named:name];
    if (self) {
        view = [[[NSBundle mainBundle] loadNibNamed:@"FilterAttributeVectorView" owner:self options:nil] objectAtIndex:0];
        
        view.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, view.bounds.size.height);
        
        label.text = displayName;
        imageSize = CGSizeMake(1, 1);
        
        [self updateValueLabel];
    }
    return self;
}

- (IBAction) sliderChanged:(id)sender {
    [self updateValueLabel];
}

- (void) updateValueLabel {
    [valueLabel setText:[NSString stringWithFormat:@"(%.0f, %.0f)", slider1.value*imageSize.width, slider2.value*imageSize.height]];
}

- (NSString *) attributeKey {
    return attributeName;
}

- (CIVector *) value {
    return [CIVector vectorWithX:slider1.value*imageSize.width Y:slider2.value*imageSize.height];
}

- (void) setImageSize:(CGSize) newImageSize {
    imageSize = newImageSize;
    [self updateValueLabel];
}

@end

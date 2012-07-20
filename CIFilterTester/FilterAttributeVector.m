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
        NSLog(@"FilterAttributeVector, %@", anAttribute);
        view = [[[NSBundle mainBundle] loadNibNamed:@"FilterAttributeVectorView" owner:self options:nil] objectAtIndex:0];
        
        if ([[anAttribute objectForKey:@"CIAttributeType"] isEqualToString:@"CIAttributeTypePosition"] ||
            [[anAttribute objectForKey:@"CIAttributeType"] isEqualToString:@"CIAttributeTypeOffset"]) {
            [[sliders objectAtIndex:3] removeFromSuperview];
            [[sliders objectAtIndex:2] removeFromSuperview];
            [sliders removeObjectAtIndex:3];
            [sliders removeObjectAtIndex:2];
            view.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, view.bounds.size.height-60);
        } else if ([[anAttribute objectForKey:@"CIAttributeType"] isEqualToString:@"CIAttributeTypePosition3"]) {
            [[sliders objectAtIndex:3] removeFromSuperview];
            [sliders removeObjectAtIndex:3];
            view.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, view.bounds.size.height-30);
        } else if ([[anAttribute objectForKey:@"CIAttributeType"] isEqualToString:@"CIAttributeTypeRectangle"]) {
            view.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, view.bounds.size.height);
        }
        
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
    if (sliders.count==2) {
        [valueLabel setText:[NSString stringWithFormat:@"(%.0f, %.0f)",
                             ((UISlider *) [sliders objectAtIndex:0]).value*imageSize.width,
                             ((UISlider *) [sliders objectAtIndex:1]).value*imageSize.height]];
    } else
    if (sliders.count==3) {
        [valueLabel setText:[NSString stringWithFormat:@"(%.0f, %.0f, %.0f)",
                             ((UISlider *) [sliders objectAtIndex:0]).value*imageSize.width,
                             ((UISlider *) [sliders objectAtIndex:1]).value*imageSize.height,
                             ((UISlider *) [sliders objectAtIndex:2]).value*imageSize.width]];
    } else
    if (sliders.count==4) {
        [valueLabel setText:[NSString stringWithFormat:@"(%.0f, %.0f, %.0f, %.0f)",
                             ((UISlider *) [sliders objectAtIndex:0]).value*imageSize.width,
                             ((UISlider *) [sliders objectAtIndex:1]).value*imageSize.height,
                             ((UISlider *) [sliders objectAtIndex:2]).value*imageSize.width,
                             ((UISlider *) [sliders objectAtIndex:3]).value*imageSize.height]];
    }
}

- (NSString *) attributeKey {
    return attributeName;
}

- (CIVector *) value {
    if (sliders.count==3) {
        return [CIVector vectorWithX:((UISlider *) [sliders objectAtIndex:0]).value*imageSize.width
                                   Y:((UISlider *) [sliders objectAtIndex:1]).value*imageSize.height
                                   Z:((UISlider *) [sliders objectAtIndex:2]).value*imageSize.width];
    }
    if (sliders.count==4) {
        return [CIVector vectorWithX:((UISlider *) [sliders objectAtIndex:0]).value*imageSize.width
                                   Y:((UISlider *) [sliders objectAtIndex:1]).value*imageSize.height
                                   Z:((UISlider *) [sliders objectAtIndex:2]).value*imageSize.width
                                   W:((UISlider *) [sliders objectAtIndex:3]).value*imageSize.height];
    }
    return [CIVector vectorWithX: ((UISlider *) [sliders objectAtIndex:0]).value*imageSize.width
                               Y:((UISlider *) [sliders objectAtIndex:1]).value*imageSize.height];
}

- (void) setImageSize:(CGSize) newImageSize {
    imageSize = newImageSize;
    [self updateValueLabel];
}

@end

//
//  FilterAttributeColor.m
//  CIFilterTester
//
//  Created by Anthony Mattox on 7/11/12.
//  Copyright (c) 2012 Friends of The Web. All rights reserved.
//

#import "FilterAttributeColor.h"

@implementation FilterAttributeColor

- (id) initWithFrame:(CGRect) frame andAttribute:(NSDictionary *) anAttribute named:(NSString *) name {
    self = [super initWithAttribute:anAttribute named:name];
    if (self) {
        view = [[[NSBundle mainBundle] loadNibNamed:@"FilterAttributeColorView" owner:self options:nil] objectAtIndex:0];
        
        view.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, view.bounds.size.height);
        
        label.text = displayName;
        
        [self updatePreviewColor];
    }
    return self;
}

- (IBAction) sliderChanged:(id)sender {
    [self updatePreviewColor];
}

- (void) updatePreviewColor {
    UIColor *color = [UIColor colorWithRed:redSlider.value green:greenSlider.value blue:blueSlider.value alpha:1];
    colorPreview.backgroundColor = color;
}

- (NSString *) attributeKey {
    return attributeName;
}

- (CIColor *) value {
//    UIColor *color = [UIColor colorWithRed:redSlider.value green:greenSlider.value blue:blueSlider.value alpha:1];
//    return color.CIColor;
    
    return [CIColor colorWithRed:redSlider.value green:greenSlider.value blue:blueSlider.value alpha:1];
}

@end

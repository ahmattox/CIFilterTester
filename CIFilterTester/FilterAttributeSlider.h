//
//  FilterAttributeSlider.h
//  FilterTest
//
//  Created by Anthony Mattox on 6/30/12.
//  Copyright (c) 2012 Friends of The Web. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FilterAttributeSlider : UIView {
    NSString *attributeName;
    NSDictionary *attribute;
    
    IBOutlet UISlider *slider;
    IBOutlet UILabel *label;
    IBOutlet UILabel *valueLabel;
}

- (id) initWithFrame:(CGRect) frame andAttribute:(NSDictionary *) anAttribute named:(NSString *) name;

- (IBAction) sliderChanged:(id)sender;
- (NSString *) attributeKey;
- (NSNumber *) value;

@end

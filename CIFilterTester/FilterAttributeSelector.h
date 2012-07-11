//
//  FilterAttributeSelector.h
//  FilterTest
//
//  Created by Anthony Mattox on 6/30/12.
//  Copyright (c) 2012 Friends of The Web. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FilterAttributeSelector : NSObject {
    UIView *view;
    
    NSString *attributeName;
    NSString *displayName;
    NSDictionary *attribute;
    
    IBOutlet UILabel *label;
}

- (id) initWithAttribute:(NSDictionary *) anAttribute named:(NSString *) name;
- (id) initWithFrame:(CGRect) frame andAttribute:(NSDictionary *) anAttribute named:(NSString *) name;

- (NSString *) attributeKey;
- (id) value;

@property (nonatomic, strong) UIView *view;

@end

//
//  FilterAttributeSelector.m
//  FilterTest
//
//  Created by Anthony Mattox on 6/30/12.
//  Copyright (c) 2012 Friends of The Web. All rights reserved.
//

#import "FilterAttributeSelector.h"

@implementation FilterAttributeSelector
@synthesize view;

- (id) initWithFrame:(CGRect) frame andAttribute:(NSDictionary *) anAttribute named:(NSString *) name {
    return [self initWithAttribute:anAttribute named:name];
}

- (id) initWithAttribute:(NSDictionary *) anAttribute named:(NSString *) name {
    self = [super init];
    if (self) {
        attributeName = name;
        displayName = [name stringByReplacingOccurrencesOfString:@"input" withString:@""];
        attribute = anAttribute;
    }
    return self;
}

- (NSString *) attributeKey {
    return attributeName;
}

- (id) value {
    return nil;
}

@end

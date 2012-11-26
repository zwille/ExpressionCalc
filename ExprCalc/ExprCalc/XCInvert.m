//
//  XCInvert.m
//  ExprCalc
//
//  Created by Christoph Cwelich on 25.11.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCInvert.h"

@implementation XCInvert 
-(id)initWithValue:(id)value {
    self = [super init];
    _value = value;
    return self;
}
+(id)invertValue:(id)value {
    return [[XCInvert alloc] initWithValue:value];
}

-(XCNumber *)value {
    return [[_value value] invert];
}
@end

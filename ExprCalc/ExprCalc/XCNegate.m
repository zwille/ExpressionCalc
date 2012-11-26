//
//  XCNegate.m
//  ExprCalc
//
//  Created by Christoph Cwelich on 25.11.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCNegate.h"

@implementation XCNegate
+(id)negateValue:(id<XCHasValue>)value {
    return [[XCNegate alloc] initWithValue:value];
}
-(id)initWithValue:(id<XCHasValue>)value {
    self = [super init];
    _value = value;
    return self;
}

-(XCNumber *)value {
    return [[_value value] negate:];
}

@end

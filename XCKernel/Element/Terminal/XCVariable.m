//
//  XCVariable.m
//  TestHTML
//
//  Created by Christoph Cwelich on 07.12.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCVariable.h"
NSArray * variables;
@implementation XCVariable
-(void)setNumericValue:(NSNumber*)value {
    _value = value;
}
+(id)variableForIndex:(NSUInteger)idx {
    return [variables objectAtIndex:idx];
}
-(id)initWithIndex:(NSUInteger)index andValue:(NSNumber *)value {
    self = [super initWithValue:value];
    _idx = index;
    return self;
}
+(void)initialize {
    variables = @[
    [[XCVariable alloc] initWithIndex:0 andValue:@0],
    [[XCVariable alloc] initWithIndex:1 andValue:@0],
    [[XCVariable alloc] initWithIndex:2 andValue:@0],
    [[XCVariable alloc] initWithIndex:3 andValue:@0],
    [[XCVariable alloc] initWithIndex:4 andValue:@0],
    [[XCVariable alloc] initWithIndex:5 andValue:@0],
    [[XCVariable alloc] initWithIndex:6 andValue:@0],
    [[XCVariable alloc] initWithIndex:7 andValue:@0],
    [[XCVariable alloc] initWithIndex:8 andValue:@0],
    [[XCVariable alloc] initWithIndex:9 andValue:@0],
    [[XCVariable alloc] initWithIndex:10 andValue:@0], //ans
    ];
    
}
-(NSString *)toHTML {
    return (_idx<XC_ANS_IDX) ? [NSString stringWithFormat:@"<msub><mi>X</mi><mn>%d</mn></msub>",_idx] : @"<csymbol>ANS</csymbol>";
}
-(NSString *)description {
    return (_idx<10) ? [NSString stringWithFormat:@"X_%d",_idx] : @"ANS";
}
@end

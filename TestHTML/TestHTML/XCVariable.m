//
//  XCVariable.m
//  TestHTML
//
//  Created by Christoph Cwelich on 07.12.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCVariable.h"

@implementation XCVariable
-(void)setValue:(NSNumber*)value {
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
    ];
}
-(NSString *)toHTML {
    return (_idx) ? [NSString stringWithFormat:@"X<sub>%d</sub>",_idx] : @"ANS";
}
-(NSString *)description {
    return (_idx) ? [NSString stringWithFormat:@"X_%d",_idx] : @"ANS";
}
@end
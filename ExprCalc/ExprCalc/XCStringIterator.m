//
//  XCCharIterator.m
//  ExpressionCalc
//
//  Created by Christoph Cwelich on 20.11.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCStringIterator.h"

@implementation XCStringIterator
-(id)initWithString:(NSString *)str{
    self = [super init];
    idx = 0;
    data = str;
    return self;
}
-(unichar)currentChar {
    return (idx>0) ? [data characterAtIndex:idx-1] : 0;
}
-(unichar)nextChar {
    return ([self hasNextChar]) ? [data characterAtIndex:idx++] : 0;
}
-(NSUInteger)index{
    return idx;
}
-(bool)hasNextChar{
    return idx < [data length];
}
-(void)back{
    if (idx>0) {
        --idx;
    }
}

@end

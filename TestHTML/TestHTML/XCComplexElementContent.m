//
//  XCComplexElementContent.m
//  TestHTML
//
//  Created by Christoph Cwelich on 04.12.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCComplexElementContent.h"

@implementation XCComplexElementContent
@synthesize index = _idx;
-(id)init {
    self = [super init];
    _operands = [NSMutableArray arrayWithCapacity:2];
    _idx =0;
    return self;
}
-(NSUInteger) length {
    return [_operands count];
}
-(bool)isEmpty {
    NSUInteger len = [self length];
    assert(len == 0 && _idx == -1 || len > 0);
    return [self length]==0;
}
-(bool)hasNext {
    return _idx < [self length];
}
-(bool) hasPrevious {
    return _idx > 0;
}
-(NSUInteger)nextIndex {
    assert([self hasNext]);
    return ++_idx;
}
-(NSUInteger)previousIndex {
    assert([self hasPrevious]);
    return --_idx;
}
-(XCElement *)currentElement {
    assert(_idx < [self length] );
    assert(! [self isEmpty]);
    return [_operands objectAtIndex: _idx];
}
-(void)insertElement:(XCElement *)element {
    assert(_idx < [self length]);
    //append or insert after current
    [_operands insertObject:element atIndex:_idx+1];
}
-(void)replaceCurrentWith:(XCElement *)element {
    assert(! [self isEmpty] && _idx < [self length]);
}
-(void)removeCurrent {
    assert(! [self isEmpty] && _idx < [self length]);
    [_operands removeObjectAtIndex: _idx];
    --_idx;
}

-(BOOL)isSingleElement {
    return [self length]==1;
}
-(NSString *)description {
    if ([self isEmpty]) {
        return @"[]";
    }
    NSMutableString * rc = [NSMutableString stringWithString:@"["];
    for (id e in _operands) {
        [rc appendFormat:@"%@, ", e];
    }
    NSRange last2 = {[rc length] -2,2};
    [rc deleteCharactersInRange:last2];
    [rc appendString:@"]"];
    return rc;
}


@end

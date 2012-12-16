//
//  XCComplexElementContent.m
//  TestHTML
//
//  Created by Christoph Cwelich on 04.12.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCComplexElementContent.h"
BOOL indexOkay(NSUInteger i, NSUInteger len);
@implementation XCComplexElementContent
@synthesize index = _idx;
-(id)init {
    self = [super init];
    _operands = [NSMutableArray arrayWithCapacity:2];
    _idx = -1;
    return self;
}
-(id)copyWithZone:(NSZone *)zone andRoot:(XCElement *)root {
    return [[XCComplexElementContent allocWithZone:zone] initCopyWithIndex:_idx andOperands:_operands andRoot:root andZone:zone];
}
-(id)initCopyWithIndex: (NSUInteger) index
           andOperands: (NSMutableArray*) op
               andRoot: (XCElement*) root
               andZone: (NSZone*) zone {
    self = [super init];
    _operands = [NSMutableArray arrayWithCapacity:[op count]];
    //deep copy
    for (XCElement * el in op) {
        XCElement * cp = [el copyWithZone:zone];
        [cp setRoot:root];
        [_operands addObject: cp];
    }
    _idx = index;
    return self;
}
-(NSUInteger) length {
    return [_operands count];
}
-(bool)isEmpty {
    assert(indexOkay(_idx, [self length]));
    return [self length]==0;
}
-(bool)hasNext {
    return [self length] - _idx > 1;
}
-(bool) hasPrevious {
    return _idx > 0 && _idx != (NSUInteger) -1;
}
-(XCElement *)currentElement {
    assert(! [self isEmpty]);
    return [_operands objectAtIndex: _idx];
}
-(XCElement *)elementAtIndex:(NSUInteger)index {
    return [_operands objectAtIndex:index];
}
-(NSUInteger)nextIndex {
    assert([self hasNext]);
    return ++_idx;
}
-(NSUInteger)previousIndex {
    assert([self hasPrevious]);
    return --_idx;
}

-(void)insertElement:(XCElement *)element {
    assert(indexOkay(_idx, [self length]));
    //append or insert after current
    [_operands insertObject:element atIndex:_idx+1];
}
-(void)replaceCurrentWith:(XCElement *)element {
    assert(! [self isEmpty]);
    [_operands replaceObjectAtIndex:_idx withObject:element];
}
-(void)removeCurrent {
    assert(! [self isEmpty]);
    [_operands removeObjectAtIndex: _idx];
    if (_idx==[self length]) {
        --_idx;
    }
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

// fast enumeration
-(NSUInteger)countByEnumeratingWithState:
    (NSFastEnumerationState *)state
                                 objects:(__unsafe_unretained id [])buffer
                                   count:(NSUInteger)len {
    return [_operands countByEnumeratingWithState:state objects:buffer count:len];
}

@end
BOOL indexOkay(NSUInteger i, NSUInteger len) {
    return i<len || i==(NSUInteger)-1;
}


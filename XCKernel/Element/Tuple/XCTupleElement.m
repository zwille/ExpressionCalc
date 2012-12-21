//
//  XCTupleElement.m
//  XCCalc
//
//  Created by Christoph Cwelich on 19.12.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCTupleElement.h"
#import "XCSimpleElement.h"

@implementation XCTupleElement

-(id)initWithParent:(XCElement *)parent
  andFirstElement: (XCElement*) e0
 andSecondElement: (XCElement*) e1 {
    self = [self initWithParent:parent];
    assert([self isEmpty]);
    [self setElement:e0 at:0];
    [self setElement:e1 at:1];
    [self setIndex:1];
    return self;
}
-(BOOL)index {
    return _state.sub1;
}
-(void) setIndex: (BOOL) value {
    _state.sub1 = value;
}
-(void) setElement: (XCElement*) el at: (BOOL) idx {
    _content[idx] = el;
    [el setParent:self];
}
-(BOOL)isEmpty {
    return _content[0]==nil && _content[1]==nil;
}
-(XCElement *)content {
    return _content[[self index]];
}
-(void) swapElements {
    XCElement * t = [self element1];
    [self setElement:[self element0] at:1];
    [self setElement:t at:0];
}
-(void)normalizeToElementSelf {
    // normalize to order (element, element) or (element, self)
    if ([_content[0] isKindOfClass:[self class]]) {
        if ([_content[1] isKindOfClass:[self class]]) { // both self
            XCTupleElement * e1, *e2, * e3;
            e3 = (XCTupleElement *) [self element1];
            e1 = (XCTupleElement *) [self element0];
            e2 = [[[self class] alloc] initWithParent: self andFirstElement: [e1 element1]
                             andSecondElement: e3];
        } else {
            [self swapElements];
        }
    }
}
-(void) normalizeRShiftClass: (Class) cls {
    BOOL isClass[2];
    for (NSUInteger i=0; i<2; i++) {
        isClass[i] = [_content[i] isKindOfClass:cls];
    }
    
    if (isClass[0]) {
        if (isClass[1]) { // -a-b
            XCSimpleElement * neg = (XCSimpleElement *) [self element0];
            XCElement * cc[2], * p =  [self parent];
            cc[0] = [neg content],
            cc[1] = [[self element1] content],
            [p replaceContentWithElement:neg];
            [neg setContent:self];
            for (NSUInteger i=0; i<2; i++) {
                _content[i] = cc[i];
            }
        } else if ([_content[1] isKindOfClass:[self class]]) {
            //shift invert right
            id sub = [self element1];
            assert( ![[sub element0] isKindOfClass: cls]);
            XCElement * t = [sub element0];
            [sub setElement:[self element0] at:0];
            [self setElement:t at:0];
            [[self element1] normalize];
        } else { // -a+b
            [self swapElements];
        }
    }
}
        
-(id)copyWithZone:(NSZone *)zone {
    XCTupleElement * rc = [super copyWithZone:zone];
    [rc setElement:[_content[0] copyWithZone:zone] at:0];
    [rc setElement:[_content[1] copyWithZone:zone] at:1];
    
    return rc;
}
-(XCElement*)replaceContentWithElement:(XCElement *)element {
    [self setElement:element at:[self index]];
    return element;
}
-(void)normalize {
    [[self element0] normalize];
    [[self element1] normalize];
}
//trigger

-(id<XCHasTriggers>)triggerNextContent {
    BOOL idx = ![self index];
    if (idx) {
        [self setIndex:idx];
        return _content[idx];
    } else {
        return [super triggerNext];
    }
    
}
-(XCElement*) elementAt:(BOOL)idx {
    return _content[idx];
}
-(XCElement *)element0 {
    return _content[0];
}
-(XCElement *)element1 {
    return _content[1];
}

-(id<XCHasTriggers>)triggerPreviousContent {
    BOOL idx = [self index];
    if (idx) {
        [self setIndex:!idx];
        return _content[!idx];
    } else {
        return [super triggerPrevious];
    }
}
-(id<XCHasTriggers>)triggerDel {
    assert([self parent]);
    return [[self parent] replaceContentWithElement:_content[![self index]]];
}
@end

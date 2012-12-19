//
//  XCTupleElement.m
//  XCCalc
//
//  Created by Christoph Cwelich on 19.12.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCTupleElement.h"

@implementation XCTupleElement

-(id)initWithRoot:(XCElement *)root
  andFirstElement: (XCElement*) e0
 andSecondElement: (XCElement*) e1 {
    self = [self initWithRoot:root];
    assert([self isEmpty]);
    [self setElement:e0 atEnd:NO];
    [self setElement:e1 atEnd:YES];
    [self setIndex:1];
    return self;
}
-(BOOL)index {
    return _state.sub1;
}
-(void) setIndex: (BOOL) value {
    _state.sub1 = value;
}
-(void) setElement: (XCElement*) el atEnd: (BOOL) idx {
    _content[idx] = el;
    [el setRoot:self];
}
-(BOOL)isEmpty {
    return _content[0]==nil && _content[1]==nil;
}
-(XCElement *)content {
    return _content[[self index]];
}
-(id)copyWithZone:(NSZone *)zone {
    XCTupleElement * rc = [super copyWithZone:zone];
    rc->_content[0] = [_content[0] copyWithZone:zone];
    rc->_content[1] = [_content[1] copyWithZone:zone];
    return rc;
}
-(XCElement*)replaceContentWithElement:(XCElement *)element {
    [self setElement:element at:[self index]];
    return element;
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
    assert([self root]);
    return [[self root] replaceContentWithElement:_content[![self index]]];
}
@end

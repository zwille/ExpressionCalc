//
//  XCComplexElement.m
//  TestHTML
//
//  Created by Christoph Cwelich on 29.11.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCComplexElement.h"

@implementation XCComplexElement

-(id)initWithRoot:(XCElement *)root{
    self = [super initWithRoot:root];
    _content =[[XCComplexElementContent alloc] init];
    return self;
}

-(XCElement*)replaceContentWithElement:(XCElement *)element {
    [element setRoot:self];
    [_content replaceCurrentWith: element];
    return element;
}

-(NSString *)description{
    return [NSString stringWithFormat:@"%@%@",[super description],_content];
}

//trigger

-(id<XCHasTriggers>)triggerNext {
    if ([_content hasNext]) {
        [_content nextIndex];
        return [_content currentElement];
    } else if([self root]){
        return [[self root] triggerNext];
    } else {
        return [_content currentElement];
    }
}

-(id<XCHasTriggers>)triggerPrevious {
    if ([_content hasPrevious]) {
        [_content previousIndex];
        return [_content currentElement];
    } else if([self root]){
        return [[self root] triggerPrevious];
    } else {
        return [_content currentElement];
    }
}

-(id<XCHasTriggers>)triggerDel {
    NSUInteger len = [_content length];
    if (len<2) {
        return [[self root] triggerDel];
    } else {
        [_content removeCurrent];
        return [_content currentElement];
    }
}
-(XCElement *)content {
    return [_content currentElement];
}
-(XCElement *)head {
    return [[_content currentElement] head];
}
-(id)copyWithZone:(NSZone *)zone {
    XCComplexElement * rc = [super copyWithZone:zone];
    XCComplexElementContent * contcp = rc->_content;
    for (XCElement * e in _content) {
        XCElement * ecp = [e copy];
        [contcp insertElement: ecp];
        [ecp setRoot:rc];
    }
    return rc;
}
@end

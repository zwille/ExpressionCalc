//
//  XCComplexElement.m
//  TestHTML
//
//  Created by Christoph Cwelich on 29.11.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCComplexElement.h"
#import "XCStatement.h"

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
-(BOOL)isEmpty {
    return [_content isEmpty];
}

-(XCElement *)content {
    return [_content currentElement];
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

//trigger

-(id<XCHasTriggers>)triggerNextContent {
    assert([self root]);
    if ([_content hasNext]) {
        [_content nextIndex];
        return [_content currentElement];
    }
    XCElement * root = [self root];
    if([root isKindOfClass:[XCStatement class]]){
        return [_content currentElement];
    } else {
        return [super triggerNext];
    }
}

-(id<XCHasTriggers>)triggerPreviousContent {
    assert([self root]);
    if ([_content hasPrevious]) {
        [_content previousIndex];
        return [_content currentElement];
    }
    XCElement * root = [self root];
    if([root isKindOfClass:[XCStatement class]]){
        return [_content currentElement];
    } else {
        return [super triggerPrevious];
    }
}

-(id<XCHasTriggers>)triggerDel {
    NSUInteger len = [_content length];
    if (len<2) {
        return [super triggerDel];
    } else {
        [_content removeCurrent];
        return [_content currentElement];
    }
}
@end

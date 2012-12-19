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
-(id)initWithRoot:(XCElement *)root
  andFirstElement: (XCElement*) e0 {
    self = [self initWithRoot:root];
    [self insertElement:e0];
    return self;
}
-(id)initWithRoot:(XCElement *)root
  andFirstElement: (XCElement*) e0
 andSecondElement: (XCElement*) e1 {
    self = [self initWithRoot:root];
    [self insertElement:e0];
    [self insertElement:e1];
    
    return self;
}

-(XCElement*)replaceContentWithElement:(XCElement *)element {
    if ([element isKindOfClass:[self class]]  && ![element isEmpty]) {
        XCComplexElementContent * co = ((XCComplexElement*)element)->_content;
        XCElement * el = [co elementAtIndex:0];
        [el setRoot:self];
        NSLog(@"XCCE::replace el=%@",el);
        [_content replaceCurrentWith: el];
        for (NSUInteger i = 1; i<[co length]; i++) {
            el = [co elementAtIndex:i];
            NSLog(@"XCCE::replace el=%@",el);
            [el setRoot:self];
            [self insertElement:el];
        }
        return self;
    } else {
        [element setRoot:self];
        [_content replaceCurrentWith: element];
        return element;
    }
    
}
-(void) insertElement:(XCElement*) element {
    [_content insertElement:element];
    [element setRoot:self];
    [_content nextIndex];
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
    XCComplexElementContent * contcp = [_content copyWithZone:zone andRoot:rc];
    rc -> _content = contcp;
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

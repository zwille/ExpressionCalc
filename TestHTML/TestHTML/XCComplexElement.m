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
    return [NSString stringWithFormat:@"%@%@",[self class],_content];
}
-(NSString *)toHTMLfromChild {
    NSUInteger len = [_content length];
    NSMutableString * buf =
        [NSMutableString stringWithString:@""];
    for (NSUInteger i = 0; i<len; i++) {
        NSString * html =
         [self htmlFromElement:
          [_content elementAtIndex:i]
                       atIndex: i
              andContentLength: len];
        [buf appendString: html];
    }
    return buf;
}
-(NSString *)htmlFromElement:(XCElement *)el
                     atIndex:(NSUInteger)i
            andContentLength:(NSUInteger)len {
    assert(false);
    return nil;
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

@end

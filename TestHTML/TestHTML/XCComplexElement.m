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
-(id<XCHasTriggers>)triggerEnter {
    return [_content currentElement];
}
-(id<XCHasTriggers>)triggerNext {
    if ([_content hasNext]) {
        [_content nextIndex];
        return self;
    } else {
        return [super triggerNext];
    }
}

-(id<XCHasTriggers>)triggerPrevious {
    if ([_content hasPrevious]) {
        [_content previousIndex];
        return self;
    } else {
        return [super triggerPrevious];
    }
}

-(XCElement *)triggerDel {
    NSUInteger len = [_content length];
    if (len<2) {
        return [[self root] triggerDel];
    } else {
        [_content removeCurrent];
        return self;
    }
}
-(void)replaceWithElement:(XCElement *)element {
    [element setRoot:self];
    [_content replaceCurrentWith: element];
}

-(NSString *)description{
    return [NSString stringWithFormat:@"%@%@",[self class],_content];
}
-(NSString *)toHTML {
    NSUInteger len = [_content length];
    NSMutableString * buf = [NSMutableString stringWithString:@""];
    for (NSUInteger i = 0; i<len; i++) {
        NSString * html =
         [self htmlFromElement:
          [_content elementAtIndex:i]
                       atIndex: i
              andContentLength: len];
        [buf appendString: ([self hasFocus] && i==[_content index]) ?
         [NSString stringWithFormat:XC_HTML_FOCUS_FORMAT,html]: html];
    }
    return buf;
}
-(NSString *)htmlFromElement:(XCElement *)el atIndex:(NSUInteger)i andContentLength:(NSUInteger)len {
    assert(false);
    return nil;
}

@end

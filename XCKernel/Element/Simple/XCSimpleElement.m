//
//  XCSimpleElement.m
//  TestHTML
//
//  Created by Christoph Cwelich on 04.12.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCSimpleElement.h"


@implementation XCSimpleElement

-(id)initWithContent:(XCElement *)content
             andParent:(XCElement *)parent {
    self = [super initWithParent:parent];
    [self setContent:content];
    return self;
}
-(void)setContent:(XCElement *)content {
    [content setParent:self];
    _content = content;
}
-(XCElement*)replaceContentWithElement:(XCElement *)element {
    [self setContent:element];
    return _content;
}
-(XCElement *)content {
    return _content;
}
-(XCElement *)head {
    return [_content head];
}
-(NSString *)description {
    return [NSString stringWithFormat:@"%@[%@]",[super description],_content];
}
-(void)normalize {
    [_content normalize];
}
//trigger
/*
-(id<XCHasTriggers>)triggerDel {
    assert([self root]);
    NSLog(@"Simple::triggerDel root=%@",[self root]);
    return [[self root] triggerDel];
}*/

-(id<XCHasTriggers>)triggerNextContent {
    return [_parent triggerNextContent];
}

-(id<XCHasTriggers>)triggerPreviousContent {
    return [_parent triggerPreviousContent];
}
//evaluate
-(NSNumber *)eval {
    NSNumber * rc = [[self content] eval];
    [self setError:[rc isNaN]];
    return rc;
}
// copying
-(id)copyWithZone:(NSZone *)zone {
    XCSimpleElement * rc = [super copyWithZone:zone];
    rc -> _content = [_content copyWithZone:zone];
    [rc -> _content setParent:rc];
    return rc;
    
}
-(BOOL)isEmpty {
    return !_content;
}
@end

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
             andRoot:(XCElement *)root {
    self = [super initWithRoot:root];
    [self setContent:content];
    return self;
}
-(void)setContent:(XCElement *)content {
    [content setRoot:self];
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
//trigger
-(id<XCHasTriggers>)triggerDel {
    assert([self root]);
    return [[self root] triggerDel];
}
                  
//evaluate
-(NSNumber *)eval {
    NSNumber * rc = [[self content] eval];
    [self setError:[rc isNaN]];
    return rc;
}
// copying
-(id)copyWithZone:(NSZone *)zone {
    XCSimpleElement * rc =
    [[[self class] allocWithZone:zone]
     initWithContent: [_content copy]
                andRoot: nil];
    return rc;
    
}
-(BOOL)isEmpty {
    return !_content;
}
@end

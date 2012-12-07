//
//  XCElement.m
//  TestHTML
//
//  Created by Christoph Cwelich on 29.11.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCElement.h"
#import "XCNumString.h"


@implementation XCElement
@synthesize root=_root;

-(XCElement *)content{
    return self;
}
-(XCElement *)head {
    return [self content];
}
-(id)initWithRoot:(XCElement *)root {
    self = [super init];
    _root = root;
    return self;
}
-(void)setFocus:(BOOL)val {
    _state.focus = val;
}
-(BOOL)hasFocus {
    return _state.focus;
}
-(void)setError:(BOOL)val {
    _state.error = val;
}
-(BOOL)hasError {
    return _state.error;
}


-(NSString *)description {
    NSString * format = @"%@:%@";
    if ([self hasError]) {
        format = [NSString stringWithFormat: @"!!!%@!!!",format ];
    }
    NSString * text = [[self class] description];
    return [NSString stringWithFormat:format,
            ([self hasFocus]) ? [text uppercaseString] : text,
            [[self root] class]
            ];
}


-(NSString*) toHTML {
    NSString * format = ([self hasFocus]) ? XC_HTML_FOCUS_FORMAT : @"%@";
    if([self hasError]) {
        format = [NSString stringWithFormat:format, XC_HTML_ERROR_FORMAT];
    }
  
    //NSLog(@"XCExpression::toHTML self=%@ hasFocus? %d  hasError? %d format=%@", self,[self hasFocus],[self hasError],format);
    return [NSString stringWithFormat:format,[self toHTMLfromChild]];
}
-(NSString *)toHTMLfromChild {
    assert(false);
    return nil;
}
-(XCElement*)replaceContentWithElement:(XCElement *)element {
    assert(false);
}
-(BOOL)isEmpty {
    assert(false);
    return YES;
}

//evaluate

-(NSNumber *)eval {
    [self setError:YES];
    return [NSNumber numberWithDouble:NAN];
}

//trigger
-(id<XCHasTriggers>)triggerDel {
    return [[self root] triggerDel];
}

-(id<XCHasTriggers>)triggerEnter {
    return [self head];
}

-(id<XCHasTriggers>)triggerNum:(char)c {
    //TODO check
    return [[self content] triggerNum:c];
}
-(id<XCHasTriggers>)triggerExpression {
    return self; //pass
}
-(id<XCHasTriggers>)triggerFunction:(NSString*) fn {
    return self; //pass
}
-(id<XCHasTriggers>)triggerConstant:(XCConstants)cid {
    return self; //pass
}
-(id<XCHasTriggers>)triggerVariable:(NSUInteger)idx {
    return self; //pass
}
-(id<XCHasTriggers>)triggerAssign: (NSUInteger) varIdx {
    return [[self root] triggerAssign: varIdx];
}
-(id<XCHasTriggers>)triggerNext {
    return (_root) ? [_root triggerNext] : self;
}
-(id<XCHasTriggers>)triggerPrevious {
    return (_root) ? [_root triggerPrevious] : self;
}
-(id<XCHasTriggers>)triggerOperator:(XCOperator)op{
    return [_root triggerOperator:op];
}


@end

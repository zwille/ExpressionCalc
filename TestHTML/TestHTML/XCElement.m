//
//  XCElement.m
//  TestHTML
//
//  Created by Christoph Cwelich on 29.11.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCElement.h"
#import "XCNum.h"

NSString * XC_HTML_FOCUS_FORMAT = @"<b>%@</b>",
    * XC_HTML_ERROR_FORMAT = @"<font color=\"red\">%@</font>";
@implementation XCElement
@synthesize root=_root;


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
-(id<XCHasTriggers>)triggerEnter {
    assert(false);
    return nil;
}

-(id<XCHasTriggers>)triggerNum:(char)c {
    assert(false);
    return nil;
}
-(id<XCHasTriggers>)triggerExpression {
    assert(false);
    return nil;
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

-(NSString *)description {
    return [NSString stringWithFormat:@"%@",[self class]];
}

-(XCElement *)triggerDel {
    assert(false);
    return nil;
}
-(NSString*) toHTML {
    NSString * format = ([self hasFocus]) ? XC_HTML_FOCUS_FORMAT : @"%@";
    if([self hasError]) {
        format = [NSString stringWithFormat:format, XC_HTML_ERROR_FORMAT];
    }
    format = ([self hasError]) ? @"<b>%@</b>" : @"%@";
    return [NSString stringWithFormat:format,[self toHTMLfromChild]];
}
-(NSString *)toHTMLfromChild {
    assert(false);
    return nil;
}
-(void)replaceCurrentWithElement:(XCElement *)element {
    assert(false);
}

@end

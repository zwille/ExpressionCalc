//
//  XCElement.m
//  TestHTML
//
//  Created by Christoph Cwelich on 29.11.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCElement.h"
#import "XCNumString.h"
#import "XCSpacer.h"
#import "XCNegate.h"
#import "XCInvert.h"
#import "XCExpression.h"
#import "XCExponentiation.h"
#import "XCProduct.h"
#import "XCStatement.h"
#import "XCSum.h"


@implementation XCElement
@synthesize parent=_parent;

-(XCElement *)content{
    return self;
}
-(XCElement *)head {
    return [self content];
}
-(void)normalize {
    // pass;
}
-(id)initWithParent:(XCElement *)parent {
    self = [super init];
    _parent = parent;
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
    NSString * format = @"%@";
    if ([self hasError]) {
        format = [NSString stringWithFormat: @"!!!%@!!!",format ];
    }
    NSString * text = [[self class] description];
    return [NSString stringWithFormat:format,
            ([self hasFocus]) ? [text uppercaseString] : text
            ];
}


-(NSString*) toHTML {
    assert(NO);
    return nil;
}
-(NSString *)toHTMLFenced {
    return [self wrapHTML:[NSString stringWithFormat:@"<mfenced separators=\" \">%@</mfenced>",[self toHTML]]];
}
-(NSString*) wrapHTML: (NSString*) inner {
    //NSLog(@"XCElement::wrapHTML self=%@ hasError=%d inner=%@",self,[self hasError],inner);
    if ([self hasError]) {
        inner = [NSString stringWithFormat:
                 @"<mspan class=\"error\">%@</mspan>",inner];
    }
    //NSLog(@"XCElement::wrapHTML inner=%@",inner);
    if ([self hasFocus]) {
        inner = [NSString stringWithFormat:
                 @"<mspan class=\"hasfocus\">%@</mspan>",inner];
    }
    //NSLog(@"XCElement::wrapHTML inner=%@",inner);
    return inner;
    
}

-(XCElement*)replaceContentWithElement:(XCElement *)element {
    assert(false);
}
-(BOOL)isEmpty {
    return YES;
}

//evaluate

-(NSNumber *)eval {
    [self setError:YES];
    return [NSNumber numberWithDouble:NAN];
}

//trigger
/*
-(id<XCHasTriggers>)triggerDel {
    //return [[self root] triggerDel];
    assert([self root]);
    //XCElement * rc = [XCSpacer spacerWithRoot:nil];
    //[[self root] replaceContentWithElement:rc];
    //return rc;
    return [[self root] triggerDel];
}*/
-(id<XCHasTriggers>)triggerDel {
    assert([self parent]);
    XCElement * rc = [XCSpacer spacerWithParent:nil];
    [[self parent] replaceContentWithElement:rc];
    return rc;
    
}
-(id<XCHasTriggers>)triggerEnter {
    return [self head];
}

-(id<XCHasTriggers>)triggerNum:(char)c {
    return self; //pass
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
    return [[self parent] triggerAssign: varIdx];
}
-(id<XCHasTriggers>)triggerNext {
    assert(_parent);
    return [_parent triggerNextContent];
}
-(id<XCHasTriggers>)triggerNextContent {
    return self; //pass
}
-(id<XCHasTriggers>)triggerPrevious {
    assert(_parent);
    return [_parent triggerPreviousContent];
}
-(id<XCHasTriggers>)triggerPreviousContent {
    return self; //pass
}
/*
-(id<XCHasTriggers>)triggerOperator:(XCOperator)op{
    return [_root triggerOperator:op];
}
 */

-(id<XCHasTriggers>)triggerOperator:(XCOperator)op {
    XCElement * spacer = [XCSpacer spacerWithParent:self];
    XCElement * newEl = spacer;
    XCElement * parent = [self parent];
    assert(parent);
    BOOL hasContainer = [parent isKindOfClass:[XCExpression class]]
    || [parent isKindOfClass:[XCStatement class]];
    
    switch (op) {
        case XC_OP_MINUS:
            newEl = [XCNegate negateValue:spacer withParent:self];
        case XC_OP_PLUS:
            if (hasContainer) {
                [parent replaceContentWithElement:
                 [XCSum sumWithElement0:self
                            andElement1: newEl
                                andParent:parent]];
                break;
            } 
            return [parent triggerOperator: op];
        case XC_OP_DIV:
            newEl = [XCInvert invertValue:spacer withParent:self];
        case XC_OP_MULT:
            if (hasContainer
                || [parent isKindOfClass:[XCSum class]]
                || [parent isKindOfClass:[XCProduct class]]) {
                [parent replaceContentWithElement:
                 [XCProduct productWithElement0:self
                        andElement1:newEl
                                  andParent:parent]];
                break;
            }
            return [parent triggerOperator: op];
        default:
            assert(op==XC_OP_EXP);
            if (hasContainer
                || [parent isKindOfClass:[XCSum class]]
                || [parent isKindOfClass:[XCProduct class]]
                || [parent isKindOfClass:[XCExponentiation class]]) {
                    [[self parent] replaceContentWithElement:
                [XCExponentiation exponentiationWithBase: self
                                          andExponent:newEl
                                              andParent:parent]];
                break;
            }
            return [parent triggerOperator: op];

    }
    return spacer;
}

// copying
-(id)copyWithZone:(NSZone *)zone {
    XCElement * rc = [[[self class] allocWithZone:zone] initWithParent:nil];
    rc -> _state = _state;
    rc -> _state.error = NO;
    return rc;
}
-(NSNumber *)checkErrorOn:(NSNumber *)num {
    [self setError:[num isNaN]];
    return num;
}
@end

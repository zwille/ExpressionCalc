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
@synthesize root=_root;

-(XCElement *)content{
    return self;
}
-(XCElement *)head {
    return [self content];
}
-(void)normalize {
    // pass;
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
    assert([self root]);
    XCElement * rc = [XCSpacer spacerWithRoot:nil];
    [[self root] replaceContentWithElement:rc];
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
    return [[self root] triggerAssign: varIdx];
}
-(id<XCHasTriggers>)triggerNext {
    assert(_root);
    return [_root triggerNextContent];
}
-(id<XCHasTriggers>)triggerNextContent {
    return self; //pass
}
-(id<XCHasTriggers>)triggerPrevious {
    assert(_root);
    return [_root triggerPreviousContent];
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
    XCElement * spacer = [XCSpacer spacerWithRoot:self];
    XCElement * newEl = spacer;
    XCElement * root = [self root];
    BOOL hasContainer = [root isKindOfClass:[XCExpression class]]
    || [root isKindOfClass:[XCStatement class]];
    assert(root);
    switch (op) {
        case XC_OP_MINUS:
            newEl = [XCNegate negateValue:spacer withRoot:self];
        case XC_OP_PLUS:
            if (hasContainer || [root isKindOfClass:[XCSum class]]) {
                [root replaceContentWithElement:
                 [XCSum sumWithElement0:self
                            andElement1: newEl
                                andRoot:root]];
                break;
            } 
            return [root triggerOperator: op];
        case XC_OP_DIV:
            newEl = [XCInvert invertValue:spacer withRoot:self];
        case XC_OP_MULT:
            if (hasContainer || [root isKindOfClass:[XCProduct class]]) {
                [root replaceContentWithElement:
                 [XCProduct productWithElement0:self
                        andElement1:newEl
                                  andRoot:root]];
                break;
            }
            return [root triggerOperator: op];
        default:
            assert(op==XC_OP_EXP);
            if (hasContainer || [root isKindOfClass:[XCExponentiation class]]) {
                    [[self root] replaceContentWithElement:
                [XCExponentiation exponentiationWithBase: self
                                          andExponent:newEl
                                              andRoot:root]];
                break;
            }
            return [root triggerOperator: op];

    }
    return spacer;
}

// copying
-(id)copyWithZone:(NSZone *)zone {
    XCElement * rc = [[[self class] allocWithZone:zone] initWithRoot:nil];
    rc -> _state = _state;
    rc -> _state.error = NO;
    return rc;
}
-(NSNumber *)checkErrorOn:(NSNumber *)num {
    [self setError:[num isNaN]];
    return num;
}
@end

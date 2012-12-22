//
//  XCSpacer.m
//  XCCalc
//
//  Created by Christoph Cwelich on 04.12.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCSpacer.h"
#import "XCNumString.h"
#import "XCNegate.h"
#import "XCInvert.h"
#import "XCExpression.h"
#import "XCIdentifier.h"
#import "XCFunction.h"
//#import "XCConstant.h"
//#import "XCVariable.h"

@implementation XCSpacer
+(id)spacerWithParent: (XCElement*) parent {
    return [[XCSpacer alloc] initWithParent:parent];
}


-(BOOL)isEmpty { return YES; }
-(BOOL)isEqual:(id)object {
    return [object isKindOfClass:[XCSpacer class]];
}
-(XCElement*) swapWithElement: (XCElement*) el andParent: (XCElement*) parent {
    assert(parent);
    [parent replaceContentWithElement:el];
    return el;
}
-(NSString *)description {
    return @"_";
}

//HTML
-(NSString *)toHTML {
    //return @"&#9643";
    return [super wrapHTML:@"<mo>_</mo>"];
}

//trigger
-(id<XCHasTriggers>)triggerDel {
    assert([self parent]);
    return [[self parent]triggerDel];
}
-(id<XCHasTriggers>)triggerNum:(char) c {
    return [self swapWithElement:
            [XCNumString numWithFirstChar: c]
                         andParent:[self parent]];
}
-(id<XCHasTriggers>)triggerExpression {
    XCElement * parent = [self parent];
    [self swapWithElement:
            [XCExpression expressionWithElement: self
                                  andParent: nil]
                  andParent:parent];
    return self;
}
-(id<XCHasTriggers>)triggerFunction: (NSString*) fn {
    XCElement * parent = [self parent];
    [self swapWithElement:
            [XCFunction functionWithName:fn
                             withElement:self
                                 andParent: nil]
                  andParent:parent];
    return self;
}
-(id<XCHasTriggers>)triggerConstant:(XCConstants)cid {
    return [self swapWithElement: [XCIdentifier identifierWithConstantId:cid andParent:nil]
                         andParent:[self parent]];
}
-(id<XCHasTriggers>)triggerVariable:(NSUInteger)idx {
    return [self swapWithElement: [XCIdentifier identifierWithVariableIndex:idx andParent:nil]
                         andParent:[self parent]];
}

-(id<XCHasTriggers>)triggerOperator: (XCOperator) op {
    assert([self parent]);
    XCElement * parent = [self parent];
    // only catch invert or minus, suppress other ops
    // urges user to fill spacer with value
    if (op==XC_OP_MINUS || op==XC_OP_DIV) {
        XCElement * el = (op==XC_OP_DIV) ?
        [XCInvert invertValue: self withParent:parent] :
        [XCNegate negateValue: self withParent:parent];
        [parent replaceContentWithElement:el];
    }
    return self;
}
-(id<XCHasTriggers>)triggerPrevious {
    id parent = [self triggerDel];
    return [parent triggerPrevious];
}
-(id<XCHasTriggers>)triggerNext {
    return [self triggerDel];
}

//evaluate
-(NSNumber *)eval {
    // use ans instead of errors
    XCElement* ans = [self swapWithElement:
            [XCIdentifier identifierWithVariableIndex:XC_ANS_IDX
                                              andParent:nil]
                                   andParent:[self parent]];
    return [ans eval];
}


@end

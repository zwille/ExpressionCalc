//
//  XCSpacer.m
//  TestHTML
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
-(NSString *)toHTML {
    //return @"&#9643";
    return [super wrapHTML:@"<mo>_</mo>"];
}

-(BOOL)isEmpty { return YES; }
-(BOOL)isEqual:(id)object {
    return [object isKindOfClass:[XCSpacer class]];
}
-(XCElement*) swapWithElement: (XCElement*) el andRoot: (XCElement*) root {
    assert(root);
    [root replaceContentWithElement:el];
    return el;
}
-(NSString *)description {
    return @"_";
}
//trigger
-(id<XCHasTriggers>)triggerDel {
    assert([self parent]);
    return [[self parent]triggerDel];
}
-(id<XCHasTriggers>)triggerNum:(char) c {
    return [self swapWithElement:
            [XCNumString numWithFirstChar: c]
                         andRoot:[self parent]];
}
-(id<XCHasTriggers>)triggerExpression {
    XCElement * root = [self parent];
    [self swapWithElement:
            [XCExpression expressionWithElement: self
                                  andParent: nil]
                  andRoot:root];
    return self;
}
-(id<XCHasTriggers>)triggerFunction: (NSString*) fn {
    XCElement * root = [self parent];
    [self swapWithElement:
            [XCFunction functionWithName:fn
                             withElement:self
                                 andParent: nil]
                  andRoot:root];
    return self;
}
-(id<XCHasTriggers>)triggerConstant:(XCConstants)cid {
    return [self swapWithElement: [XCIdentifier identifierWithConstantId:cid andRoot:nil]
                         andRoot:[self parent]];
}
-(id<XCHasTriggers>)triggerVariable:(NSUInteger)idx {
    return [self swapWithElement: [XCIdentifier identifierWithVariableIndex:idx andRoot:nil]
                         andRoot:[self parent]];
}
-(id<XCHasTriggers>)triggerAssign:(NSUInteger) varIdx {
    return self;
}

-(id<XCHasTriggers>)triggerOperator: (XCOperator) op {
    assert([self parent]);
    XCElement * root = [self parent];
    // only catch invert or minus, suppress other ops
    // urges user to fill spacer with value
    if (op==XC_OP_MINUS || op==XC_OP_DIV) {
        XCElement * el = (op==XC_OP_DIV) ?
        [XCInvert invertValue: self withParent:nil] :
        [XCNegate negateValue: self withParent:nil];
        [self swapWithElement: el andRoot:root];
    }
    return self;
}
-(id<XCHasTriggers>)triggerPrevious {
    id root = [self triggerDel];
    return [root triggerPrevious];
}
-(id<XCHasTriggers>)triggerNext {
    return [self triggerDel];
}
//evaluate
-(NSNumber *)eval {
    XCElement* ans = [self swapWithElement:
            [XCIdentifier identifierWithVariableIndex:XC_ANS_IDX
                                              andRoot:nil]
                                   andRoot:[self parent]];
    return [ans eval];
}


@end

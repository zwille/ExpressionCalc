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
#import "XCExpr.h"
#import "XCIdentifier.h"
#import "XCFunction.h"
//#import "XCConstant.h"
//#import "XCVariable.h"

@implementation XCSpacer
+(id)spacerWithRoot: (XCElement*) root {
    return [[XCSpacer alloc] initWithRoot:root];
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
//trigger

-(id<XCHasTriggers>)triggerNum:(char) c {
    return [self swapWithElement:
            [XCNumString numWithFirstChar: c]
                         andRoot:[self root]];
}
-(id<XCHasTriggers>)triggerExpression {
    XCElement * root = [self root];
    [self swapWithElement:
            [XCExpr expressionWithElement: self
                                  andRoot: nil]
                  andRoot:root];
    return self;
}
-(id<XCHasTriggers>)triggerFunction: (NSString*) fn {
    XCElement * root = [self root];
    [self swapWithElement:
            [XCFunction functionWithName:fn
                             withElement:self
                                 andRoot: nil]
                  andRoot:root];
    return self;
}
-(id<XCHasTriggers>)triggerConstant:(XCConstants)cid {
    return [self swapWithElement: [XCIdentifier identifierWithConstantId:cid andRoot:nil]
                         andRoot:[self root]];
}
-(id<XCHasTriggers>)triggerVariable:(NSUInteger)idx {
    return [self swapWithElement: [XCIdentifier identifierWithVariableIndex:idx andRoot:nil]
                         andRoot:[self root]];
}
-(id<XCHasTriggers>)triggerAssign:(NSUInteger) varIdx {
    return self;
}

-(id<XCHasTriggers>)triggerOperator: (XCOperator) op {
    assert([self root]);
    XCElement * root = [self root];
    // only catch invert or minus, suppress other ops
    // urges user to fill spacer with value
    switch (op) {
        case XC_OP_MINUS: {
            XCNegate * rc = [XCNegate negateValue: self withRoot:[self root]];
            return [root replaceContentWithElement:rc];
        }
        case XC_OP_DIV: {
            XCInvert * rc = [XCInvert invertValue: self withRoot:[self root]];
            return [root replaceContentWithElement:rc];
        }
        default: return self;
    }
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
    XCElement* ans = [self swapWithElement: [XCIdentifier identifierWithVariableIndex:0 andRoot:nil]
                                    andRoot:[self root]];
    return [ans eval];
}


@end

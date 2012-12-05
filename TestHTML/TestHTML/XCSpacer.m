//
//  XCSpacer.m
//  TestHTML
//
//  Created by Christoph Cwelich on 04.12.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCSpacer.h"
#import "XCNum.h"
#import "XCNegate.h"
#import "XCInvert.h"
#import "XCExpr.h"
#import "XCFunction.h"

@implementation XCSpacer
+(id)spacerWithRoot: (XCElement*) root {
    return [[XCSpacer alloc] initWithRoot:root];
}
-(NSString *)toHTMLfromChild {
    //return @"&#9643";
    return @"_";
}
-(BOOL)isEmpty { return YES; }
-(BOOL)isEqual:(id)object {
    return [object isKindOfClass:[XCSpacer class]];
}
-(XCSpacer*) swapWithElement: (XCElement*) el {
    assert([self root]);
    [[self root] replaceContentWithElement:el];
    return self;
}
//trigger

-(id<XCHasTriggers>)triggerNum:(char) c {
    return [self swapWithElement:
            [XCNum numWithFirstChar: c]];
}
-(id<XCHasTriggers>)triggerExpression {
    return [self swapWithElement:
            [XCExpr expressionWithElement: self
                                  andRoot: nil]];
}
-(id<XCHasTriggers>)triggerFunction: (XCFunctionSymbol) fn {
    return [self swapWithElement:
            [XCFunction functionWithElement: self
                                  andRoot: nil]];
}

-(id<XCHasTriggers>)triggerOperator: (XCOperator) op {
    assert([self root]);
    XCElement * root = [self root];
    // only catch invert or minus, suppress other ops
    // urges user to fill spacer with value
    switch (op) {
        case XC_OP_MINUS: {
            XCNegate * rc = [XCNegate negateValue: self withRoot:nil];
            return [root replaceContentWithElement:rc];
        }
        case XC_OP_DIV: {
            XCInvert * rc = [XCInvert invertValue: self withRoot:nil];
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


@end

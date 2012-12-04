//
//  XCExpr.m
//  TestHTML
//
//  Created by Christoph Cwelich on 29.11.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCExpr.h"
#import "XCProd.h"
#import "XCSpacer.h"
#import "XCNegate.h"
@implementation XCExpr
- (id)initWithRoot:(XCElement *)root;
{
    self = [super initWithRoot:root];
    if (self) {
        [_content insertElement:[XCSpacer spacerWithRoot:self]];
    }
    return self;
}
+(XCExpr *)emptyExpressionWithRoot:(XCElement *)root{
    return [[XCExpr alloc] initWithRoot:root];
}
/*
-(XCElement *)triggerMult {
    if(!_waitingForLiteral) {
        XCProd * p = [XCProd prodWithElement: [self currentElement]];
        [self setCurrentWithElement:p];
        return p;
    }
    else {
        return self;
    }
} */
-(id<XCHasTriggers>)triggerOperator:(XCOperator)op {
    XCElement * newEl = [XCSpacer spacerWithRoot:self];
    switch (op) {
        case XC_OP_MINUS:
            newEl = [XCNegate negateValue:newEl withRoot:self];
        case XC_OP_PLUS:
            [_content insertElement:newEl];
            break;
        case XC_OP_MULT:
            newEl = [XCProd prodWithFirstElement:[_content currentElement]
                                divSecondElement:newEl];
            [_content replaceCurrentWith: newEl];
            break;
        case XC_OP_DIV:
            newEl = [XCProd prodWithFirstElement:[_content currentElement]
                                divSecondElement:newEl];
            [_content replaceCurrentWith: newEl];
            break;
        //TODO XC_OP_EXC:
            
        default:
            assert(false);
            break;
    }
    return newEl;
}


-(NSString *)toHTMLfromChild {
    NSString * inner = [super toHTMLfromChild];
    return ([self root]) ?
        [NSString stringWithFormat:@"(%@)",inner ] :
        inner;
}
-(NSString *)htmlFromElement:(XCElement *)el atIndex:(NSUInteger)i andContentLength:(NSUInteger)len {
    NSString * html = [el toHTML];
    return (i==0 || [el isKindOfClass:[XCNegate class]]) ?
        html :
        [NSString stringWithFormat:@" +%@",[el toHTML]];
}


@end

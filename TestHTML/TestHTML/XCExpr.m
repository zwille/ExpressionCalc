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
#import "XCExpo.h"

@implementation XCExpr
- (id)initWithRoot:(XCElement *)root;
{
    self = [super initWithRoot:root];
    if (self) {
        [_content insertElement:[XCSpacer spacerWithRoot:self]];
        [_content nextIndex];
        // current index = 0 with spacer
    }
    return self;
}
+(XCExpr *)emptyExpressionWithRoot:(XCElement *)root{
    return [[XCExpr alloc] initWithRoot:root];
}
-(NSString *)toHTMLfromChild { //override due to braces
    NSString * inner = [super toHTMLfromChild];
    return ([self root]) ?
    [NSString stringWithFormat:@"(%@)",inner ] :
    inner;
}
-(NSString *)htmlFromElement:(XCElement *)el atIndex:(NSUInteger)i andContentLength:(NSUInteger)len {
    NSString * html = [el toHTML];
    return (i==0 || [el isKindOfClass:[XCNegate class]]) ?
    html :
    [NSString stringWithFormat:@" + %@",[el toHTML]];
}

//trigger

-(id<XCHasTriggers>)triggerOperator:(XCOperator)op {
    XCElement * spacer = [XCSpacer spacerWithRoot:self];
    XCElement * newEl = spacer;
    if (op==XC_OP_PLUS || op==XC_OP_MINUS) {
        if (op==XC_OP_MINUS) {
            newEl = [XCNegate negateValue:spacer withRoot:self];
        }
        [_content insertElement:newEl];
        [_content nextIndex];
        return spacer;
    }
    XCElement * e0 = [_content currentElement];
    XCElement * target = self;
    //pull out XCNegate
    if ([e0 isKindOfClass:[XCNegate class]]) {
        target = e0; // target is negate
        e0 = [e0 content];
    } 
    if(op == XC_OP_MULT) {
        newEl = [XCProd prodWithFirstElement:e0
                           multSecondElement:spacer
                                     andRoot:self];
    } else if (op == XC_OP_DIV) {
        newEl = [XCProd prodWithFirstElement:e0
                            divSecondElement:spacer
                                     andRoot:self];
    } else {
        assert(op == XC_OP_EXP);
        newEl = [XCExpo expoWithFirstElement:e0
                            andSecondElement:spacer
                                     andRoot:self];
    }
    [target replaceContentWithElement:newEl];
    return spacer;
}





@end

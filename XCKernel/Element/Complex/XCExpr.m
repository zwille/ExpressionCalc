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
#import "XCStatement.h"

@implementation XCExpr
- (id)initWithRoot:(XCElement*)root
   andFirstElement:(XCElement*)first {
    self = [super initWithRoot:root];
    if (self) {
        [_content insertElement:first];
        [first setRoot:self];
        [_content nextIndex];
        // current index = 0 with spacer
    }
    return self;
}
+(XCExpr *)emptyExpressionWithRoot:(XCElement *)root{
    
    return [[XCExpr alloc]
            initWithRoot:root
            andFirstElement:[XCSpacer spacerWithRoot:nil]];
}
+(XCExpr *)expressionWithElement:(XCElement *)first
                         andRoot:(XCElement *)root {
    return [[XCExpr alloc] initWithRoot: root
                        andFirstElement: first];
}
-(NSString *)toHTML {
    NSUInteger len = [_content length];
    assert(len>0);
    NSMutableString * buf =
    [NSMutableString stringWithString:[[_content elementAtIndex:0] toHTML]];
    for (NSUInteger i = 1; i<len; i++) {
        XCElement * el = [_content elementAtIndex:i];
        NSString * html = [el toHTML];
        [buf appendString: ([el isKindOfClass:[XCNegate class]]) ?
        html : // use XCNegate
        [NSString stringWithFormat:@"<mo>+</mo>%@",[el toHTML]]];
    }
    return [super wrapHTML: ([[self root] isKindOfClass:[XCStatement class]]) ?
    [NSString stringWithFormat:@"<mrow>%@</mrow>",buf]:
    [NSString stringWithFormat:@"<mfenced separators=" ">%@</mfenced>",buf]];
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


//evaluate
-(NSNumber *)eval {
    NSNumber * sum = @0;
    for (XCElement * e in _content) {
        sum = [sum addNum:[e eval]];
    }
    return sum;
}
-(BOOL)isEmpty {
    return [super isEmpty] ||
        ([_content length]==1
         && [[_content elementAtIndex:0] isKindOfClass:[XCSpacer class]]);
}

@end

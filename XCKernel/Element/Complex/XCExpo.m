//
//  XCExpo.m
//  TestHTML
//
//  Created by Christoph Cwelich on 05.12.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCExpo.h"
#import "XCExpr.h"
#import "XCSpacer.h"
#import "XCTerminalElement.h"

@implementation XCExpo
-(id)initWithRoot:(XCElement *)root
  andFirstElement: (XCElement*) e0
 andSecondElement: (XCElement*) e1 {
    self = [super initWithRoot:root];
    [_content insertElement:e0];
    [e0 setRoot:self];
    [_content nextIndex];
    
    e1 = [XCExpr expressionWithElement:e1 andRoot:self];
    [_content insertElement:e1];
    [e1 setRoot:self];
    [_content nextIndex];
    
    return self;
}
+(XCExpo *)expoWithFirstElement:(XCElement *)arg0
               andSecondElement:(XCElement *)arg1
                        andRoot:(XCElement *)root {
    return [[XCExpo alloc] initWithRoot: root
                        andFirstElement: arg0
                       andSecondElement: arg1];
    
}
-(NSString *)toHTML {
    NSUInteger len = [_content length];
    assert(len>1);
    NSString * exp = [[_content elementAtIndex:len-1] toHTML];
    for (NSUInteger i = len-2; i!=(NSUInteger)-1; --i) {
        XCElement * base = [_content elementAtIndex:i];
        exp = [NSString stringWithFormat:@"<msup> %@ <mrow>%@</mrow> </msup>",
               ([base isKindOfClass:[XCTerminalElement class] ]) ?
               [base toHTML] : [base toHTMLFenced]
               ,exp];
    }
    return [super wrapHTML: exp];
}
// override element
/*-(NSString *)htmlFromElement:(XCElement *)el atIndex:(NSUInteger)i andContentLength:(NSUInteger)len {
    return (i==0) ? [el toHTML] : [NSString stringWithFormat:@"<sup>%@</sup>", [el toHTML]];
}*/
// override trigger
-(id<XCHasTriggers>)triggerOperator:(XCOperator)op {
    switch (op) {
        case XC_OP_PLUS:
        case XC_OP_MINUS:
        case XC_OP_MULT:
        case XC_OP_DIV:
            return [super triggerOperator:op];
        case XC_OP_EXP: {
            XCSpacer * spacer = [XCSpacer spacerWithRoot:self];
            [_content insertElement:spacer];
            [_content nextIndex];
            return spacer;
        }
        default:
            assert(false);
    }
    return nil;
}

-(id<XCHasTriggers>)triggerDel {
    NSUInteger len = [_content length];
    assert(len>1);
    if (len<3) {
        assert([self root]);
        XCElement * root = [self root];
        XCElement * rc = [_content elementAtIndex:0];
        [root replaceContentWithElement:rc];
        return rc;
    } else {
        return [super triggerDel];
    }
}
// evaluate
-(NSNumber *)eval {
    NSUInteger len = [_content length];
    assert(len > 1);
    NSNumber * exp = [[_content elementAtIndex:len-1] eval];
    for (NSUInteger i=len-2; i!=(NSUInteger)-1; --i) {
        // exp = base ^ exp
        exp = [[[_content elementAtIndex:i]eval] powExp:exp];
    }
    return exp;
}
@end

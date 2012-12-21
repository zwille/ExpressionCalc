//
//  XCSum.m
//  XCCalc
//
//  Created by Christoph Cwelich on 19.12.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCSum.h"
#import "XCNegate.h"
#import "XCExpression.h"
#import "XCSpacer.h"

@implementation XCSum
+(id)sumWithElement0:(XCElement *)e0
         andElement1:(XCElement *)e1
             andParent:(XCElement *)parent{
    return [[XCSum alloc] initWithParent:parent
                       andFirstElement:e0
                      andSecondElement:e1 ];
}
-(NSString *)description {
    return [NSString stringWithFormat:@"+(%@, %@)",
            _content[0],_content[1]];
}
-(void)normalize {
    [super normalize];
    [self normalizeToElementSelf];
    [self normalizeRShiftClass:[XCNegate class]];
    /*
    BOOL isNeg[2];
    for (NSUInteger i=0; i<2; i++) {
        isNeg[i] = [_content[i] isKindOfClass:[XCNegate class]];
    }
    
    // normalize negation
    if (isNeg[0]) {
        if (isNeg[1]) { // -a-b
            XCNegate * neg = (XCNegate*)[self element0];
            XCElement * cc[2], * p =  [self parent];
            cc[0] = [neg content],
            cc[1] = [[self element1] content],
            [p replaceContentWithElement:neg];
            [neg setContent:self];
            for (NSUInteger i=0; i<2; i++) {
                _content[i] = cc[i];
            }
        } else if ([_content[1] isKindOfClass:[self class]]) {
            //shift invert right
            XCSum * s = (XCSum*) [self element1];
            assert( ![[s element0] isKindOfClass: [XCNegate class]]);
            XCElement * t = [s element0];
            [s setElement:[self element0] at:0];
            [self setElement:t at:0];
            [[self element1] normalize];
        } else { // -a+b
            [self swapElements];
        }
    }*/
    
 
}

//HTML
-(NSString *)toHTML {
    XCElement * e0 = [self element0];
    XCElement * e1 = [self element1];
    NSString * format =
    ([e1 isKindOfClass:[XCNegate class]]
     || ([e1 isKindOfClass:[XCSum class]]
     && [[((XCSum*)e1) element0] isKindOfClass:[XCNegate class]])) ?
    @"%@ %@" :
    @"%@ <mo>+</mo> %@";
    NSString * html0, * html1;
    html0 = ([e0 isKindOfClass:[XCExpression class]]) ? [e0 toHTMLFenced] : [e0 toHTML];
    html1 = ([e1 isKindOfClass:[XCExpression class]]) ? [e1 toHTMLFenced] : [e1 toHTML];
    return [super wrapHTML:
            [NSString stringWithFormat:format, html0, html1]];
}
//trigger

-(id<XCHasTriggers>)triggerOperator:(XCOperator)op {
    if (op==XC_OP_PLUS || op==XC_OP_MINUS) {
        XCElement * spacer = [XCSpacer spacerWithParent:nil];
        XCElement * newEl = (op==XC_OP_MINUS) ?
        [XCNegate negateValue:spacer withParent:nil] :
        spacer;
        newEl = [XCSum sumWithElement0:[self element1]
                   andElement1: newEl andParent:self];
        [self setElement:newEl at:1];
        return spacer;
    } else {
        return [super triggerOperator:op];
    }
}
//evaluate
-(NSNumber *)eval {
    return [[_content[0] eval] addNum: [_content[1] eval]];
}


@end

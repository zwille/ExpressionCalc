//
//  XCInvert.m
//  ExprCalc
//
//  Created by Christoph Cwelich on 25.11.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCInvert.h"
#import "XCSpacer.h"
#import "XCExpr.h"
@implementation XCInvert


+(id)invertValue:(XCElement*)value  withRoot:(XCElement *)root{
    if ([value isKindOfClass:[XCInvert class]]) {
        return [((XCSimpleElement*)value) content];
    }
    value = [XCExpr expressionWithElement:value andRoot:nil];
    return [[XCInvert alloc] initWithContent:value andRoot:root];
}
-(NSString *)toHTML {
    return [super wrapHTML:
            [NSString stringWithFormat:@"<mfrac> <mn>1</mn> <mrow>%@</mrow> </mfrac>", [[self content] toHTML]]];
}

-(XCElement*)replaceContentWithElement:(XCElement *)element {
    if ([element isKindOfClass:[self class]]) {
        element = [element content];
        id root = [self root];
        [element setRoot:root];
        [root replaceContentWithElement:element];
        return element;
    }
    return [super replaceContentWithElement:element];
}
//trigger
-(id<XCHasTriggers>)triggerOperator:(XCOperator)op {
    if(op==XC_OP_DIV && [[self content] isKindOfClass:[XCSpacer class]]) {
        XCElement* element = [self content];
        id root = [self root];
        [root replaceContentWithElement:element];
        return element;
    } else {
        return [super triggerOperator:op];
    }
}

//evaluate
-(NSNumber *)eval {
    NSNumber * rc = [[[self content] eval] invert];
    return [super checkErrorOn:rc];
}


@end

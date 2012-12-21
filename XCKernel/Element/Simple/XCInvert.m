//
//  XCInvert.m
//  ExprCalc
//
//  Created by Christoph Cwelich on 25.11.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCInvert.h"
#import "XCSpacer.h"
#import "XCExpression.h"
#import "XCNegate.h"
@implementation XCInvert


+(id)invertValue:(XCElement*)value  withParent:(XCElement *)parent{
    if ([value isKindOfClass:[XCInvert class]]) {
        return [((XCSimpleElement*)value) content];
    }
    return [[XCInvert alloc] initWithContent:value andParent:parent];
}
-(NSString *)description {
    return [NSString stringWithFormat:@"/(%@)",
            [self content]];
}
-(NSString *)toHTML {
    return [super wrapHTML:
            [NSString stringWithFormat:@"<mfrac> <mn>1</mn> <mrow>%@</mrow> </mfrac>", [[self content] toHTML]]];
}

-(void)normalize {
    [super normalize];
    XCElement * c = [self content];
    if ([c isKindOfClass:[XCNegate class]]) {
        XCElement * p = [self parent];
        XCElement * cc = [c content];
        [p replaceContentWithElement:c];
        [c replaceContentWithElement:self];
        [self setContent:cc];
    }
}
-(XCElement*)replaceContentWithElement:(XCElement *)element {
    if ([element isKindOfClass:[self class]]) {
        element = [element content];
        id parent = [self parent];
        [element setParent:parent];
        [parent replaceContentWithElement:element];
        return element;
    }
    return [super replaceContentWithElement:element];
}
//trigger
-(id<XCHasTriggers>)triggerOperator:(XCOperator)op {
    if(op==XC_OP_DIV && [[self content] isKindOfClass:[XCSpacer class]]) {
        XCElement* element = [self content];
        id parent = [self parent];
        [parent replaceContentWithElement:element];
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

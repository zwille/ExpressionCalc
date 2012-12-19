//
//  XCNegate.m
//  ExprCalc
//
//  Created by Christoph Cwelich on 25.11.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCNegate.h"
#import "XCSpacer.h"
#import "XCExpr.h"

@implementation XCNegate
+(id)negateValue:(XCElement*)value
withRoot:(XCElement *)root {
    if ([value isKindOfClass:[XCNegate class]]) {
        return [((XCSimpleElement*)value) content];
    }
    return [[XCNegate alloc] initWithContent:value
                                     andRoot:root];
}

-(NSString *)toHTML{
    assert([self content]);
    XCElement * content = [self content];
    return [super wrapHTML: [NSString stringWithFormat: @"<mo>-</mo>%@",
                ([content isKindOfClass:[XCExpr class]]) ?
                             [content toHTMLFenced]:
                             [content toHTML]]];
}
-(XCElement*)replaceContentWithElement:(XCElement *)element {
    if ([element isKindOfClass:[self class]]) {
        element = [element content];
        id root = [self root];
        [root replaceContentWithElement:element];
        return element;
    }
    return [super replaceContentWithElement:element];
}
//trigger
-(id<XCHasTriggers>)triggerOperator:(XCOperator)op {
    if(op==XC_OP_MINUS && [[self content] isKindOfClass:[XCSpacer class]]) {
        XCElement* element = [self content];
        id root = [self root];
        [root replaceContentWithElement:element];
        return element;
    } else {
        return [[self root] triggerOperator:op];
    }
}
//evaluate
-(NSNumber *)eval {
    return [[[self content] eval] negate];
}

@end

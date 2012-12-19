//
//  XCNegate.m
//  ExprCalc
//
//  Created by Christoph Cwelich on 25.11.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCNegate.h"
#import "XCSpacer.h"
#import "XCExpression.h"

@implementation XCNegate
+(id)negateValue:(XCElement*)value
withParent:(XCElement *)parent {
    if ([value isKindOfClass:[XCNegate class]]) {
        return [((XCSimpleElement*)value) content];
    }
    return [[XCNegate alloc] initWithContent:value
                                     andParent:parent];
}
-(NSString *)description {
    return [NSString stringWithFormat:@"-(%@)",
           [self content]];
}
-(NSString *)toHTML{
    assert([self content]);
    XCElement * content = [self content];
    return [super wrapHTML: [NSString stringWithFormat: @"<mo>-</mo>%@",[content toHTML]]];
}
-(XCElement*)replaceContentWithElement:(XCElement *)element {
    if ([element isKindOfClass:[self class]]) {
        element = [element content];
        id root = [self parent];
        [root replaceContentWithElement:element];
        return element;
    }
    return [super replaceContentWithElement:element];
}
//trigger
-(id<XCHasTriggers>)triggerOperator:(XCOperator)op {
    if(op==XC_OP_MINUS && [[self content] isKindOfClass:[XCSpacer class]]) {
        XCElement* element = [self content];
        id root = [self parent];
        [root replaceContentWithElement:element];
        return element;
    } else {
        return [super triggerOperator:op];
    }
}
//evaluate
-(NSNumber *)eval {
    return [[[self content] eval] negate];
}

@end

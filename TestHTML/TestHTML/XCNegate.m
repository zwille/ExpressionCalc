//
//  XCNegate.m
//  ExprCalc
//
//  Created by Christoph Cwelich on 25.11.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCNegate.h"

@implementation XCNegate
+(id)negateValue:(XCElement*)value
withRoot:(XCElement *)root {
    if ([value isKindOfClass:[XCNegate class]]) {
        return [((XCSimpleElement*)value) content];
    }
    return [[XCNegate alloc] initWithContent:value
                                     andRoot:root];
}

-(NSString *)toHTMLfromChild{
    return [NSString stringWithFormat:@" - %@", [[self content] toHTML]];
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
    if(op==XC_OP_MINUS) {
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
    return [[[self content] eval] negate];
}

@end

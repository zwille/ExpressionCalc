//
//  XCInvert.m
//  ExprCalc
//
//  Created by Christoph Cwelich on 25.11.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCInvert.h"

@implementation XCInvert


+(id)invertValue:(XCElement*)value  withRoot:(XCElement *)root{
    if ([value isKindOfClass:[XCInvert class]]) {
        return [((XCSimpleElement*)value) content];
    }
    return [[XCInvert alloc] initWithContent:value andRoot:root];
}
-(NSString *)toHTMLfromChild {
    return [NSString stringWithFormat:@"%@<sup>-1</sup>", [[self content] toHTML]];
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
    if(op==XC_OP_DIV) {
        XCElement* element = [self content];
        id root = [self root];
        [root replaceContentWithElement:element];
        return element;
    } else {
        return [super triggerOperator:op];
    }
}



@end

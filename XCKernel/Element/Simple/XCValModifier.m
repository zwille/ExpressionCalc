//
//  XCValModifier.m
//  XCCalc
//
//  Created by Christoph Cwelich on 21.12.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCValModifier.h"

@implementation XCValModifier

-(void)normalize {
    [_content normalize];
    // if content has same type as self
    XCElement * content = [self content];
    if ([content isKindOfClass:[self class]]) {
        id parent = [self parent];
        assert(parent);
        [parent replaceContentWithElement:[content content]];
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
@end

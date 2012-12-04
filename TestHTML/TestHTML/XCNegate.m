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
-(NSString *)toHTML{
    return [NSString stringWithFormat:@" -%@", [[self content] toHTML]];
}



@end

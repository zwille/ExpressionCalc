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

@end

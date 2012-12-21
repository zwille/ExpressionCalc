//
//  XCSqrt.m
//  XCCalc
//
//  Created by Christoph Cwelich on 11.12.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCSqrt.h"
#import "XCExpression.h"

@implementation XCSqrt
-(NSString *)toHTML {
    return [super wrapHTML: [NSString stringWithFormat:
            @"<msqrt>%@</msqrt>",[[self content] toHTML]]];
}

@end

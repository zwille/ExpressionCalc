//
//  XCConstant.m
//  ExprCalc
//
//  Created by Christoph Cwelich on 23.11.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCConstant.h"
#import "XCToken.h"
#import "XCErrorToken.h"

static XCConstant * XC_PI = nil, * XC_EULER = nil;
@implementation XCConstant
+(void)initialize{
    XC_PI = [[XCConstant alloc] initWithDouble:M_PI];
    XC_EULER = [[XCConstant alloc] initWithDouble:M_E];
}

-(id) initWithDouble: (double) value {
    self = [super init];
    _value = [XCNumber numberFromDouble:value];
    return self;
}
+(id)parseWithTokenizer:(XCTokenizer *)tok andArg:(id)arg{
    if ([arg tokenType]==SPECIAL) {
        switch ([[arg content] characterAtIndex:0]) {
            case PI:
                return XC_PI;
            case EULER:
                return XC_EULER;
            default:
                return nil;
        }
    } else {
        return nil;
    }
}

@end



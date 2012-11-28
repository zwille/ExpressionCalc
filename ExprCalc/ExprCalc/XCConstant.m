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
@synthesize name = _name;
+(void)initialize{
    XC_PI = [[XCConstant alloc] initWithDouble:M_PI andName:[NSString stringWithFormat:@"%C",(unichar)PI]];
    XC_EULER = [[XCConstant alloc] initWithDouble:M_E andName:[NSString stringWithFormat:@"%C",(unichar)EULER]];
}
-(XCNumber *)value{
    return _value;
}

-(id) initWithDouble: (double) value andName: (NSString*) name {
    self = [super init];
    _value = [XCNumber numberFromDouble:value];
    _name = name;
    return self;
}
-(NSString *)description{
    return _name;
}
+(id)parseWithTokenizer:(XCTokenizer *)tok andArg:(id)arg{
    assert(arg!=nil);
    if ([arg tokenType]==WORD) {
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



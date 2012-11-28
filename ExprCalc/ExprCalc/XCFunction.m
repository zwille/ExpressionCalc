//
//  XCFunction.m
//  ExprCalc
//
//  Created by Christoph Cwelich on 23.11.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCFunction.h"
#import "XCNumber.h"
#import "XCErrorToken.h"

@implementation XCFunction

+(id)parseWithTokenizer:(XCTokenizer *)tok andArg:(id)arg{
    assert(arg!=nil);
    XCToken * token = arg;
    NSString * name = [token content];
    XCFunctionPrototype * p = [XCFunctionPrototype prototypeByName:name];
    if (p==nil) {
        return nil;
    }
    id funcarg = [XCLiteral parseWithTokenizer:tok andArg:nil];
    if ([funcarg isKindOfClass:[XCErrorToken class]]) {
        return funcarg;
    } else if([funcarg conformsToProtocol: @protocol(XCHasValue)] ||
              [funcarg isKindOfClass:[XCNumber class]]) {
        return [[XCFunction alloc] initWithProtoype:p andArg:funcarg];
    } else {
        return nil;
    }
}
-(id)initWithProtoype:(XCFunctionPrototype *)proto andArg:(id<XCHasValue>)arg {
    self = [super init];
    _prototype = proto;
    _arg = arg;
    return self;
}
-(XCNumber*) value{
    XCNumber * argval = [_arg value];
    return [argval execFunc:_prototype];
}
-(NSString *)description{
    return [NSString stringWithFormat:@"%@%@",_prototype,_arg];
}

@end

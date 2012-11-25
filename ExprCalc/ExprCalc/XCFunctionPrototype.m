//
//  XCFunctionPrototype.m
//  ExprCalc
//
//  Created by Christoph Cwelich on 25.11.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCFunctionPrototype.h"

static NSMutableArray * protos = nil;
static NSMutableDictionary * protoIndex = nil;
@implementation XCFunctionPrototype
@synthesize name = _name;
@synthesize function = _function;
-(id)initWithName:(NSString*) name andFunc: (func_t) function {
    self = [super init];
    _name = name;
    _function = function;
    return self;
}

+(XCFunctionPrototype*) prototypeBySymbol:(Function)sym {
    return [protos objectAtIndex:sym];
}
+(XCFunctionPrototype*) prototypeByName: (NSString*) name {
    return [protoIndex objectForKey:name];
}
+(id)parseWithTokenizer:(XCTokenizer *)tok andArg:(id)arg{
    XCToken * token = arg;
    return [XCFunctionPrototype prototypeByName:[token content]];
}
+(void)insertAtIndex:(NSUInteger)i withName: (NSString*) name andFunc: (func_t) func {
    XCFunctionPrototype * fp = [[XCFunctionPrototype alloc]
                                initWithName:name
                                andFunc:func];
    [protos insertObject: fp atIndex: i];
    [protoIndex setObject: fp forKey:name];
}
+(void)initialize{
    NSUInteger CAPACITY = 8;
    protos = [NSMutableArray arrayWithCapacity:CAPACITY];
    protoIndex = [NSMutableDictionary dictionaryWithCapacity:CAPACITY];
    [XCFunctionPrototype insertAtIndex: FN_SQRT
                              withName: [NSString stringWithFormat:@"%C",(unichar)SQRT]
                               andFunc: sqrt
    ];
    [XCFunctionPrototype insertAtIndex: FN_COS
                              withName: @"cos"
                               andFunc: cos
     ];
    [XCFunctionPrototype insertAtIndex: FN_SIN
                              withName: @"sin"
                               andFunc: sin
     ];
    [XCFunctionPrototype insertAtIndex: FN_TAN
                              withName: @"tan"
                               andFunc: tan
     ];
    [XCFunctionPrototype insertAtIndex: FN_ACOS
                              withName: @"acos"
                               andFunc: acos
     ];
    [XCFunctionPrototype insertAtIndex: FN_ASIN
                              withName: @"asin"
                               andFunc: asin
     ];
    [XCFunctionPrototype insertAtIndex: FN_ATAN
                              withName: @"atan"
                               andFunc: atan
     ];
    [XCFunctionPrototype insertAtIndex: FN_EXP
                              withName: @"exp"
                               andFunc: exp
     ];
}
@end

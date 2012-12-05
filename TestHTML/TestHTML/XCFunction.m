//
//  XCFunction.m
//  TestHTML
//
//  Created by Christoph Cwelich on 05.12.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCFunction.h"

//TODO Mapping with strings
static const NSDictionary * functions; 

@implementation XCFunction
+(void)initialize{
    functions = @{
    @"√":[XCFuncAlg with: sqrt],
    @"ln":[XCFuncAlg with: log],
    @"exp":[XCFuncAlg with: exp],
    
    @"cos":[XCFuncAlg with: cos],
    @"sin":[XCFuncAlg with: sin],
    @"tan":[XCFuncAlg with: tan],
    
    @"acos":[XCFuncAlg with: acos],
    @"asin":[XCFuncAlg with: asin],
    @"atan":[XCFuncAlg with: atan]
    };
}
- (id)initWithRoot:(XCElement*)root
           andName: (NSString*) name
        andElement:(XCElement*)element {
    self = [super initWithRoot:root];
    if (self) {
        _name = name;
        [self setContent:element];
    }
    return self;
}
-(NSString *)toHTML {
    return [NSString stringWithFormat:
            @"%@ %@",_name, [[self content] toHTML]];
}
+(XCFunction *)functionWithName:(NSString *)name
                    withElement:(XCElement *)element
                        andRoot:(XCElement *)root {
    return [[XCFunction alloc] initWithRoot: root
                                    andName:name
                                 andElement: element];
}


@end

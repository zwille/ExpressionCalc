//
//  XCFunctionPrototype.h
//  ExprCalc
//
//  Created by Christoph Cwelich on 25.11.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCLiteral.h"

typedef double(*func_t)(double);
@interface XCFunctionPrototype : XCLiteral {
    NSString * _name;
    func_t _call;
}
@property (readonly,strong) NSString * name;
@property (readonly) func_t function;

+(XCFunctionPrototype*) prototypeBySymbol: (XCFunctionSymbol) sym;
+(XCFunctionPrototype*) prototypeByName: (NSString*) name;


@end

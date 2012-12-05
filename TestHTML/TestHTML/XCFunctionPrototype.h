//
//  XCFunctionPrototype.h
//  ExprCalc
//
//  Created by Christoph Cwelich on 25.11.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCElement.h"

typedef double(*func_t)(double);
@interface XCFunctionPrototype : NSObject {
    NSString * _name;
    func_t _type;
}
@property (readonly,strong) NSString * name;
@property (readonly) func_t function;
+(id) functionWithName: (NSString*) name
         andDefinition: (func_t) type;


@end

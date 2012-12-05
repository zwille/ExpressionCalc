//
//  XCFuncAlg.h
//  TestHTML
//
//  Created by Christoph Cwelich on 05.12.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCFunction.h"
typedef double(*func_t)(double);
@interface XCFuncAlg : XCFunction {
    func_t _alg;
}
+(id) with: (func_t) algo;
-(NSNumber* ) evaluateArgument: (NSNumber*) arg;

@end

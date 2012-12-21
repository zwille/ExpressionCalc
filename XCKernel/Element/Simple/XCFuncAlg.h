//
//  XCFuncAlg.h
//  XCCalc
//
//  Created by Christoph Cwelich on 05.12.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//


typedef double(*func_t)(double);
@interface XCFuncAlg : NSObject {
    @protected
    func_t _alg;
}
+(id) with: (func_t) algo;
-(NSNumber* ) evaluateArgument: (NSNumber*) arg;
-(id) initWithFuncT:(func_t) algo;
@end

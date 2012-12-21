//
//  XCFuncAlg.m
//  TestHTML
//
//  Created by Christoph Cwelich on 05.12.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCFuncAlg.h"

@implementation XCFuncAlg

-(id) initWithFuncT:(func_t) algo {
    self = [super init];

    _alg = algo;
    return self;
}

-(NSNumber *)evaluateArgument:(NSNumber *)arg {
    double rc = _alg([arg doubleValue]);
    return [NSNumber numberWithDouble:rc];
}
+(id)with:(func_t)algo{
    return [[XCFuncAlg alloc] initWithFuncT:algo];
}

@end

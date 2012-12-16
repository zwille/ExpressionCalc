//
//  XCTrigoFuncAlg.m
//  XCCalc
//
//  Created by Christoph Cwelich on 10.12.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCTrigoFuncAlg.h"
#import "XCGlobal.h"
#import "NSNumber+XCNumber.h"
NSNumber * deg2Rad(NSNumber * degree) {
    return [NSNumber numberWithDouble:
             M_PI * ([degree doubleValue] / 180.0) ];
}
NSNumber * rad2Deg(NSNumber * rad) {
    return [NSNumber numberWithDouble:
             ([rad doubleValue] * 180.0) / M_PI ];
}
@implementation XCTrigoFuncAlg
-(NSNumber *)evaluateArgument:(NSNumber *)arg {
    if ([[XCGlobal instance] angleAsDegree]) {
        if (_alg == acos || _alg == asin || _alg == atan) {
            return rad2Deg([super evaluateArgument:arg]);
        } else {
            return [super evaluateArgument:deg2Rad(arg)];
        }
    }
    return [super evaluateArgument:arg];
}
+(id)with:(func_t)algo{
    return [[XCTrigoFuncAlg alloc] initWithFuncT:algo];
}
@end

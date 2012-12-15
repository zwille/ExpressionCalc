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
             M_PI * [degree doubleValue] / 180 ];
}
@implementation XCTrigoFuncAlg
-(NSNumber *)evaluateArgument:(NSNumber *)arg {
    if ([[XCGlobal instance] angleAsDegree]) {
        arg = deg2Rad(arg);
    }
    return [super evaluateArgument:arg];
}
+(id)with:(func_t)algo{
    return [[XCTrigoFuncAlg alloc] initWithFuncT:algo];
}
@end

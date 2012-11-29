//
//  XCNumber.m
//  ExpressionCalc
//
//  Created by Christoph Cwelich on 21.11.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCNumber.h"

@implementation XCNumber
const double EPS = 1e-10;
+(XCNumber *)numberFromString:(NSString *)numStr {
    NSScanner * scanner = [NSScanner scannerWithString:numStr];
    double val = 0.0;
    bool success = [scanner scanDouble:&val];
    bool isAtEnd = [scanner isAtEnd];
    return (success && isAtEnd) ? [XCNumber numberFromDouble: val] : nil;
}
+(XCNumber*)numberFromDouble:(double)value {
    return [[XCNumber alloc] initWithDouble:value];
}
-(id)initWithDouble:(double)value {
    self = [super init];
    val = value;
    return self;
}
-(BOOL)isEqual:(id)object {
    if(! [object isKindOfClass:[XCNumber class]]) {
        return NO;
    }
    XCNumber * other = (XCNumber*) object;
    return (abs(val - other->val)<EPS);
}
-(NSString *)description{
    return [NSString stringWithFormat:@"%f",val];
}
-(XCNumber*) negate {
    return [XCNumber numberFromDouble:-val];
}
-(XCNumber*) invert {
    return [XCNumber numberFromDouble:1/val];
}
-(XCNumber*) add: (XCNumber*) rhs {
    return [XCNumber numberFromDouble: val+rhs->val];
}
-(XCNumber*) mult: (XCNumber*) rhs{
    return [XCNumber numberFromDouble: val*rhs->val];
}
-(XCNumber*) pow: (XCNumber*) exp{
    return [XCNumber numberFromDouble: pow(val,exp->val)];
}
-(XCNumber*)value{
    return self;
}
-(XCNumber *)execFunc:(XCFunctionPrototype *)f {
    func_t func = [f function];
    return [XCNumber numberFromDouble: func(val)];
}
@end

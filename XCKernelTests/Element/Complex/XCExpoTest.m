//
//  XCExpoTest.m
//  XCCalc
//
//  Created by Christoph Cwelich on 12.12.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCExpoTest.h"
#import "XCExpr.h"
@implementation XCExpoTest
-(void)testSimple {
    XCExpr * expr = [XCExpr emptyExpressionWithRoot:nil];
    id  head = [expr head]; //spacer
    head = [head triggerNum:'2'];
    head = [head triggerOperator:XC_OP_EXP];
    head = [head triggerNum:'3'];
    NSNumber * result = [expr eval];
    STAssertEqualObjects(result, @8, nil); //2^3
    head = [head triggerOperator:XC_OP_EXP];
    head = [head triggerNum:'2'];
    result = [expr eval]; 
    STAssertEqualObjects(result, @512, nil);// 2^3^2 = 2^(3^2)
    head = [head triggerOperator:XC_OP_EXP];
    head = [head triggerNum:'2'];
    result = [expr eval];
    STAssertEqualObjects(result, [NSNumber numberWithDouble:pow(2, pow(3, pow(2,2)))], nil);// 2^3^2^2  
    
}
-(void)testComplex {
    XCExpr * expr = [XCExpr emptyExpressionWithRoot:nil];
    id  head = [expr head]; //spacer
    head = [head triggerNum:'2'];
    head = [head triggerOperator:XC_OP_EXP];
    head = [head triggerNum:'3'];
    //test operator binding
    head = [head triggerOperator:XC_OP_DIV];
    head = [head triggerNum:'4'];
    NSNumber * result = [expr eval];
    STAssertEqualObjects(result, @2, nil);
    head = [head triggerOperator:XC_OP_PLUS];
    head = [head triggerNum:'4'];
    result = [expr eval];
    STAssertEqualObjects(result, @6, nil); //2^3/4+4

}
@end

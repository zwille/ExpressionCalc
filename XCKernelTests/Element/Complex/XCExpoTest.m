//
//  XCExpoTest.m
//  XCCalc
//
//  Created by Christoph Cwelich on 12.12.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCExpoTest.h"
#import "XCExpr.h"
#import "XCStatement.h"
@implementation XCExpoTest
-(void)testSimple {
    XCStatement * stm = [XCStatement emptyStatement];
    id  head = [stm head]; //spacer
    head = [head triggerNum:'2'];
    head = [head triggerOperator:XC_OP_EXP];
    head = [head triggerNum:'3'];
    NSNumber * result = [stm eval];
    STAssertEqualObjects(result, @8, nil); //2^3
    head = [head triggerOperator:XC_OP_EXP];
    head = [head triggerNum:'2'];
    result = [stm eval];
    STAssertEqualObjects(result, @512, nil);// 2^3^2 = 2^(3^2)
    head = [head triggerOperator:XC_OP_EXP];
    head = [head triggerNum:'2'];
    result = [stm eval];
    STAssertEqualObjects(result, [NSNumber numberWithDouble:pow(2, pow(3, pow(2,2)))], nil);// 2^3^2^2  
    
}
-(void)testCopy {
    XCStatement * stm = [XCStatement emptyStatement];
    id  head = [stm head]; //spacer
    head = [head triggerNum:'2'];
    head = [head triggerOperator:XC_OP_EXP];
    head = [head triggerNum:'3'];
    
    XCStatement * cp = [stm copy];
    head = [cp head];
    head = [head triggerOperator:XC_OP_EXP];
    head = [head triggerNum:'2'];
    
    NSNumber * result = [stm eval];
    STAssertEqualObjects(result, @8, nil); //2^3
    
    result = [cp eval];
    STAssertEqualObjects(result, @512, nil);// 2^3^2 = 2^(3^2)
}
-(void)testComplex {
    XCStatement * stm = [XCStatement emptyStatement];
    id  head = [stm head]; //spacer
    head = [head triggerNum:'2'];
    head = [head triggerOperator:XC_OP_EXP];
    head = [head triggerNum:'3'];
    //test operator binding
    head = [head triggerNext];
    head = [head triggerOperator:XC_OP_DIV];
    head = [head triggerNum:'4'];
    NSNumber * result = [stm eval];
    STAssertEqualObjects(result, @2, nil);
    head = [head triggerNext];
    head = [head triggerOperator:XC_OP_PLUS];
    head = [head triggerNum:'4'];
    result = [stm eval];
    STAssertEqualObjects(result, @6, nil); //2^3/4+4

}
@end

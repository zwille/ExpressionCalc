//
//  XCKernelTest.m
//  XCCalc
//
//  Created by Christoph Cwelich on 16.12.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCKernelTest.h"
#import "XCKernel.h"

@implementation XCKernelTest
-(void)testInput {
    XCKernel * k = [[XCKernel alloc] init];
    // (1): 2^3^2 / 2 * cos90 + 4
    STAssertTrue([k isDegreeAngleMode], nil);
    [k triggerNum:'2'];
    [k triggerOperator:XC_OP_EXP];
    [k triggerNum:'3'];
    [k triggerOperator:XC_OP_EXP];
    [k triggerNum:'2'];
    [k triggerNext];
    [k triggerOperator:XC_OP_DIV];
    [k triggerNum:'2'];
    [k triggerNext];
    [k triggerFunction:@"cos"];
    [k triggerNum:'9'];
    [k triggerNum:'0'];
    [k triggerNext];
    [k triggerOperator:XC_OP_PLUS];
    [k triggerNum:'4'];
    NSNumber * result = [k eval];
    STAssertEqualObjects(result, @260, nil);
    
    // (2): 2 * pi
    [k triggerNum:'2'];
    [k triggerOperator:XC_OP_MULT];
    [k triggerConstant:XC_PI_ID];
    result = [k eval];
    STAssertEqualObjects(result, @(2*M_PI), nil);
    
    // (3): x0 = x0 + 1;
    [k triggerVariable:0];
    [k triggerAssign:0];
    [k triggerOperator:XC_OP_PLUS];
    [k triggerNum:'1'];
    result = [k eval];
    STAssertEqualObjects(result, @1, nil);
    result = [k eval];
    STAssertEqualObjects(result, @2, nil);
    result = [k eval];
    STAssertEqualObjects(result, @3, nil);
    
    // (4): 2.5, test del
    [k triggerNum:'2'];
    [k triggerNum:XC_PT];
    [k triggerNum:XC_PT];
    [k triggerNum:'7'];
    [k triggerDel];
    [k triggerDel];
    [k triggerNum:XC_PT];
    [k triggerNum:'5'];
    result = [k eval];
    STAssertEqualObjects(result, @2.5, nil);
    
    // (5): -ans * 2
    [k triggerOperator:XC_OP_MINUS];
    [k triggerVariable:XC_ANS_IDX];
    [k triggerOperator:XC_OP_MULT];
    [k triggerNum:'2'];
    result = [k eval];
    STAssertEqualObjects(result, @-5, nil);
    result = [k eval];
    STAssertEqualObjects(result, @10, nil);
    result = [k eval];
    STAssertEqualObjects(result, @-20, nil);
    
    // (6): 1/0 (error)
    [k triggerOperator:XC_OP_DIV];
    [k triggerNum:'0'];
    result = [k eval];
    STAssertTrue([result isNaN], nil);
    
    // (7): correct (5): 1/2
    [k triggerEnter];
    [k triggerEnter];
    [k triggerDel];
    [k triggerOperator:XC_OP_DIV];
    [k triggerNum:'2'];
    result = [k eval];
    STAssertEqualObjects(result, @.5, nil);
    
    // (8): [rad] sin( pi / 2)
    [k toggleAngleMode];
    STAssertFalse([k isDegreeAngleMode], nil);
    [k triggerFunction:@"sin"];
    [k triggerConstant:XC_PI_ID];
    [k triggerOperator:XC_OP_DIV];
    [k triggerNum:'2'];
    result = [k eval];
    STAssertEqualObjects(result, @1, nil);
    
    // (9): [deg] sin( 90)
    [k toggleAngleMode];
    STAssertTrue([k isDegreeAngleMode], nil);
    [k triggerFunction:@"sin"];
    [k triggerNum:'9'];
    [k triggerNum:'0'];
    result = [k eval];
    STAssertEqualObjects(result, @1, nil);
    
    // (10): sqrt(20+5)
    [k triggerFunction:XC_SQRT];
    [k triggerNum:'2'];
    [k triggerNum:'0'];
    [k triggerOperator:XC_OP_PLUS];
    [k triggerNum:'5'];
    result = [k eval];
    STAssertEqualObjects(result, @5, nil);
    
    // (11): ln(e)
    [k triggerFunction:@"ln"];
    [k triggerConstant:XC_EULER_ID];
    result = [k eval];
    STAssertEqualObjects(result, @1, nil);
    
    // (12): goto (5)
    [k previousStatement]; // (10) ...
    [k previousStatement];
    [k previousStatement];
    [k previousStatement];
    [k previousStatement];
    [k previousStatement]; // (5)
    result = [k eval]; // -ans*2 = -1*2
    STAssertEqualObjects(result, @-2, nil);
    result = [k eval]; 
    STAssertEqualObjects(result, @4, nil);
    
    // (13): modify (5) + 1
    [k triggerEnter];
    [k triggerOperator:XC_OP_PLUS];
    [k triggerNum:'1'];
    result = [k eval];
    STAssertEqualObjects(result, @-7, nil);
 
}
@end

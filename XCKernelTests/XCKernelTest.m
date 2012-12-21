//
//  XCKernelTest.m
//  XCCalc
//
//  Created by Christoph Cwelich on 16.12.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCKernelTest.h"
#import "XCKernel.h"
#import "XCGlobal.h"

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
    [k triggerOperator:XC_OP_MULT];
    [k triggerFunction:@"sin"];
    [k triggerNum:'9'];
    [k triggerNum:'0'];
    [k triggerOperator:XC_OP_PLUS];
    [k triggerNum:'4'];
    NSNumber * result = [k eval];
    STAssertTrue([result isInteger], nil);
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
    STAssertTrue([result isInteger], nil);
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
    STAssertTrue([result isInteger], nil);
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
    [k triggerDel];
    [k triggerNum:'2'];
    result = [k eval];
    STAssertEqualObjects(result, @.5, nil);
    
    // (8): [rad] sin( pi / 2)
    [k toggleAngleMode];
    STAssertFalse([k isDegreeAngleMode], nil);
    [k triggerFunction:@"sin"];
    [k triggerExpression];
    [k triggerConstant:XC_PI_ID];
    [k triggerOperator:XC_OP_DIV];
    [k triggerNum:'2'];
    result = [k eval];
    STAssertTrue([result isInteger], nil);
    STAssertEqualObjects(result, @1, nil);
    
    // (9): [deg] sin( 90)
    [k toggleAngleMode];
    STAssertTrue([k isDegreeAngleMode], nil);
    [k triggerFunction:@"sin"];
    [k triggerNum:'9'];
    [k triggerNum:'0'];
    result = [k eval];
    STAssertTrue([result isInteger], nil);
    STAssertEqualObjects(result, @1, nil);
    
    // (10): sqrt(20+5)
    [k triggerFunction:XC_SQRT];
    [k triggerExpression];
    [k triggerNum:'2'];
    [k triggerNum:'0'];
    [k triggerOperator:XC_OP_PLUS];
    [k triggerNum:'5'];
    result = [k eval];
    STAssertTrue([result isInteger], nil);
    STAssertEqualObjects(result, @5, nil);
    
    // (11): ln(e)
    [k triggerFunction:@"ln"];
    [k triggerConstant:XC_EULER_ID];
    result = [k eval];
    STAssertTrue([result isInteger], nil);
    STAssertEqualObjects(result, @1, nil);
    
    // (12): goto (5)
    [k previousStatement]; // (10) ...
    [k previousStatement];
    [k previousStatement];
    [k previousStatement];
    [k previousStatement];
    [k previousStatement]; // (5)
    result = [k eval]; // -ans*2 = -1*2
    STAssertTrue([result isInteger], nil);
    STAssertEqualObjects(result, @-2, nil);
    result = [k eval]; 
    STAssertEqualObjects(result, @4, nil);
    
    // (13): modify (5) + 1
    [k triggerEnter];
    [k triggerOperator:XC_OP_PLUS];
    [k triggerNum:'1'];
    result = [k eval];
    STAssertTrue([result isInteger], nil);
    STAssertEqualObjects(result, @-7, nil);
    
    // (14): cos 90 + 4 //check rounding
    STAssertTrue([k isDegreeAngleMode], nil);
    [k triggerFunction:@"cos"];
    [k triggerNum:'9'];
    [k triggerNum:'0'];
    [k triggerOperator:XC_OP_PLUS];
    [k triggerNum:'4'];
    result = [k eval];
    STAssertEqualObjects(result, @4, nil);
    
    // (15): x2=0.5, x1=-2, x0=3/2, (-x1 + sqrt(x1^2 - 4*x2*x0)) / (2*x2)
    [k triggerAssign:2];
    [k triggerNum:'.'];
    [k triggerNum:'5'];
    result = [k eval];
    STAssertEqualObjects(result, @.5, nil);
    
    [k triggerAssign:1];
    [k triggerOperator:XC_OP_MINUS];
    [k triggerNum:'2'];
    result = [k eval];
    STAssertEqualObjects(result, @-2, nil);
    
    [k triggerAssign:0];
    [k triggerNum:'3'];
    [k triggerOperator:XC_OP_DIV];
    [k triggerNum:'2'];
    result = [k eval];
    STAssertEqualObjects(result, @(3.0/2), nil);
    
    [k triggerVariable:2];
    result = [k eval];
    STAssertEqualObjects(result, @.5, nil);
    
    [k triggerVariable:1];
    result = [k eval];
    STAssertEqualObjects(result, @-2, nil);
    
    [k triggerVariable:0];
    result = [k eval];
    STAssertEqualObjects(result, @(3.0/2), nil);
    
    [k triggerExpression];
    [k triggerOperator:XC_OP_MINUS];
    [k triggerVariable:1];
    [k triggerOperator:XC_OP_PLUS];
    [k triggerFunction:XC_SQRT];
    [k triggerExpression];
    [k triggerVariable:1];
    [k triggerOperator:XC_OP_EXP];
    [k triggerNum:'2'];
    [k triggerOperator:XC_OP_MINUS];
     [k triggerNum:'4'];
    [k triggerOperator:XC_OP_MULT];
    [k triggerVariable:2];
    [k triggerOperator:XC_OP_MULT];
    [k triggerVariable:0];
    [k triggerNext];
    [k triggerOperator:XC_OP_DIV];
    [k triggerExpression];
    [k triggerNum:'2'];
    [k triggerOperator:XC_OP_MULT];
    [k triggerVariable:2];
    result = [k eval];
    STAssertEqualObjects(result, @3, nil);
    
    [k triggerVariable:2];
    result = [k eval];
    STAssertEqualObjects(result, @.5, nil);
    
    [k triggerVariable:1];
    result = [k eval];
    STAssertEqualObjects(result, @-2, nil);
    
    [k triggerVariable:0];
    result = [k eval];
    STAssertEqualObjects(result, @(3.0/2), nil);
    
    // (16) --2
    [k triggerOperator:XC_OP_MINUS];
    [k triggerOperator:XC_OP_MINUS];
    [k triggerNum:'2'];
    result = [k eval];
    STAssertEqualObjects(result, @2, nil);

    // (17) //2
    [k triggerOperator:XC_OP_DIV];
    [k triggerOperator:XC_OP_DIV];
    [k triggerNum:'2'];
    result = [k eval];
    STAssertEqualObjects(result, @2, nil);
    
    // (18) /-2
    [k triggerOperator:XC_OP_DIV];
    [k triggerOperator:XC_OP_MINUS];
    [k triggerNum:'2'];
    result = [k eval];
    STAssertEqualObjects(result, @-.5, nil);

    
 
}
@end

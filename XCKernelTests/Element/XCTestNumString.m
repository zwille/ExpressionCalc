//
//  XCTestNumString.m
//  XCCalc
//
//  Created by Christoph Cwelich on 16.12.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCTestNumString.h"
#import "XCNumString.h"
#import "XCExpr.h"

#import "XCHasTriggers.h"

@implementation XCTestNumString
-(void)testSimple {
    //assert legal chars '0'..'9', XC_PT
    XCNumString * n0 = [XCNumString numWithFirstChar:'0'];
    id<XCHasTriggers> head = [n0 triggerNum:XC_PT];
    STAssertEqualObjects([head description], @"0.", nil);
    head = [n0 triggerNum:XC_PT];
    NSString * expected = [NSString stringWithFormat:@"0%c",XC_PT];
    STAssertEqualObjects([head description], expected, nil);
    head = [n0 triggerNum:'5'];
    expected = [NSString stringWithFormat:@"0%c5",XC_PT];
    STAssertEqualObjects([head description], expected, nil);
    XCNumString * n1 = [XCNumString numWithString: expected];
    STAssertEqualObjects([n1 description], expected, nil);
    STAssertEqualObjects(@.5, [n0 eval], nil);
}
-(void)setUp {
    s = [XCStatement emptyStatement];
}
  /*
-(void)testComplex {
  
    XCNumString * n0 = [XCNumString numWithFirstChar:'0'];
    //XCExpr * e = [XCExpr expressionWithElement:n0 andRoot:nil];
    id<XCHasTriggers> head = nil;//[e head];
    STAssertEqualObjects(head, n0, nil);
    head = [n0 triggerVariable:0];
    STAssertEqualObjects(head, n0, nil);
    head = [n0 triggerConstant:XC_PI_ID];
    STAssertEqualObjects(head, n0, nil);
    head = [n0 triggerFunction:@"cos"];
    STAssertEqualObjects(head, n0, nil);
    head = [n0 triggerEnter];
    STAssertEqualObjects(head, n0, nil);
    head = [n0 triggerNext];
    STAssertNil(head, nil);
    head = [n0 triggerPrevious];
    STAssertNil(head, nil);
    head = [n0 triggerExpression];
    STAssertEqualObjects(head, n0, nil);
    head = [n0 triggerAssign:0];
    STAssertNil(head, nil);
    head = [n0 triggerOperator:XC_OP_PLUS];
    STAssertNil(head, nil);
    head = [n0 triggerOperator:XC_OP_MULT];
    STAssertNil(head, nil);
    head = [n0 triggerOperator:XC_OP_EXP];
    STAssertNil(head, nil);
    head = [n0 triggerNum:XC_PT];
    STAssertNil(head, nil);
    head = [n0 triggerNum:XC_PT]; //assert 2nd pt will be ignored
    STAssertNil(head, nil);
    head = [n0 triggerNum:'5'];
    XCNumString * n1 = [XCNumString numWithString:[NSString stringWithFormat:@"0%c5",XC_PT]];
    STAssertEqualObjects(n0, n1, nil);
    head = (XCElement*)[n0 triggerDel];
    STAssertEqualObjects([head description], @"0.", nil);
    head = (XCElement*)[n0 triggerDel];
    STAssertEqualObjects([head description], @"0", nil);
    head = [n0 triggerNum:XC_PT];
    STAssertEqualObjects([head description], @"0.", nil);
    head = (XCElement*)[n0 triggerDel];
    head = (XCElement*)[n0 triggerDel];
    STAssertNil(head,nil);
    STAssertEqualObjects(@1.5, [n1 eval], nil);
    
} */
-(void)testCopy {
    XCNumString * n0 = [XCNumString numWithString:[NSString stringWithFormat:@"0%c5",XC_PT]];
    STAssertEqualObjects(n0, [n0 copy], nil);
}

@end


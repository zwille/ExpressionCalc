//
//  XCExprTest.m
//  XCCalc
//
//  Created by Christoph Cwelich on 11.12.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCExprTest.h"
#import "XCExpr.h"

@implementation XCExprTest
-(void)testSimple {
    XCExpr * expr = [XCExpr emptyExpressionWithRoot:nil];
    id  head = [expr head];
    head = [head triggerNum:'7'];
    head = [head triggerOperator:XC_OP_PLUS];
    head = [head triggerNum:'3'];
    NSNumber * result = [expr eval];
    STAssertEqualObjects(result, @10, nil);
    head = [head triggerOperator:XC_OP_MINUS];
    head = [head triggerNum:'4'];
    result = [expr eval];
    STAssertEqualObjects(result, @6, nil);
}
-(void)testCopy {
    XCExpr * expr = [XCExpr emptyExpressionWithRoot:nil];
    id  head = [expr head];
    head = [head triggerNum:'7'];
    head = [head triggerOperator:XC_OP_PLUS];
    head = [head triggerNum:'3'];
   
    XCExpr * cp = [expr copy];
    head = [cp head];
    NSLog(@"head=%@",head);
    head = [head triggerOperator:XC_OP_MINUS];
    NSLog(@"head=%@",head);
    head = [head triggerNum:'4'];
    NSLog(@"expr=%@ cp=%@",expr,cp);
    NSNumber * result = [expr eval];
    STAssertEqualObjects(result, @10, nil);
    result = [cp eval];
    STAssertEqualObjects(result, @6, nil);
}
@end

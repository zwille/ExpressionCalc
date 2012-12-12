//
//  XCProdTest.m
//  XCCalc
//
//  Created by Christoph Cwelich on 12.12.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCProdTest.h"
#import "XCExpr.h"


@implementation XCProdTest
-(void)testSimple {
    XCExpr * expr = [XCExpr emptyExpressionWithRoot:nil];
    id  head = [expr head]; //spacer
    head = [head triggerNum:'4'];
    head = [head triggerOperator:XC_OP_MULT]; //prod
    head = [head triggerNum:'3']; 
    NSNumber * result = [expr eval];
    STAssertEqualObjects(result, @12, nil);
    head = [head triggerOperator:XC_OP_DIV];
    head = [head triggerNum:'2'];
    result = [expr eval];
    STAssertEqualObjects(result, @6, nil);
    //test operator binding
    head = [head triggerOperator:XC_OP_PLUS]; 
    head = [head triggerNum:'4'];
    result = [expr eval];
    STAssertEqualObjects(result, @10, nil);

}
@end

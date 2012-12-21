//
//  XCExprTest.m
//  XCCalc
//
//  Created by Christoph Cwelich on 11.12.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCExprTest.h"
#import "XCStatement.h"

@implementation XCExprTest
-(void)testSimple {
    XCStatement * s = [XCStatement emptyStatement];
    id  head = [s head];
    head = [head triggerNum:'7'];
    head = [head triggerOperator:XC_OP_PLUS];
    head = [head triggerNum:'3'];
    NSNumber * result = [s eval];
    STAssertEqualObjects(result, @10, nil);
    head = [head triggerOperator:XC_OP_MINUS];
    head = [head triggerNum:'4'];
    result = [s eval];
    STAssertEqualObjects(result, @6, nil);
}
-(void)testCopy {
    XCStatement * s = [XCStatement emptyStatement];
    id  head = [s head];
    head = [head triggerNum:'7'];
    head = [head triggerOperator:XC_OP_PLUS];
    head = [head triggerNum:'3'];
   
    XCStatement * cp = [s copy];
    head = [cp head];
    NSLog(@"head=%@",head);
    head = [head triggerOperator:XC_OP_MINUS];
    NSLog(@"head=%@",head);
    head = [head triggerNum:'4'];
    NSLog(@"expr=%@ cp=%@",s,cp);
    NSNumber * result = [s eval];
    STAssertEqualObjects(result, @10, nil);
    result = [cp eval];
    STAssertEqualObjects(result, @6, nil);
}
@end

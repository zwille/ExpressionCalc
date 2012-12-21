//
//  XCFunctionTest.m
//  XCCalc
//
//  Created by Christoph Cwelich on 16.12.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCFunctionTest.h"


@implementation XCFunctionTest
-(void)setUp {
    [[XCGlobal instance] setAngleAsDegree:YES];
    xccos0 = [XCFunction functionWithName:@"cos"
                             withElement:[XCNumString numWithString:@"0"]
                                 andParent:nil];
    xccos1 = [XCFunction functionWithName:@"cos"
                              withElement:[XCNumString numWithString:@"90"]
                                  andParent:nil];
    xcsqrt = [XCFunction functionWithName:@"√"
                             withElement:[XCNumString numWithString:@"2"]
                                 andParent:nil];
}
-(void)testSimple {
    STAssertEqualObjects([xccos0 eval], @1, nil);
    STAssertTrue([[xccos1 eval] isZero], nil);
    STAssertEqualObjects([xcsqrt eval], @(sqrt(2)), nil);
}
-(void)testCopy {
    NSLog(@">>> xccos0 %@",xccos0);
    NSLog(@">>> xccos1 %@",xccos1);
    NSLog(@">>> xcsqrt %@",xcsqrt);
    STAssertEqualObjects([[xccos0 copy] eval], @1, nil);
    STAssertTrue([[[xccos1 copy] eval] isZero], nil);
    STAssertEqualObjects([[xcsqrt copy] eval], @(sqrt(2)), nil);
    
}
@end

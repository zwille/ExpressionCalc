//
//  XCNegateTest.m
//  XCCalc
//
//  Created by Christoph Cwelich on 16.12.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCNegateTest.h"

@implementation XCNegateTest
-(void)setUp {
    n0 = [XCNegate negateValue:[XCNumString numWithString:@"-1"] withParent:nil];
    n1 = [XCNegate negateValue:[XCNumString numWithString:@"0"] withParent:nil];
    n2 = [XCNegate negateValue:[XCNumString numWithString:@"1"] withParent:nil];
}
-(void)testSimple {
    STAssertEqualObjects([n0 eval], @1, nil);
    STAssertEqualObjects([n1 eval], @0, nil);
    STAssertEqualObjects([n2 eval], @-1, nil);
}
-(void)testCopy{
    STAssertEqualObjects([[n0 copy] eval], @1, nil);
    STAssertEqualObjects([[n1 copy ]eval], @0, nil);
    STAssertEqualObjects([[n2 copy] eval], @-1, nil);
}
@end

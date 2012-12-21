//
//  XCTestNumString.m
//  XCCalc
//
//  Created by Christoph Cwelich on 16.12.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCTestNumString.h"
#import "XCNumString.h"
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
  

-(void)testCopy {
    XCNumString * n0 = [XCNumString numWithString:[NSString stringWithFormat:@"0%c5",XC_PT]];
    STAssertEqualObjects(n0, [n0 copy], nil);
}

@end


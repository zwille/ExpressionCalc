//
//  XCInvertTest.m
//  XCCalc
//
//  Created by Christoph Cwelich on 16.12.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCInvertTest.h"

@implementation XCInvertTest
-(void)setUp {
    invm2 = [XCInvert invertValue:[XCNumString numWithString:@"-2"] withRoot:nil];
    inv0 = [XCInvert invertValue:[XCNumString numWithString:@"0"] withRoot:nil];
    inv2 = [XCInvert invertValue:[XCNumString numWithString:@"2"] withRoot:nil];
}
-(void)testSimple {
    STAssertFalse([invm2 hasError], nil);
    STAssertEqualObjects([invm2 eval], @-0.5, nil);
    STAssertFalse([invm2 hasError], nil);
    
    STAssertFalse([inv0 hasError], nil);
    STAssertEqualObjects([inv0 eval], @(NAN), nil);
    STAssertTrue([inv0 hasError], nil);
    
    STAssertFalse([inv2 hasError], nil);
    STAssertEqualObjects([inv2 eval], @0.5, nil);
    STAssertFalse([inv2 hasError], nil);

}
-(void)testCopy {
    XCInvert * cpinvm2 = [invm2 copy];
    XCInvert * cpinv0 = [inv0 copy];
    XCInvert * cpinv2 = [inv2 copy];
    STAssertFalse([cpinvm2 hasError], nil);
    STAssertEqualObjects([cpinvm2 eval], @-0.5, nil);
    STAssertFalse([cpinvm2 hasError], nil);
    
    STAssertFalse([cpinv0 hasError], nil);
    STAssertEqualObjects([cpinv0 eval], @(NAN), nil);
    STAssertTrue([cpinv0 hasError], nil);
    
    STAssertFalse([cpinv2 hasError], nil);
    STAssertEqualObjects([cpinv2 eval], @0.5, nil);
    STAssertFalse([cpinv2 hasError], nil);
}
@end

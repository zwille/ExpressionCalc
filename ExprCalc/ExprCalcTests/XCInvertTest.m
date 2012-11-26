//
//  XCInvertTest.m
//  ExprCalc
//
//  Created by Christoph Cwelich on 25.11.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCInvertTest.h"
#import "XCInvert.h"
#import "XCNumber.h"

@implementation XCInvertTest

-(void)testInvertValue {
    uint len = 5;
    double vals[] = {-2.5,-1,0,1,2.5};
    double expecteds[] = {2.5,1,0,-1,-2.5};
    for (uint i=0; i<len; i++) {
        XCNumber * val = [XCNumber numberFromDouble:vals[i]];
        XCNumber * expected = [XCNumber numberFromDouble:expecteds[i]];
        XCNumber * actual = [XCInvert invertValue:val];
        STAssertEqualObjects(actual, expected, @"asserted %@, but was %@",expected,actual);
    }
}

@end

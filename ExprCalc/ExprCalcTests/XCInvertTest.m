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
    uint len = 4;
    double vals[] = {-2.5,-1,0,1,2.5};
    double expecteds[] = {-1/2.5, -1,NAN, 1,1/2.5};
    for (uint i=0; i<len; i++) {
        XCNumber * val = [XCNumber numberFromDouble:vals[i]];
        XCNumber * expected = [XCNumber numberFromDouble:expecteds[i]];
        XCInvert * actual = [XCInvert invertValue:val];
        STAssertEqualObjects([actual value], expected, @"asserted %@, but was %@",expected,[actual value]);
    }
}

@end

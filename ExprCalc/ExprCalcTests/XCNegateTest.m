//
//  XCNegateTest.m
//  ExprCalc
//
//  Created by Christoph Cwelich on 25.11.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCNegateTest.h"
#import "XCNumber.h"
#import "XCNegate.h"

@implementation XCNegateTest
-(void)testNegateValue {
    uint len = 5;
    double vals[] = {-2.5,-1,0,1,2.5};
    double expecteds[] = {2.5,1,0,-1,-2.5};
    for (uint i=0; i<len; i++) {
        XCNumber * val = [XCNumber numberFromDouble:vals[i]];
        XCNumber * expected = [XCNumber numberFromDouble:expecteds[i]];
        XCNegate * actual = [XCNegate negateValue:val];
        STAssertEqualObjects([actual value], expected, @"asserted %@, but was %@",expected,[actual value]);
    }
}
@end

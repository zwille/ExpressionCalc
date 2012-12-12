//
//  XCNumberTest.h
//  XCCalc
//
//  Created by Christoph Cwelich on 12.12.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "NSNumber+XCNumber.h"

@interface XCNumberTest : SenTestCase {
    //NSArray * nums;
    NSNumber * nan, * imin, * imax;
}
-(void) testSetUp;
    -(void) testAdd;
    -(void) testMult;
    -(void) testPow;
    -(void) testInvert;
    -(void) testNegate;


@end
/*
-(NSNumber*) addNum: (NSNumber*) rhs;
-(NSNumber*) multNum: (NSNumber*) rhs;
-(NSNumber*) powExp: (NSNumber*) exp;
-(NSNumber*) invert;
-(NSNumber*) negate;

-(BOOL) isInteger;
-(BOOL) isNaN;
-(BOOL) isZero;
*/
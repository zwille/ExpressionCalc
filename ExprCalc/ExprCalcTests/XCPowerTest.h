//
//  XCPowerTest.h
//  ExprCalc
//
//  Created by Christoph Cwelich on 27.11.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>

@interface XCPowerTest : SenTestCase
-(void) testParse;
-(void) testMalformed;
@end

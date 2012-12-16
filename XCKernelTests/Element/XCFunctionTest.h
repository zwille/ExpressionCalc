//
//  XCFunctionTest.h
//  XCCalc
//
//  Created by Christoph Cwelich on 16.12.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "XCFunction.h"
#import "XCNumString.h"
@interface XCFunctionTest : SenTestCase {
    XCFunction * xccos0, * xccos1, * xcsqrt;
}
-(void)testSimple;
-(void)testCopy;
@end

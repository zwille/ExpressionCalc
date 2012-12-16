//
//  XCNegateTest.h
//  XCCalc
//
//  Created by Christoph Cwelich on 16.12.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "XCNegate.h"
#import "XCNumString.h"

@interface XCNegateTest : SenTestCase {
    XCNegate * n0, * n1, * n2;
}
-(void)testSimple;
-(void)testCopy;
@end

//
//  XCStringIteratorTest.h
//  ExpressionCalc
//
//  Created by Christoph Cwelich on 20.11.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "XCStringIterator.h"

@interface XCStringIteratorTest : SenTestCase {
    XCStringIterator * inst1, *inst2, *inst3;
}
-(void)testIterator;
@end

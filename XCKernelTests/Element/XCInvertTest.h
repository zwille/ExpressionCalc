//
//  XCInvertTest.h
//  XCCalc
//
//  Created by Christoph Cwelich on 16.12.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "XCInvert.h"
#import "XCNumString.h"

@interface XCInvertTest : SenTestCase {
    XCInvert * invm2, * inv0, * inv2;
}
-(void)testSimple;
-(void)testCopy;
@end
